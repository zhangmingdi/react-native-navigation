package com.reactnativenavigation.views.element;

import java.util.ArrayList;
import java.util.List;

public class TransitionSet {
    List<SharedElementTransition> validSharedElementTransitions = new ArrayList<>();
    List<ElementTransition> validElementTransitions = new ArrayList<>();

    public boolean isEmpty() {
        return validSharedElementTransitions.isEmpty() && validElementTransitions.isEmpty();
    }

    public void add(SharedElementTransition transition) {
        validSharedElementTransitions.add(transition);
    }

    public void add(ElementTransition transition) {
        validElementTransitions.add(transition);
    }

    public int size() {
        return validElementTransitions.size() + validSharedElementTransitions.size();
    }
}
