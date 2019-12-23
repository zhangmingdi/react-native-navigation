package com.reactnativenavigation.views.element.animators;

import android.animation.Animator;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.graphics.Rect;
import android.view.View;

import com.facebook.drawee.drawable.ScalingUtils;
import com.facebook.drawee.generic.GenericDraweeHierarchy;
import com.facebook.drawee.view.DraweeView;
import com.facebook.react.views.image.ReactImageView;

import static com.reactnativenavigation.utils.ViewUtils.areDimensionsEqual;

public class MatrixAnimator extends PropertyAnimatorCreator<ReactImageView> {

    public MatrixAnimator(View from, View to) {
        super(from, to);
    }

    @Override
    public boolean shouldAnimateProperty(ReactImageView fromChild, ReactImageView toChild) {
        return !areDimensionsEqual(from, to);
    }

    @Override
    public Animator create() {
        AnimatorSet set = new AnimatorSet();
        set.playTogether(clipBoundsAnimator(), imageTransformAnimator());
        return set;
    }

    private Animator clipBoundsAnimator() {
        Rect startDrawingRect = new Rect(); from.getDrawingRect(startDrawingRect);
        Rect endDrawingRect = new Rect(); to.getDrawingRect(endDrawingRect);
        return ObjectAnimator.ofObject(to,
                "clipBounds",
                new ClipBoundsEvaluator(),
                startDrawingRect,
                endDrawingRect);
    }

    private Animator imageTransformAnimator() {
        ScalingUtils.InterpolatingScaleType ist = new ScalingUtils.InterpolatingScaleType(
                getScaleType(from),
                getScaleType(to),
                calculateBounds(from),
                calculateBounds(to)
        );
        ((DraweeView<GenericDraweeHierarchy>) to).getHierarchy().setActualImageScaleType(ist);
        return ObjectAnimator.ofObject((fraction, startValue, endValue) -> {
            GenericDraweeHierarchy hierarchy = ((DraweeView<GenericDraweeHierarchy>) to).getHierarchy();
            if (hierarchy.getActualImageScaleType() != null) {
                ((ScalingUtils.InterpolatingScaleType) hierarchy.getActualImageScaleType()).setValue(fraction);
                to.invalidate();
            }
            return null;
        }, 0, 1);
    }

    private ScalingUtils.ScaleType getScaleType(View child) {
        return ((DraweeView<GenericDraweeHierarchy>) child).getHierarchy().getActualImageScaleType();
    }

    private Rect calculateBounds(View view) {
        return new Rect(0, 0, view.getWidth(), view.getHeight());
    }
}
