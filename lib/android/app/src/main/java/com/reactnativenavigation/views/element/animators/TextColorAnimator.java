package com.reactnativenavigation.views.element.animators;

import android.animation.Animator;
import android.animation.ObjectAnimator;
import android.view.View;
import android.widget.TextView;

import com.facebook.react.views.text.ReactTextView;
import com.reactnativenavigation.utils.ColorUtils;
import com.reactnativenavigation.utils.TextViewUtils;

import static com.reactnativenavigation.utils.TextViewUtils.getTextColor;

public class TextColorAnimator extends PropertyAnimatorCreator<ReactTextView> {

    public TextColorAnimator(View from, View to) {
        super(from, to);
    }

    @Override
    protected boolean shouldAnimateProperty(ReactTextView fromChild, ReactTextView toChild) {
        return getTextColor(fromChild) != getTextColor(toChild);
    }

    @Override
    public Animator create() {
        return ObjectAnimator.ofObject(
                to,
                "textColor",
                new LabColorEvaluator(),
                ColorUtils.colorToLAB(TextViewUtils.getTextColor((TextView) from)),
                ColorUtils.colorToLAB(TextViewUtils.getTextColor((TextView) to))
        );
    }
}
