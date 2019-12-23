package com.reactnativenavigation.views.element.animators;

import android.animation.Animator;
import android.graphics.Point;
import android.view.View;
import android.widget.TextView;

import com.facebook.react.views.text.ReactTextView;
import com.reactnativenavigation.utils.ViewUtils;
import com.shazam.android.widget.text.reflow.ReflowTextAnimatorHelper;

import static com.reactnativenavigation.utils.TextViewUtils.getTextSize;

public class TextChangeAnimator extends PropertyAnimatorCreator<ReactTextView> {

    public TextChangeAnimator(View from, View to) {
        super(from, to);
    }

    @Override
    protected boolean shouldAnimateProperty(ReactTextView fromChild, ReactTextView toChild) {
        Point fromXy = ViewUtils.getLocationOnScreen(from);
        Point toXy = ViewUtils.getLocationOnScreen(to);
        return getTextSize(fromChild) != getTextSize(toChild) ||
               !fromXy.equals(toXy.x, toXy.y);
    }

    @Override
    public Animator create() {
        return new ReflowTextAnimatorHelper
                .Builder((TextView) from, (TextView) to)
                .calculateDuration(false)
                .buildAnimator();
    }
}
