package com.reactnativenavigation.presentation;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.Point;
import android.os.Build;
import android.support.v4.view.WindowInsetsCompat;
import android.view.View;
import android.view.ViewGroup.MarginLayoutParams;

import com.reactnativenavigation.parse.NavigationBarOptions;
import com.reactnativenavigation.parse.Options;
import com.reactnativenavigation.parse.OrientationOptions;
import com.reactnativenavigation.parse.StatusBarOptions;
import com.reactnativenavigation.parse.StatusBarOptions.TextColorScheme;
import com.reactnativenavigation.parse.params.Bool;
import com.reactnativenavigation.utils.UiUtils;
import com.reactnativenavigation.utils.ViewUtils;

@SuppressWarnings("FieldCanBeLocal")
public class Presenter {

    private Activity activity;
    private Options defaultOptions;

    public Options getDefaultOptions() {
        return defaultOptions;
    }

    public Presenter(Activity activity, Options defaultOptions) {
        this.activity = activity;
        this.defaultOptions = defaultOptions;
    }

    public void setDefaultOptions(Options defaultOptions) {
        this.defaultOptions = defaultOptions;
    }

    public void mergeOptions(View view, Options options) {
        mergeStatusBarOptions(view, options.statusBar);
    }

    public void applyOptions(View view, Options options) {
        Options withDefaultOptions = options.copy().withDefaultOptions(defaultOptions);
        applyOrientation(withDefaultOptions.layout.orientation);
        applyViewOptions(view, withDefaultOptions);
        applyStatusBarOptions(withDefaultOptions.statusBar);
    }

    public void applyRootOptions(View view, Options options) {
        Options withDefaultOptions = options.copy().withDefaultOptions(defaultOptions);
        setDrawBehindStatusBar(view, withDefaultOptions.statusBar);
    }

    public void onViewBroughtToFront(Options options) {
        Options withDefaultOptions = options.copy().withDefaultOptions(defaultOptions);
        applyStatusBarOptions(withDefaultOptions.statusBar);
    }

    private void applyOrientation(OrientationOptions options) {
        activity.setRequestedOrientation(options.getValue());
    }

    private void applyViewOptions(View view, Options options) {
        if (options.layout.backgroundColor.hasValue()) {
            view.setBackgroundColor(options.layout.backgroundColor.get());
        }
        applyTopMargin(view, options);
    }

    private void applyTopMargin(View view, Options options) {
        if (view.getLayoutParams() instanceof MarginLayoutParams && options.layout.topMargin.hasValue()) {
            ((MarginLayoutParams) view.getLayoutParams()).topMargin = options.layout.topMargin.get(0);
        }
    }

    public void applyNavigationBarOptions(NavigationBarOptions navigationBar) {
        View view = activity.getWindow().getDecorView();
        int visibility = view.getSystemUiVisibility();
        if (navigationBar.drawBehind.isTrueOrUndefined()) {
            visibility |= View.SYSTEM_UI_FLAG_IMMERSIVE;
        } else {
            visibility &= ~View.SYSTEM_UI_FLAG_IMMERSIVE;
        }
        view.setSystemUiVisibility(visibility);
    }

    private void applyStatusBarOptions(StatusBarOptions statusBar) {
        setStatusBarBackgroundColor(statusBar);
        setTextColorScheme(statusBar.textColorScheme);
    }

    public void applyStatusBarVisible(StatusBarOptions statusBar) {
        View view = activity.getWindow().getDecorView();
        int visibility = view.getSystemUiVisibility();
        if (statusBar.visible.isFalse()) {
             visibility |= View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                        | View.SYSTEM_UI_FLAG_FULLSCREEN
                        | View.SYSTEM_UI_FLAG_LAYOUT_STABLE;
            view.setSystemUiVisibility(visibility);
        } else if (statusBar.drawBehind.isTrue()) {
            visibility |= View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN;
            view.setSystemUiVisibility(visibility);
        } else if (statusBar.visible.isTrueOrUndefined()) {
//            visibility = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
//                          | View.SYSTEM_UI_FLAG_LAYOUT_STABLE;
            visibility &= ~View.SYSTEM_UI_FLAG_FULLSCREEN;
            view.setSystemUiVisibility(visibility);
        }
    }

    private void setStatusBarBackgroundColor(StatusBarOptions statusBar) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            activity.getWindow().setStatusBarColor(statusBar.backgroundColor.get(Color.BLACK));
        }
    }

    private void setTextColorScheme(TextColorScheme scheme) {
        final View view = activity.getWindow().getDecorView();
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return;
        if (scheme == TextColorScheme.Dark) {
            int flags = view.getSystemUiVisibility();
            flags |= View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
            view.setSystemUiVisibility(flags);
        } else {
            clearDarkTextColorScheme(view);
        }
    }

    private static void clearDarkTextColorScheme(View view) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return;
        int flags = view.getSystemUiVisibility();
        flags &= ~View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
        view.setSystemUiVisibility(flags);
    }

    private void setDrawBehindStatusBar(View view, StatusBarOptions statusBar) {
        if (statusBar.visible.isFalse()) {
            ((MarginLayoutParams) view.getLayoutParams()).topMargin = statusBar.drawBehind.isTrue() ?
                    0 : UiUtils.getStatusBarHeight(activity);
        }
    }


    private void mergeStatusBarOptions(View view, StatusBarOptions statusBar) {
        mergeStatusBarBackgroundColor(statusBar);
        mergeTextColorScheme(statusBar.textColorScheme);
        mergeStatusBarVisible(view, statusBar.visible, statusBar.drawBehind);
    }

    private void mergeStatusBarBackgroundColor(StatusBarOptions statusBar) {
        if (statusBar.backgroundColor.hasValue() && Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            activity.getWindow().setStatusBarColor(statusBar.backgroundColor.get(Color.BLACK));
        }
    }

    private void mergeTextColorScheme(TextColorScheme scheme) {
        if (!scheme.hasValue() || Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return;
        final View view = activity.getWindow().getDecorView();
        if (scheme == TextColorScheme.Dark) {
            int flags = view.getSystemUiVisibility();
            flags |= View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
            view.setSystemUiVisibility(flags);
        } else {
            clearDarkTextColorScheme(view);
        }
    }

    private void mergeStatusBarVisible(View view, Bool visible, Bool drawBehind) {
        if (visible.hasValue()) {
            int flags = view.getSystemUiVisibility();
            if (visible.isTrue()) {
                flags &= ~View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN & ~View.SYSTEM_UI_FLAG_FULLSCREEN;
            } else {
                flags |= View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_FULLSCREEN;
            }
            view.setSystemUiVisibility(flags);
        } else if (drawBehind.hasValue()) {
            if (drawBehind.isTrue()) {
                view.setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
            } else {
                view.setSystemUiVisibility(~View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
            }
        }
    }

    public void applyBottomInsets(WindowInsetsCompat insets, Options options, View view) {
        MarginLayoutParams lp = (MarginLayoutParams) view.getLayoutParams();
//        lp.bottomMargin = insets.getSystemWindowInsetBottom();
    }

    public void applyInsets(WindowInsetsCompat insets, Options options, View view) {
        MarginLayoutParams lp = (MarginLayoutParams) view.getLayoutParams();
        Point loc = ViewUtils.getLocationOnScreen(view);
        if (isDrawnBehind(options)) {
            lp.topMargin = 0;
        } else {
            lp.topMargin = insets.getStableInsetTop();
        }
    }

    private boolean isDrawnBehind(Options options) {
        return options
                .statusBar
                .drawBehind
                .get(false);
    }
}
