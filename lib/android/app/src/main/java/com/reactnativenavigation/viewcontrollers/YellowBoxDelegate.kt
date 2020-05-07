package com.reactnativenavigation.viewcontrollers

import android.content.Context
import android.view.View
import android.view.ViewGroup
import androidx.annotation.RestrictTo
import com.reactnativenavigation.utils.UiUtils
import com.reactnativenavigation.utils.isDebug
import java.util.*

open class YellowBoxDelegate(private val context: Context, private val yellowBoxHelper: YellowBoxHelper = YellowBoxHelper()) {
    constructor(context: Context) : this(context, YellowBoxHelper())

    @get:RestrictTo(RestrictTo.Scope.TESTS)
    var parent: ViewGroup? = null
        private set
    @get:RestrictTo(RestrictTo.Scope.TESTS)
    val yellowBoxes: List<View>
        get() = yellowBoxViews

    private var isDestroyed = false
    private val yellowBoxViews = ArrayList<View>()

    open fun onChildViewAdded(parent: View, child: View?) {
        if (context.isDebug()) return
        UiUtils.runOnPreDrawOnce(child) {
            if (yellowBoxHelper.isYellowBox(parent, child)) {
                onYellowBoxAdded(parent)
            }
        }
    }

    fun onYellowBoxAdded(parent: View) {
        if (isDestroyed) return
        this.parent = parent as ViewGroup
        for (i in 1 until this.parent!!.childCount) {
            yellowBoxViews.add(this.parent!!.getChildAt(i))
            this.parent!!.removeView(this.parent!!.getChildAt(i))
            this.parent!!.addView(View(parent.getContext()), i)
        }
    }

    fun destroy() {
        isDestroyed = true
        if (yellowBoxViews.isNotEmpty()) {
            for (view in yellowBoxViews) {
                parent!!.addView(view)
            }
        }
    }
}