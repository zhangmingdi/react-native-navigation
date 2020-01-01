package com.reactnativenavigation.views.element;

import android.animation.AnimatorSet;
import android.view.View;

import com.facebook.react.uimanager.util.ReactFindViewUtil;
import com.reactnativenavigation.parse.AnimationOptions;
import com.reactnativenavigation.parse.SharedElementTransition;
import com.reactnativenavigation.parse.SharedElements;
import com.reactnativenavigation.utils.Functions;
import com.reactnativenavigation.viewcontrollers.ViewController;

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

    public void createTransitions(SharedElements transitions, ViewController fromScreen, ViewController toScreen, Functions.Func1<TransitionSet> onAnimatorsCreated) {
        if (!transitions.hasValue()) {
            onAnimatorsCreated.run(new TransitionSet());
            return;
        }
        TransitionSet transitionSet = new TransitionSet();
        for (SharedElementTransition transition : transitions.get()) {
            perform(findView(fromScreen.getView(), transition.fromId.get()), v -> transitionSet.from.put(transition.fromId.get(), v));
            findView(toScreen.getView(), new ReactFindViewUtil.OnViewFoundListener() {
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

    public AnimatorSet createAnimators(ViewController toScreen, AnimationOptions animation, TransitionSet transitionSet) {
        return animatorCreator.create(toScreen, animation, transitionSet.validTransitions, transitionSet.from, transitionSet.to);
    }
}
