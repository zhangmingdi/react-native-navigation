package com.reactnativenavigation.views;

import android.content.Context;
import android.graphics.Point;
import android.support.annotation.NonNull;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.reactnativenavigation.utils.ViewUtils;

public class RootFrameLayout extends FrameLayout {

    public RootFrameLayout(@NonNull Context context) {
        super(context);
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
        ViewGroup.LayoutParams lp = getLayoutParams();
        Point loc = ViewUtils.getLocationOnScreen(this);
        Log.i("RootFrameLayout", "onMeasure height: " + getHeight() + " y: " + loc.y + " b: " + getBottom());
    }
}
