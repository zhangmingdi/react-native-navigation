package com.reactnativenavigation.utils;

import android.support.annotation.Nullable;

public class ObjectUtils {
    public interface Action<T> {
        void performOn(T it);
    }

    public interface Action1<T, S> {
        S performOn(T it);
    }

    public static <T> void perform(@Nullable T it, Action<T> action) {
        if (it != null) action.performOn(it);
    }

    public static <T, S> S perform(T it, Action1<T, S> action) {
        return action.performOn(it);
    }
}
