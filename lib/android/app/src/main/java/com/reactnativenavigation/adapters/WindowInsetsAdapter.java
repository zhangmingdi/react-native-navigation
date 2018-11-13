package com.reactnativenavigation.adapters;

import android.support.v4.view.OnApplyWindowInsetsListener;
import android.support.v4.view.ViewCompat;
import android.support.v4.view.WindowInsetsCompat;
import android.view.View;
import android.view.ViewGroup;

public class WindowInsetsAdapter {
    public WindowInsetsCompat onApplyWindowInsets(View view, WindowInsetsCompat insets) {
        return ViewCompat.onApplyWindowInsets(view, insets);
    }

    public void requestApplyInsets(ViewGroup view) {
        ViewCompat.requestApplyInsets(view);
    }

    public void setOnApplyWindowInsetsListener(View view, OnApplyWindowInsetsListener listener) {
        ViewCompat.setOnApplyWindowInsetsListener(view, listener);
    }
}
