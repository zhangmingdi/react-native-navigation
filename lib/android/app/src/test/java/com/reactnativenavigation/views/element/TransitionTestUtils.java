package com.reactnativenavigation.views.element;

import android.app.Activity;

import com.reactnativenavigation.parse.SharedElementTransition;
import com.reactnativenavigation.parse.params.Number;
import com.reactnativenavigation.parse.params.Text;

import java.util.UUID;

public class TransitionTestUtils {
    private static final int DURATION = 250;

    static SharedElementTransition createTransition(Element from, Element to) {
        SharedElementTransition transition = new SharedElementTransition();
        transition.duration = new Number(DURATION);
        transition.fromId = new Text(from.getElementId());
        transition.toId = new Text(to.getElementId());
        return transition;
    }

    static Element createElement(Activity activity) {
        return createElement(activity, UUID.randomUUID().toString());
    }

    static Element createElement(Activity activity, String id) {
        Element e = new Element(activity);
        e.setElementId(id);
        return e;
    }

}
