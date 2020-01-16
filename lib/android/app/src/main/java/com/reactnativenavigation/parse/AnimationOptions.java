package com.reactnativenavigation.parse;


import android.animation.Animator;
import android.animation.AnimatorSet;
import android.util.Property;
import android.view.View;

import com.reactnativenavigation.parse.params.Bool;
import com.reactnativenavigation.parse.params.NullBool;
import com.reactnativenavigation.parse.params.NullText;
import com.reactnativenavigation.parse.params.Text;
import com.reactnativenavigation.parse.parsers.BoolParser;
import com.reactnativenavigation.parse.parsers.TextParser;
import com.reactnativenavigation.utils.Functions;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import androidx.core.util.Pair;

import static com.reactnativenavigation.utils.CollectionUtils.*;

public class AnimationOptions {
    public AnimationOptions() {

    }

    public AnimationOptions(JSONObject json) {
        if (json != null) parse(json);
    }

    private void parse(JSONObject json) {
        for (Iterator<String> it = json.keys(); it.hasNext(); ) {
            String key = it.next();
            switch (key) {
                case "id":
                    id = TextParser.parse(json, key);
                    break;
                case "enable":
                case "enabled":
                    enabled = BoolParser.parse(json, key);
                    break;
                case "waitForRender":
                    waitForRender = BoolParser.parse(json, key);
                    break;
                default:
                    valueOptions.add(ValueAnimationOptions.parse(json.optJSONObject(key), getAnimProp(key)));
            }
        }
    }

    public Text id = new NullText();
    public Bool enabled = new NullBool();
    public Bool waitForRender = new NullBool();
    private HashSet<ValueAnimationOptions> valueOptions = new HashSet<>();

    void mergeWith(AnimationOptions other) {
        if (other.id.hasValue()) id = other.id;
        if (other.enabled.hasValue()) enabled = other.enabled;
        if (other.waitForRender.hasValue()) waitForRender = other.waitForRender;
        if (!other.valueOptions.isEmpty()) valueOptions = other.valueOptions;
    }

    void mergeWithDefault(AnimationOptions defaultOptions) {
        if (!id.hasValue()) id = defaultOptions.id;
        if (!enabled.hasValue()) enabled = defaultOptions.enabled;
        if (!waitForRender.hasValue()) waitForRender = defaultOptions.waitForRender;
        if (valueOptions.isEmpty()) valueOptions = defaultOptions.valueOptions;
    }

    public boolean hasValue() {
        return id.hasValue() || enabled.hasValue() || waitForRender.hasValue();
    }

    public AnimatorSet getAnimation(View view) {
        return getAnimation(view, null);
    }

    public AnimatorSet getAnimation(View view, AnimatorSet defaultAnimation) {
        if (!hasAnimation()) return defaultAnimation;
        AnimatorSet animationSet = new AnimatorSet();
        List<Animator> animators = new ArrayList<>();
        forEach(valueOptions, options -> animators.add(options.getAnimation(view)));
        animationSet.playTogether(animators);
        return animationSet;
    }

    public int getDuration() {
        return reduce(valueOptions, 0, (item, currentValue) -> Math.max(item.duration.get(currentValue), currentValue));
    }

    private static Pair<Property<View, Float>, Functions.FuncR1<View, Float>> getAnimProp(String key) {
        switch (key) {
            case "y":
                return new Pair<>(View.Y, View::getTranslationY);
            case "x":
                return new Pair<>(View.X, View::getTranslationX);
            case "translationY":
                return new Pair<>(View.TRANSLATION_Y, View::getTranslationY);
            case "translationX":
                return new Pair<>(View.TRANSLATION_X, View::getTranslationX);
            case "alpha":
                return new Pair<>(View.ALPHA, View::getAlpha);
            case "scaleY":
                return new Pair<>(View.SCALE_Y, View::getScaleY);
            case "scaleX":
                return new Pair<>(View.SCALE_X, View::getScaleX);
            case "rotationX":
                return new Pair<>(View.ROTATION_X, View::getRotationX);
            case "rotationY":
                return new Pair<>(View.ROTATION_Y, View::getRotationY);
            case "rotation":
                return new Pair<>(View.ROTATION, View::getRotation);
        }
        throw new IllegalArgumentException("This animation is not supported: " + key);
    }

    public boolean hasAnimation() {
        return !valueOptions.isEmpty();
    }

    public void setValueDy(Property<View, Float> animation, float fromDelta, float toDelta) {
        first(valueOptions, o -> o.equals(animation), param -> {
            param.setFromDelta(fromDelta);
            param.setToDelta(toDelta);
        });
    }
}
