package com.reactnativenavigation.views.titlebar;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.support.v7.widget.ActionMenuView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.reactnativenavigation.parse.Alignment;
import com.reactnativenavigation.parse.params.Colour;
import com.reactnativenavigation.utils.UiUtils;
import com.reactnativenavigation.utils.ViewUtils;
import com.reactnativenavigation.viewcontrollers.TitleBarButtonController;

import java.util.List;

import javax.annotation.Nullable;

@SuppressLint("ViewConstructor")
public class TitleBar extends Toolbar {
    public static final int DEFAULT_LEFT_MARGIN = 16;

    private TitleBarButtonController leftButtonController;
    private View component;
    private Alignment subtitleAlignment;
    private Alignment titleAlignment;
    private TextView titleView;

    public TitleBar(Context context) {
        super(context);
        getMenu();
    }

    @Override
    public void setTitle(@Nullable CharSequence title) {
        clearComponent();
//        super.setTitle(title);
//        post(() ->  super.setTitle(title));

        final TextView view = findTitleTextView();
        if (view != null && title != null) {
            float newWidth = view.getPaint().measureText(title.toString());
            view.setWidth((int) newWidth);
            UiUtils.runOnNextMeasure(view, newWidth, () ->  super.setTitle(title));
        } else {
            super.setTitle(title);
        }
    }

    public String getTitle() {
        return super.getTitle() == null ? "" : (String) super.getTitle();
    }

    public void setTitleTextColor(Colour color) {
        if (color.hasValue()) setTitleTextColor(color.get());
    }

    public void setComponent(View component) {
        clearTitle();
        clearSubtitle();
        this.component = component;
        addView(component);
    }

    public void setBackgroundColor(Colour color) {
        if (color.hasValue()) setBackgroundColor(color.get());
    }

    public void setTitleFontSize(double size) {
        TextView titleTextView = findTitleTextView();
        if (titleTextView != null) titleTextView.setTextSize((float) size);
    }

    public void setTitleTypeface(Typeface typeface) {
        TextView titleTextView = findTitleTextView();
        if (titleTextView != null) titleTextView.setTypeface(typeface);
    }

    public void setTitleAlignment(Alignment alignment) {
        titleAlignment = alignment;
    }

    public void setSubtitleTypeface(Typeface typeface) {
        TextView subtitleTextView = findSubtitleTextView();
        if (subtitleTextView != null) subtitleTextView.setTypeface(typeface);
    }

    public void setSubtitleFontSize(double size) {
        TextView subtitleTextView = findSubtitleTextView();
        if (subtitleTextView != null) subtitleTextView.setTextSize((float) size);
    }

    public void setSubtitleAlignment(Alignment alignment) {
        subtitleAlignment = alignment;
    }

    @Override
    protected void onLayout(boolean changed, int l, int t, int r, int b) {
        super.onLayout(changed, l, t, r, b);
        if (titleAlignment != null) alignView(findTitleTextView(), titleAlignment);
        if (subtitleAlignment != null) alignView(findSubtitleTextView(), subtitleAlignment);
    }

    @SuppressWarnings("MagicNumber")
    private void alignView(View view, Alignment alignment) {
        if (view != null) {
            if (alignment == Alignment.Center) {
                view.setX((getWidth() - view.getWidth()) / 2f);
            } else if (leftButtonController != null) {
                view.setX(getContentInsetStartWithNavigation());
            } else {
                view.setX(UiUtils.dpToPx(getContext(), DEFAULT_LEFT_MARGIN));
            }
        }
    }

    @Nullable
    public TextView findTitleTextView() {
        if (titleView != null) return titleView;
        List<TextView> children = ViewUtils.findChildrenByClass(this, TextView.class, textView -> textView.getText().equals(getTitle()));
        titleView = children.isEmpty() ? null : children.get(0);
        return titleView;
    }

    @Nullable
    public TextView findSubtitleTextView() {
        List<TextView> children = ViewUtils.findChildrenByClass(this, TextView.class, textView -> textView.getText().equals(getSubtitle()));
        return children.isEmpty() ? null : children.get(0);
    }

    public void clear() {
        titleAlignment = null;
        subtitleAlignment = null;
//        clearTitle();
//        clearSubtitle();
//        clearRightButtons();
//        clearLeftButton();
//        clearComponent();
    }

    private void clearTitle() {
        setTitle(null);
    }

    private void clearSubtitle() {
        setSubtitle(null);
    }

    private void clearComponent() {
        if (component != null) {
            removeView(component);
            component = null;
        }
    }

    private void clearLeftButton() {
        setNavigationIcon(null);
        if (leftButtonController != null) {
            leftButtonController.destroy();
            leftButtonController = null;
        }
    }

    private void clearRightButtons() {
        if (getMenu().size() > 0) getMenu().clear();
    }

    public void setBackButton(TitleBarButtonController button) {
        setLeftButton(button);
    }

    public void setLeftButtons(List<TitleBarButtonController> leftButtons) {
        if (leftButtons == null) return;
        if (leftButtons.isEmpty()) {
            clearLeftButton();
            return;
        }
        if (leftButtons.size() > 1) {
            Log.w("RNN", "Use a custom TopBar to have more than one left button");
        }
        setLeftButton(leftButtons.get(0));
    }

    private void setLeftButton(TitleBarButtonController button) {
        leftButtonController = button;
        button.applyNavigationIcon(this);
    }

    public void setRightButtons(List<TitleBarButtonController> rightButtons) {
        if (rightButtons == null) return;
        clearRightButtons();
        for (int i = 0; i < rightButtons.size(); i++) {
            rightButtons.get(i).addToMenu(this, rightButtons.size() - i - 1);
        }
    }

    public void setHeight(int height) {
        int pixelHeight = UiUtils.dpToPx(getContext(), height);
        if (pixelHeight == getLayoutParams().height) return;
        ViewGroup.LayoutParams lp = getLayoutParams();
        lp.height = pixelHeight;
        setLayoutParams(lp);
    }

    public void setOverflowButtonColor(int color) {
        ActionMenuView actionMenuView = ViewUtils.findChildByClass(this, ActionMenuView.class);
        if (actionMenuView != null) {
            Drawable overflowIcon = actionMenuView.getOverflowIcon();
            if (overflowIcon != null) {
                overflowIcon.setColorFilter(new PorterDuffColorFilter(color, PorterDuff.Mode.SRC_IN));
            }
        }
    }
}
