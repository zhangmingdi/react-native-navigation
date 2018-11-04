package com.reactnativenavigation.utils;

import android.app.Activity;
import android.view.View;

public class StatusBarHelper {
    public static boolean isShown(Activity activity) {
        View decorView = activity.getWindow().getDecorView();
        return (decorView.getSystemUiVisibility() & View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN) == 0;
    }
}
