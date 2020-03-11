package com.reactnativenavigation.views;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.view.MenuItem;
import android.widget.LinearLayout;

import androidx.core.view.ViewCompat;
import androidx.interpolator.view.animation.LinearOutSlowInInterpolator;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.bottomnavigation.LabelVisibilityMode;
import com.reactnativenavigation.R;
import com.reactnativenavigation.parse.LayoutDirection;
import com.reactnativenavigation.parse.params.Text;
import com.reactnativenavigation.parse.params.TitleDisplayMode;

import static com.reactnativenavigation.utils.ViewUtils.findChildByClass;

@SuppressLint("ViewConstructor")
public class BottomTabs extends BottomNavigationView {

    private ColorStateList itemTextColors;
    private ColorStateList itemIconColors;

    public BottomTabs(Context context) {
        super(context);
        setId(R.id.bottomTabs);
        setItemHorizontalTranslationEnabled(false);
    }

    @Override
    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        // NOOP - don't recreate views on size change
    }

    public void setTitleState(Text titleState) {
        switch(titleState.get()) {
            case "alwaysHide":
                this.setLabelVisibilityMode(LabelVisibilityMode.LABEL_VISIBILITY_UNLABELED);
                break;
            case "alwaysShow":
                this.setLabelVisibilityMode(LabelVisibilityMode.LABEL_VISIBILITY_LABELED);
                break;
            case "showWhenActive":
                this.setLabelVisibilityMode(LabelVisibilityMode.LABEL_VISIBILITY_SELECTED);
                break;
            default:
                break;
        }
    }

    public void setText(int index, String text) {
        MenuItem item = getMenu().getItem(index);
        if (!item.getTitle().equals(text)) {
            item.setTitle(text);
        }
    }

    public void setIcon(int index, Drawable icon) {
        MenuItem item = getMenu().getItem(index);
        if (!item.getIcon().equals(icon)) {
            item.setIcon(icon);
        }
    }

    public void setSelectedIcon(int index, Drawable icon) {
        MenuItem item = getMenu().getItem(index);
        if (!item.getIcon().equals(icon)) {
            item.setIcon(icon);
        }
    }

    public void setLayoutDirection(LayoutDirection direction) {
         LinearLayout tabsContainer = findChildByClass(this, LinearLayout.class);
        if (tabsContainer != null) tabsContainer.setLayoutDirection(direction.get());
    }

    public void show() {
            // Show bottom navigation
            ViewCompat.animate(this)
                    .translationY(0)
                    .setInterpolator(new LinearOutSlowInInterpolator())
                    .setDuration(300)
                    .start();
    }

    public void hide() {
            // Hide bottom navigation
            ViewCompat.animate(this)
                    .translationY(this.getHeight())
                    .setInterpolator(new LinearOutSlowInInterpolator())
                    .setDuration(300)
                    .start();
    }
}
