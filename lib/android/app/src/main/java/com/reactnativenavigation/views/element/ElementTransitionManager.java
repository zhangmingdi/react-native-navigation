package com.reactnativenavigation.views.element;

import android.animation.Animator;
import android.view.View;
import android.view.ViewGroup;

import com.facebook.react.uimanager.util.ReactFindViewUtil;
import com.reactnativenavigation.parse.AnimationOptions;
import com.reactnativenavigation.parse.SharedElementTransition;
import com.reactnativenavigation.parse.SharedElements;
import com.reactnativenavigation.utils.Functions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import androidx.annotation.RestrictTo;

import static com.facebook.react.uimanager.util.ReactFindViewUtil.findView;
import static com.reactnativenavigation.utils.CollectionUtils.*;
import static com.reactnativenavigation.utils.ObjectUtils.perform;

public class ElementTransitionManager {
    public class TransitionSet {
        Map<String, View> from = new HashMap<>();
        Map<String, View> to = new HashMap<>();
        List<SharedElementTransition> validTransitions = new ArrayList<>();

        public boolean isEmpty() {
            return validTransitions.isEmpty();
        }
    }

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

    public void createTransitions(SharedElements transitions, ViewGroup fromScreen, ViewGroup toScreen, Functions.Func1<TransitionSet> onAnimatorsCreated) {
        if (!transitions.hasValue()) {
            onAnimatorsCreated.run(new TransitionSet());
            return;
        }
        TransitionSet transitionSet = new TransitionSet();
        for (SharedElementTransition transition : transitions.get()) {
            perform(findView(fromScreen, transition.fromId.get()), v -> transitionSet.from.put(transition.fromId.get(), v));
            findView(toScreen, new ReactFindViewUtil.OnViewFoundListener() {
                @Override
                public String getNativeId() {
                    return transition.toId.get();
                }

                @Override
                public void onViewFound(View view) {
                    transitionSet.to.put(transition.toId.get(), view);
                    if (transitionSet.to.size() == transitions.get().size()) {
                        transitionSet.validTransitions = filter(transitions.get(), t -> validator.validate(t, transitionSet.from, transitionSet.to));
                        onAnimatorsCreated.run(transitionSet);
                    }
                }
            });
        }
    }

    public List<Animator> createAnimators(AnimationOptions animation, TransitionSet transitionSet) {
        return animatorCreator.create(animation, transitionSet.validTransitions, transitionSet.from, transitionSet.to);
    }
}
