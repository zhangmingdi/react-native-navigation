package com.reactnativenavigation.views.element;

import android.view.View;

import com.reactnativenavigation.parse.SharedElementTransition;

import java.util.Map;

class TransitionValidator {
    boolean validate(SharedElementTransition transition, Map<String, View> from, Map<String, View> to) {
        return transition.fromId.hasValue() &&
               from.containsKey(transition.fromId.get()) &&
               transition.toId.hasValue() &&
               to.containsKey(transition.toId.get());
    }
}
