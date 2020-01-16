package com.reactnativenavigation.views.element.animators;

import android.animation.Animator;
import android.view.View;

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

    public abstract Animator create();

    private Class<T> getChildClass() {
        return (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
    }
}
