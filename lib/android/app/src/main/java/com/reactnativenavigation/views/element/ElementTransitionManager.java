package com.reactnativenavigation.views.element;

import android.animation.Animator;
import android.view.View;
import android.view.ViewGroup;

import com.reactnativenavigation.parse.Transition;
import com.reactnativenavigation.parse.Transitions;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import androidx.annotation.RestrictTo;

import static com.facebook.react.uimanager.util.ReactFindViewUtil.findView;
import static com.reactnativenavigation.utils.CollectionUtils.*;
import static com.reactnativenavigation.utils.ObjectUtils.perform;

public class ElementTransitionManager {

    private final TransitionValidator validator;
    private final TransitionAnimatorCreator animatorCreator;

    @RestrictTo(RestrictTo.Scope.TESTS)
    ElementTransitionManager(TransitionValidator validator, TransitionAnimatorCreator animatorCreator) {
        this.validator = validator;
        this.animatorCreator = animatorCreator;
    }

    public ElementTransitionManager() {
        validator = new TransitionValidator();
        animatorCreator = new TransitionAnimatorCreator();
    }

    public List<Animator> createTransitions(Transitions transitions, ViewGroup fromScreen, ViewGroup toScreen) {
        if (!transitions.hasValue()) return Collections.emptyList();
        Map<String, View> from = new HashMap<>();
        Map<String, View> to = new HashMap<>();
        for (Transition transition : transitions.get()) {
            perform(findView(fromScreen, transition.from.get()), v -> from.put(transition.from.get(), v));
            perform(findView(toScreen, transition.to.get()), v -> to.put(transition.to.get(), v));
        }
        return animatorCreator.create(filter(transitions.get(), t -> validator.validate(t, from, to)), from, to);
    }
}
