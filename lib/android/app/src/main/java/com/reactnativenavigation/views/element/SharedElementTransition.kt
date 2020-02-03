package com.reactnativenavigation.views.element

import android.animation.AnimatorSet
import android.view.View
import com.reactnativenavigation.parse.SharedElementTransitionOptions
import com.reactnativenavigation.viewcontrollers.ViewController
import com.reactnativenavigation.views.element.animators.*

class SharedElementTransition(private val appearing: ViewController<*>, private val disappearing: ViewController<*>, private val options: SharedElementTransitionOptions) : Transition() {
    val fromId: String = options.fromId.get()
    val toId: String = options.toId.get()
    lateinit var from: View
    lateinit var to: View
    override var viewController: ViewController<*> = appearing
    override val view: View
        get() = to
    override val topInset: Int
        get() = viewController.topInset
    override val topInsetDelta: Int
        get() = disappearing.topInset - appearing.topInset

    fun isValid(): Boolean = this::from.isInitialized

    override fun createAnimators(): AnimatorSet {
        val animators = animators()
                .filter { it.shouldAnimateProperty() }
                .map { it.create(options) }
        val set = AnimatorSet()
        set.playTogether(animators)
        return set
    }

    private fun animators(): List<PropertyAnimatorCreator<*>> {
        return listOf(
                XAnimator(from, to),
                YAnimator(this, from, to),
                MatrixAnimator(this, from, to),
                ScaleXAnimator(from, to),
                ScaleYAnimator(from, to),
                BackgroundColorAnimator(from, to),
                TextChangeAnimator(this, from, to)
        )
    }
}