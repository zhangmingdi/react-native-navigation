package com.reactnativenavigation.views.element;

import android.view.View;

import com.reactnativenavigation.parse.Transition;

import java.util.Map;

class TransitionValidator {
    boolean validate(Transition transition, Map<String, View> from, Map<String, View> to) {
        return transition.from.hasValue() &&
               from.containsKey(transition.from.get()) &&
               transition.to.hasValue() &&
               to.containsKey(transition.to.get()) &&
               transition.duration.hasValue();
    }
}
