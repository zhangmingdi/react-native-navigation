package com.reactnativenavigation.views.element

import android.animation.AnimatorSet

abstract class Transition {
    abstract fun createAnimators(): AnimatorSet
}