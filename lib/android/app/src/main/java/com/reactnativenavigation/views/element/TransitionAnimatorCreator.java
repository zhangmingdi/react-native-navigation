package com.reactnativenavigation.views.element;

import android.animation.Animator;
import android.animation.AnimatorSet;
import android.view.View;

import com.reactnativenavigation.parse.AnimationOptions;
import com.reactnativenavigation.parse.SharedElementTransition;
import com.reactnativenavigation.utils.ViewUtils;
import com.reactnativenavigation.viewcontrollers.ViewController;
import com.reactnativenavigation.views.element.animators.BackgroundColorAnimator;
import com.reactnativenavigation.views.element.animators.MatrixAnimator;
import com.reactnativenavigation.views.element.animators.PropertyAnimatorCreator;
import com.reactnativenavigation.views.element.animators.ScaleXAnimator;
import com.reactnativenavigation.views.element.animators.ScaleYAnimator;
import com.reactnativenavigation.views.element.animators.TextChangeAnimator;
import com.reactnativenavigation.views.element.animators.XAnimator;
import com.reactnativenavigation.views.element.animators.YAnimator;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Map;

public class TransitionAnimatorCreator {

    public AnimatorSet create(ViewController toScreen, AnimationOptions animation, List<SharedElementTransition> transitions, Map<String, View> from, Map<String, View> to) {
        if (transitions.isEmpty()) return new AnimatorSet();
        List<Animator> animators = new ArrayList<>();
        for (SharedElementTransition transition : transitions) {
            animators.add(create(toScreen, animation, transition, from.get(transition.fromId.get()), to.get(transition.toId.get())));
        }
        AnimatorSet set = new AnimatorSet();
        set.playTogether(animators);
        return set;
    }

    protected AnimatorSet create(ViewController toScreen, AnimationOptions animation, SharedElementTransition transition, View from, View to) {
        Collection<Animator> animators = new ArrayList<>();
        ViewUtils.reparent(to, toScreen);
        for (PropertyAnimatorCreator creator : getAnimators(from, to)) {
            if (creator.shouldAnimateProperty()) animators.add(creator.create(transition, animation));
        }
        AnimatorSet set = new AnimatorSet();
        if (!animators.isEmpty()) {
            set.playTogether(animators);
        }
        return set;
    }

    private List<PropertyAnimatorCreator> getAnimators(View from, View to) {
        return Arrays.asList(
                new XAnimator(from, to),
                new YAnimator(from, to),
                new MatrixAnimator(from, to),
                new ScaleXAnimator(from, to),
                new ScaleYAnimator(from, to),
                new BackgroundColorAnimator(from, to),
                new TextChangeAnimator(from, to)
        );
    }
}
