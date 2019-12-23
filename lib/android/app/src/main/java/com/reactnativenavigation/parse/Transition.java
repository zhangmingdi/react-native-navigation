package com.reactnativenavigation.parse;

import com.reactnativenavigation.parse.params.NullNumber;
import com.reactnativenavigation.parse.params.NullText;
import com.reactnativenavigation.parse.params.Number;
import com.reactnativenavigation.parse.params.Text;
import com.reactnativenavigation.parse.parsers.NumberParser;
import com.reactnativenavigation.parse.parsers.TextParser;

import org.json.JSONObject;

import androidx.annotation.Nullable;

public class Transition {
    public Text from = new NullText();
    public Text to = new NullText();
    public Number startDelay = new NullNumber();
    public Number duration = new NullNumber();

    public static Transition parse(@Nullable JSONObject json) {
        Transition transition = new Transition();
        if (json == null) return transition;

        transition.from = TextParser.parse(json, "from");
        transition.to = TextParser.parse(json, "to");
        transition.startDelay = NumberParser.parse(json, "startDelay");
        transition.duration = NumberParser.parse(json, "duration");

        return transition;
    }

    void mergeWith(Transition other) {
        if (other.from.hasValue()) from = other.from;
        if (other.to.hasValue()) to = other.to;
        if (other.startDelay.hasValue()) startDelay = other.startDelay;
        if (other.duration.hasValue()) duration = other.duration;
    }

    void mergeWithDefault(Transition defaultOptions) {
        if (!from.hasValue()) from = defaultOptions.from;
        if (!to.hasValue()) to = defaultOptions.to;
        if (!startDelay.hasValue()) startDelay = defaultOptions.startDelay;
        if (!duration.hasValue()) duration = defaultOptions.duration;
    }
}
