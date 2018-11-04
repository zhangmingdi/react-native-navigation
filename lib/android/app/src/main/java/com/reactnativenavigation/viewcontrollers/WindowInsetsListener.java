package com.reactnativenavigation.viewcontrollers;

import android.graphics.Point;
import android.support.v4.view.OnApplyWindowInsetsListener;
import android.support.v4.view.WindowInsetsCompat;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;

import com.reactnativenavigation.parse.StatusBarOptions;
import com.reactnativenavigation.utils.ViewUtils;

public class WindowInsetsListener implements OnApplyWindowInsetsListener {

    private ViewController viewController;

    public WindowInsetsListener(ViewController viewController) {
        this.viewController = viewController;
    }

    @Override
    public WindowInsetsCompat onApplyWindowInsets(View v, WindowInsetsCompat insets) {
        log(v, insets);
        Point loc = ViewUtils.getLocationOnScreen(v);
        ViewGroup.MarginLayoutParams params = (ViewGroup.MarginLayoutParams) v.getLayoutParams();
        int top = insets.getSystemWindowInsetTop();
        if (top == (loc.y + params.topMargin)) {
//        if (params.topMargin != insets.getSystemWindowInsetTop()) {
            params.topMargin = top;
            return insets.consumeSystemWindowInsets();
        }
        StatusBarOptions sbo = viewController.resolveCurrentOptions().statusBar;
//        if (sbo.drawBehind.isFalseOrUndefined() && sbo.visible.isTrueOrUndefined() && top == 0 && top != params.topMargin) {
//            params.topMargin = 0;
//            return insets.consumeSystemWindowInsets();
//        }
        return insets;
    }

    private void log(View v, WindowInsetsCompat insets) {
        Log.v("WindowInsetsListener",
                "view: " + v.getClass().getSimpleName() +
                " top: " + insets.getSystemWindowInsetTop());
    }
}
