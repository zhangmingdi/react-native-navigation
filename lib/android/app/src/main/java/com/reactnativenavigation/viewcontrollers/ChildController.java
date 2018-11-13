package com.reactnativenavigation.viewcontrollers;

import android.app.Activity;
import android.support.annotation.CallSuper;
import android.support.v4.view.WindowInsetsCompat;
import android.view.ViewGroup;
import android.view.ViewGroup.MarginLayoutParams;

import com.reactnativenavigation.parse.Options;
import com.reactnativenavigation.presentation.Presenter;
import com.reactnativenavigation.viewcontrollers.navigator.Navigator;
import com.reactnativenavigation.views.Component;

public abstract class ChildController<T extends ViewGroup> extends ViewController<T>  {
    final Presenter presenter;
    private final ChildControllersRegistry childRegistry;

    public ChildControllersRegistry getChildRegistry() {
        return childRegistry;
    }

    public ChildController(Activity activity, ChildControllersRegistry childRegistry, String id, Presenter presenter, Options initialOptions) {
        super(activity, id, new NoOpYellowBoxDelegate(), initialOptions);
        this.presenter = presenter;
        this.childRegistry = childRegistry;
    }

    @Override
    @CallSuper
    public void setDefaultOptions(Options defaultOptions) {
        presenter.setDefaultOptions(defaultOptions);
    }

    public void applyInsets(WindowInsetsCompat insets) {
        MarginLayoutParams lp = (MarginLayoutParams) getView().getLayoutParams();
        if (isDrawnBehind()) {
            lp.topMargin = 0;
        } else {
            lp.topMargin = insets.getStableInsetTop();
        }
//        lp.bottomMargin = insets.getStableInsetBottom();
    }

    public boolean isDrawnBehind() {
//        return StatusBarHelper.isDrawnBehind(getActivity());
        return resolveCurrentOptions(presenter.getDefaultOptions()).statusBar.drawBehind.get(false);
//        return initialOptions.copy().withDefaultOptions(presenter.getDefaultOptions()).statusBar.drawBehind.get(false);
    }

    @Override
    public void onViewAppeared() {
        super.onViewAppeared();
        childRegistry.onViewAppeared(this);
    }

    @Override
    public void onViewReappeared() {
        super.onViewReappeared();
        presenter.applyStatusBarVisible(resolveCurrentOptions(presenter.getDefaultOptions()).statusBar);
    }

    @Override
    public void onViewDisappear() {
        super.onViewDisappear();
        childRegistry.onViewDisappear(this);
    }

    public void onViewBroughtToFront() {
        presenter.onViewBroughtToFront(options);
    }

    @Override
    public void applyOptions(Options options) {
        super.applyOptions(options);
        Options resolvedOptions = resolveCurrentOptions();
        presenter.applyOptions(getView(), resolvedOptions);
        if (isRoot()) {
            presenter.applyRootOptions(getView(), resolvedOptions);
        }
        if (isFirstAppear()) presenter.applyStatusBarVisible(resolvedOptions.statusBar);
    }

    @Override
    public void mergeOptions(Options options) {
        if (options == Options.EMPTY) return;
        if (isViewShown()) presenter.mergeOptions(getView(), options);
        super.mergeOptions(options);
    }

    @Override
    public void destroy() {
        if (!isDestroyed() && getView() instanceof Component) {
            performOnParentController(parent -> parent.onChildDestroyed((Component) getView()));
        }
        super.destroy();
    }

    public boolean isRoot() {
        return getParentController() == null &&
                !(this instanceof Navigator) &&
                getView().getParent() != null;
    }
}
