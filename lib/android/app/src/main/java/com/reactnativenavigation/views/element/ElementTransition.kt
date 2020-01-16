package com.reactnativenavigation.views.element

import android.animation.AnimatorSet
import android.view.View
import com.reactnativenavigation.parse.ElementTransitionOptions

class ElementTransition(private val transitionOptions: ElementTransitionOptions) : Transition() {
    val id: String
        get() = transitionOptions.id
    lateinit var fromView: View
    lateinit var toView: View
    val view: View
        get() = if (::fromView.isInitialized) fromView else toView

    fun isValid(): Boolean {
        return (::fromView.isInitialized && !::toView.isInitialized) ||
                (!::fromView.isInitialized && ::toView.isInitialized)
    }

    override fun createAnimators(): AnimatorSet {
        return transitionOptions.getAnimation(view)
    }
}