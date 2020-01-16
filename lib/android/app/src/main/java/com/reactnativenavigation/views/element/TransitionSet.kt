package com.reactnativenavigation.views.element

import com.reactnativenavigation.R
import com.reactnativenavigation.utils.ViewUtils
import java.util.*

class TransitionSet {
    var validSharedElementTransitions: MutableList<SharedElementTransition> = ArrayList()
    var validElementTransitions: MutableList<ElementTransition> = ArrayList()
    val isEmpty: Boolean
        get() = validSharedElementTransitions.isEmpty() && validElementTransitions.isEmpty()

    fun add(transition: SharedElementTransition) {
        validSharedElementTransitions.add(transition)
    }

    fun add(transition: ElementTransition) {
        validElementTransitions.add(transition)
    }

    fun size(): Int {
        return validElementTransitions.size + validSharedElementTransitions.size
    }

    fun registerViewIndexInParent() {
        for (transition in validSharedElementTransitions) {
            val indexInParent = ViewUtils.getIndexInParent(transition.to)
            transition.to.setTag(R.id.original_index_in_parent, indexInParent)
        }
        for (transition in validElementTransitions) {
            val indexInParent = ViewUtils.getIndexInParent(transition.view)
            transition.view.setTag(R.id.original_index_in_parent, indexInParent)
        }
    }
}