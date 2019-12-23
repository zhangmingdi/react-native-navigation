package com.reactnativenavigation.views.element;

import android.animation.Animator;
import android.view.View;
import android.view.ViewGroup;

import com.facebook.react.uimanager.util.ReactFindViewUtil;
import com.reactnativenavigation.parse.Transition;
import com.reactnativenavigation.parse.Transitions;
import com.reactnativenavigation.utils.Functions;

import java.util.ArrayList;
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

    public void createTransitions(Transitions transitions, ViewGroup fromScreen, ViewGroup toScreen, Functions.Func1<List<Animator>> onAnimatorsCreated) {
        if (!transitions.hasValue()) {
            onAnimatorsCreated.run(Collections.emptyList());
            return;
        }
        Map<String, View> from = new HashMap<>();
        Map<String, View> to = new HashMap<>();
        List<ReactFindViewUtil.OnViewFoundListener> listeners = new ArrayList<>();
        for (Transition transition : transitions.get()) {
            perform(findView(fromScreen, transition.from.get()), v -> from.put(transition.from.get(), v));

            ReactFindViewUtil.OnViewFoundListener viewFoundListener = new ReactFindViewUtil.OnViewFoundListener() {
                @Override
                public String getNativeId() {
                    return transition.to.get();
                }

                @Override
                public void onViewFound(View view) {
                    to.put(transition.to.get(), view);
                    if (from.size() == to.size()) {
                        onAnimatorsCreated.run(animatorCreator.create(filter(transitions.get(), t -> validator.validate(t, from, to)), from, to));
                    }
                }
            };
            listeners.add(viewFoundListener);
            findView(toScreen, viewFoundListener);
        }
        forEach(listeners, ReactFindViewUtil::removeViewListener);
    }
}
