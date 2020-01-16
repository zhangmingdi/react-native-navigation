package com.reactnativenavigation.views.element

import android.animation.Animator
import android.animation.AnimatorListenerAdapter
import android.animation.AnimatorSet
import android.view.View
import com.reactnativenavigation.R
import com.reactnativenavigation.parse.AnimationOptions
import com.reactnativenavigation.utils.CollectionUtils
import com.reactnativenavigation.utils.ViewUtils
import com.reactnativenavigation.viewcontrollers.ViewController
import java.util.*

open class TransitionAnimatorCreator {
    fun create(toScreen: ViewController<*>, fadeAnimation: AnimationOptions, transitions: TransitionSet): AnimatorSet {
//        if (transitions.isEmpty()) return new AnimatorSet();
        transitions.registerViewIndexInParent()
        val animators: MutableCollection<Animator> = ArrayList()
        animators.addAll(createSharedElementTransitionAnimators(toScreen, transitions.validSharedElementTransitions))
        animators.addAll(createElementTransitionAnimators(transitions.validElementTransitions))
        for (set in animators) {
            for (animator in (set as AnimatorSet).childAnimations) {
                animator.duration = fadeAnimation.duration.toLong()
            }
        }
        //        for (ElementTransitionOptions transition : transitions.validElementTransitions) {
//            View fromView = from.get(transition.getId());
//            View toView = to.get(transition.getId());
//            ViewController screen = fromView == null ? toScreen : fromScreen;
//            animators.add(create(fadeAnimation, transition, screen, ObjectUtils.take(fromView, toView)));
//        }
        val set = AnimatorSet()
        set.addListener(object : AnimatorListenerAdapter() {
            override fun onAnimationEnd(animation: Animator) {
                restoreViewsToOriginalState()
            }

            override fun onAnimationCancel(animation: Animator) {
                restoreViewsToOriginalState()
            }

            private fun restoreViewsToOriginalState() {
                val allTransitions = mutableListOf<Transition>()
                allTransitions.addAll(transitions.validSharedElementTransitions)
                allTransitions.addAll(transitions.validElementTransitions)
                allTransitions.sortBy { it.view.getTag(R.id.original_index_in_parent) as Int}
                allTransitions.forEach {
                    it.viewController.requireParentController().removeOverlay(it.view)
                    ViewUtils.returnToOriginalParent(it.view)
                }
                CollectionUtils.forEach(transitions.validSharedElementTransitions) { transition: SharedElementTransition ->
//                    toScreen.removeOverlay(transition.to)
//                    ViewUtils.returnToOriginalParent(transition.to)
                    transition.from.alpha = 1f
                }
//                CollectionUtils.forEach(transitions.validElementTransitions) { transition: ElementTransition ->
//                    transition.viewController.removeOverlay(transition.view)
//                    ViewUtils.returnToOriginalParent(transition.view)
//                }
            }
        })
        set.playTogether(animators)
        return set
    }

    private fun createSharedElementTransitionAnimators(toScreen: ViewController<*>, transitions: List<SharedElementTransition>): List<AnimatorSet> {
        val animators: MutableList<AnimatorSet> = ArrayList()
        for (transition in transitions) {
            animators.add(createSharedElementAnimator(toScreen, transition))
        }
        return animators
    }

    private fun createSharedElementAnimator(toScreen: ViewController<*>, transition: SharedElementTransition): AnimatorSet {
        ViewUtils.reparent(transition.to) { child: View? -> toScreen.requireParentController().addOverlay(child) }
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
            ViewUtils.reparent(transition.view) { view: View? -> transition.viewController.addOverlay(view) }
            animators.add(transition.createAnimators())
        }
        return animators
    }
}