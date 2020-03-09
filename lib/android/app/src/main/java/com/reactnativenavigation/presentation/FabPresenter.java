package com.reactnativenavigation.presentation;


import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;

import com.reactnativenavigation.R;
import com.reactnativenavigation.parse.FabOptions;
import com.reactnativenavigation.viewcontrollers.ViewController;
import com.reactnativenavigation.views.Fab;

import androidx.annotation.NonNull;
import androidx.coordinatorlayout.widget.CoordinatorLayout;

import static android.view.ViewGroup.LayoutParams.WRAP_CONTENT;
import static com.google.android.material.floatingactionbutton.FloatingActionButton.SIZE_MINI;
import static com.google.android.material.floatingactionbutton.FloatingActionButton.SIZE_NORMAL;
import static com.reactnativenavigation.utils.ObjectUtils.perform;

public class FabPresenter {
    private ViewGroup viewGroup;
    private ViewController component;

    private Fab fab;

    public void applyOptions(FabOptions options, @NonNull ViewController component, @NonNull ViewGroup viewGroup) {
        this.viewGroup = viewGroup;
        this.component = component;

        if (options.id.hasValue()) {
            if (fab != null && fab.getFabId().equals(options.id.get())) {
                fab.bringToFront();
                applyFabOptions(fab, options);
                setParams(fab, options);
                fab.setOnClickListener(v -> component.sendOnNavigationButtonPressed(options.id.get()));
            } else {
                createFab(options);
            }
        } else {
            removeFab();
        }
    }

    public void mergeOptions(FabOptions options, @NonNull ViewController component, @NonNull ViewGroup viewGroup) {
        this.viewGroup = viewGroup;
        this.component = component;
        if (options.id.hasValue()) {
            if (fab != null && fab.getFabId().equals(options.id.get())) {
                mergeParams(fab, options);
                fab.bringToFront();
                mergeFabOptions(fab, options);
                fab.setOnClickListener(v -> component.sendOnNavigationButtonPressed(options.id.get()));
            } else {
                createFab(options);
            }
        }
    }

    private void createFab(FabOptions options) {
        fab = new Fab(viewGroup.getContext(), options.id.get());
        setParams(fab, options);
        applyFabOptions(fab, options);
        fab.setOnClickListener(v -> component.sendOnNavigationButtonPressed(options.id.get()));
        viewGroup.addView(fab);
    }

    private void removeFab() {
        if (fab != null) {
            fab.hide();
            viewGroup.removeView(fab);
            fab = null;
        }
    }

    private void setParams(View fab, FabOptions options) {
        CoordinatorLayout.LayoutParams lp = new CoordinatorLayout.LayoutParams(WRAP_CONTENT, WRAP_CONTENT);
        lp.rightMargin = (int) viewGroup.getContext().getResources().getDimension(R.dimen.margin);
        lp.leftMargin = (int) viewGroup.getContext().getResources().getDimension(R.dimen.margin);
        lp.bottomMargin = (int) viewGroup.getContext().getResources().getDimension(R.dimen.margin);
        fab.setTag(R.id.fab_bottom_margin, lp.bottomMargin);
        lp.gravity = Gravity.BOTTOM;
        if (options.alignHorizontally.hasValue()) {
            if ("right".equals(options.alignHorizontally.get())) {
                lp.gravity |= Gravity.RIGHT;
            }
            if ("left".equals(options.alignHorizontally.get())) {
                lp.gravity |= Gravity.LEFT;
            }
        } else {
            lp.gravity |= Gravity.RIGHT;
        }
        fab.setLayoutParams(lp);
    }

    private void mergeParams(View fab, FabOptions options) {
        CoordinatorLayout.LayoutParams lp = (CoordinatorLayout.LayoutParams) perform(
                fab,
                new CoordinatorLayout.LayoutParams(WRAP_CONTENT, WRAP_CONTENT),
                View::getLayoutParams
        );
        fab.setTag(R.id.fab_bottom_margin, lp.leftMargin);
        lp.gravity = Gravity.BOTTOM;
        if (options.alignHorizontally.hasValue()) {
            if ("right".equals(options.alignHorizontally.get())) {
                lp.gravity |= Gravity.RIGHT;
            }
            if ("left".equals(options.alignHorizontally.get())) {
                lp.gravity |= Gravity.LEFT;
            }
        } else {
            lp.gravity |= Gravity.RIGHT;
        }
        fab.setLayoutParams(lp);
    }

    private void applyFabOptions(Fab fab, FabOptions options) {
        if (options.visible.isTrueOrUndefined()) {
            fab.show();
        }
        if (options.visible.isFalse()) {
            fab.hide();
        }
        if (options.backgroundColor.hasValue()) {
            fab.setBackgroundColor(options.backgroundColor.get());
        }
        if (options.clickColor.hasValue()) {
            fab.setRippleColor(options.clickColor.get());
        }
        if (options.icon.hasValue()) {
            fab.applyIcon(options.icon.get(), options.iconColor);
        }
        if (options.size.hasValue()) {
            fab.setSize("mini".equals(options.size.get()) ? SIZE_MINI : SIZE_NORMAL);
        }
        if (options.hideOnScroll.isTrue() && options.visible.isTrueOrUndefined()) {
            fab.enableCollapse(component.getScrollEventListener());
        }
        if (options.hideOnScroll.isFalseOrUndefined()) {
            fab.disableCollapse();
        }
        if (options.customSize.hasValue() && options.customSize.get() >= 50) {
            fab.setCustomSize(options.customSize.get());
        }
    }

    private void mergeFabOptions(Fab fab, FabOptions options) {
        if (options.visible.isTrue()) {
            fab.show();
        }
        if (options.visible.isFalse()) {
            fab.hide();
        }
        if (options.backgroundColor.hasValue()) {
            fab.setBackgroundColor(options.backgroundColor.get());
        }
        if (options.clickColor.hasValue()) {
            fab.setRippleColor(options.clickColor.get());
        }
        if (options.icon.hasValue()) {
            fab.applyIcon(options.icon.get(), options.iconColor);
        }
        if (options.size.hasValue()) {
            fab.setSize("mini".equals(options.size.get()) ? SIZE_MINI : SIZE_NORMAL);
        }
        if (options.hideOnScroll.isTrue() && options.visible.isTrueOrUndefined()) {
            fab.enableCollapse(component.getScrollEventListener());
        }
        if (options.hideOnScroll.isFalse()) {
            fab.disableCollapse();
        }
        if (options.customSize.hasValue() && options.customSize.get() >= 50) {
            fab.setCustomSize(options.customSize.get());
        }
    }
}
