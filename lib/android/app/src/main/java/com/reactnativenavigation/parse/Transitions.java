package com.reactnativenavigation.parse;

import org.json.JSONArray;

import java.util.ArrayList;
import java.util.List;

import androidx.annotation.Nullable;
import androidx.annotation.RestrictTo;

public class Transitions {
    private List<Transition> transitions = new ArrayList<>();

    public List<Transition> get() {
        return transitions;
    }

    public Transitions() {

    }

    @RestrictTo(RestrictTo.Scope.TESTS)
    public Transitions(List<Transition> transitions) {
        this.transitions = transitions;
    }

    public static Transitions parse(@Nullable JSONArray transitions) {
        Transitions result = new Transitions();
        if (transitions != null) {
            for (int i = 0; i < transitions.length(); i++) {
                result.transitions.add(Transition.parse(transitions.optJSONObject(i)));
            }
        }
        return result;
    }

    public boolean hasValue() {
        return !transitions.isEmpty();
    }

    void mergeWith(final Transitions other) {
        if (other.hasValue()) transitions = other.transitions;
    }

    void mergeWithDefault(Transitions defaultOptions) {
        if (!hasValue()) transitions = defaultOptions.transitions;
    }
}
