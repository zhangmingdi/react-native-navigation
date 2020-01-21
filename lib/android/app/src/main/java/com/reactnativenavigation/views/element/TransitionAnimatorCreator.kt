package com.reactnativenavigation.views.element

import android.animation.Animator
import android.animation.AnimatorListenerAdapter
import android.animation.AnimatorSet
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.core.animation.doOnCancel
import androidx.core.animation.doOnEnd
import com.facebook.react.uimanager.ViewGroupManager
import com.reactnativenavigation.R
import com.reactnativenavigation.parse.AnimationOptions
import com.reactnativenavigation.utils.ViewTags
import com.reactnativenavigation.utils.ViewUtils
import com.reactnativenavigation.viewcontrollers.ViewController
import java.util.*

open class TransitionAnimatorCreator {
    fun create(fadeAnimation: AnimationOptions, transitions: TransitionSet): AnimatorSet {
        if (transitions.size() == 0) return AnimatorSet()
        reparentViews(transitions)
        val animators = ArrayList<Animator>()
        animators.addAll(createSharedElementTransitionAnimators(transitions.validSharedElementTransitions))
        animators.addAll(createElementTransitionAnimators(transitions.validElementTransitions))

        setAnimatorsDuration(animators, fadeAnimation)
        val set = AnimatorSet()
        set.doOnEnd { restoreViewsToOriginalState(transitions) }
        set.doOnCancel { restoreViewsToOriginalState(transitions) }
        set.playTogether(animators)
        return set
    }

    private fun setAnimatorsDuration(animators: Collection<Animator>, fadeAnimation: AnimationOptions) {
        for (animator in animators) {
            if (animator is AnimatorSet) {
                setAnimatorsDuration(animator.childAnimations, fadeAnimation)
            } else if (animator.duration.toInt() <= 0) {
                animator.duration = fadeAnimation.duration.toLong()
            }
        }
    }

    private fun reparentViews(transitions: TransitionSet) {
        transitions.transitions
                .sortedBy { ViewGroupManager.getViewZIndex(it.view) }
                .forEach {
                    reparent(it.viewController.requireParentController(), it.view)
                }
    }

    private fun createSharedElementTransitionAnimators(transitions: List<SharedElementTransition>): List<AnimatorSet> {
        val animators: MutableList<AnimatorSet> = ArrayList()
        for (transition in transitions) {
            animators.add(createSharedElementAnimator(transition))
        }
        return animators
    }

    private fun createSharedElementAnimator(transition: SharedElementTransition): AnimatorSet {
        val set = AnimatorSet()
        set.playTogether(transition.createAnimators())
        set.addListener(object : AnimatorListenerAdapter() {
            override fun onAnimationStart(animation: Animator) {
                transition.from.alpha = 0f
            }
        })
        return set
    }

    private fun createElementTransitionAnimators(transitions: List<ElementTransition>): List<AnimatorSet> {
        val animators: MutableList<AnimatorSet> = ArrayList()
        for (transition in transitions) {
            animators.add(transition.createAnimators())
        }
        return animators
    }

    private fun restoreViewsToOriginalState(transitions: TransitionSet) {
        val allTransitions = mutableListOf<Transition>()
        allTransitions.addAll(transitions.validSharedElementTransitions)
        allTransitions.addAll(transitions.validElementTransitions)
        allTransitions.sortBy { ViewGroupManager.getViewZIndex(it.view) }
        allTransitions.forEach {
            it.viewController.requireParentController().removeOverlay(it.view)
            returnToOriginalParent(it.view)
        }
        transitions.validSharedElementTransitions.forEach {
            it.from.alpha = 1f
        }
    }

    private fun reparent(vc: ViewController<*>, element: View) {
        val biologicalParent = element.parent as ViewGroup
        element.setTag(R.id.original_parent, biologicalParent)
        element.setTag(R.id.original_layout_params, element.layoutParams)
        element.setTag(R.id.original_top, element.top)
        element.setTag(R.id.original_bottom, element.bottom)
        element.setTag(R.id.original_right, element.right)
        element.setTag(R.id.original_left, element.left)

        val loc = ViewUtils.getLocationOnScreen(element)
        biologicalParent.removeView(element)

        val lp = FrameLayout.LayoutParams(element.layoutParams)
        lp.topMargin = loc.y
        lp.leftMargin = loc.x
        lp.width = element.width
        lp.height = element.height
        element.layoutParams = lp
        vc.addOverlay(element)
    }

    private fun returnToOriginalParent(element: View) {
        ViewUtils.removeFromParent(element)
        element.top = ViewTags.get(element, R.id.original_top)
        element.bottom = ViewTags.get(element, R.id.original_bottom)
        element.right = ViewTags.get(element, R.id.original_right)
        element.left = ViewTags.get(element, R.id.original_left)
        val parent = ViewTags.get<ViewGroup>(element, R.id.original_parent)
        val lp = ViewTags.get<ViewGroup.LayoutParams>(element, R.id.original_layout_params)
        parent.addView(element, lp)
    }
}