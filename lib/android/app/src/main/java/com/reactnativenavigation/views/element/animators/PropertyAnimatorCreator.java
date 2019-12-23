package com.reactnativenavigation.views.element.animators;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.view.View;
import android.view.ViewGroup;

import com.reactnativenavigation.parse.Transition;

import java.lang.reflect.ParameterizedType;
import java.util.Collections;
import java.util.List;

import androidx.annotation.CallSuper;

public abstract class PropertyAnimatorCreator<T> {

    protected View from;
    protected View to;

    PropertyAnimatorCreator(View from, View to) {
        this.from = from;
        this.to = to;
    }

    @CallSuper
    public boolean shouldAnimateProperty() {
        Class<T> type = getChildClass();
        return type.isInstance(from) &&
               type.isInstance(to) &&
               !excludedViews().contains(from.getClass()) &&
               !excludedViews().contains(to.getClass()) &&
               shouldAnimateProperty((T) from, (T) to);
    }

    protected abstract boolean shouldAnimateProperty(T fromChild, T toChild);

    protected List<Class> excludedViews() {
        return Collections.emptyList();
    }

    public Animator create(Transition transition) {
        Animator animator = create().setDuration(transition.duration.get());
        animator.addListener(new AnimatorListenerAdapter() {
            private final boolean originalClipChildren = ((ViewGroup) to.getParent()).getClipChildren();
            @Override
            public void onAnimationStart(Animator animation) {
                ((ViewGroup) to.getParent()).setClipChildren(false);
            }

            @Override
            public void onAnimationEnd(Animator animation) {
                ((ViewGroup) to.getParent()).setClipChildren(originalClipChildren);
            }
        });
        return animator;
    }

    protected abstract Animator create();

    private Class<T> getChildClass() {
        return (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
    }
}
