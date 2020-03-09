package com.reactnativenavigation.parse;


import com.reactnativenavigation.parse.params.Bool;
import com.reactnativenavigation.parse.params.Colour;
import com.reactnativenavigation.parse.params.NullBool;
import com.reactnativenavigation.parse.params.NullColor;
import com.reactnativenavigation.parse.params.Number;
import com.reactnativenavigation.parse.params.NullNumber;
import com.reactnativenavigation.parse.params.NullText;
import com.reactnativenavigation.parse.params.Text;
import com.reactnativenavigation.parse.parsers.BoolParser;
import com.reactnativenavigation.parse.parsers.ColorParser;
import com.reactnativenavigation.parse.parsers.NumberParser;
import com.reactnativenavigation.parse.parsers.TextParser;

import org.json.JSONObject;

public class FabOptions {

    public static FabOptions parse(JSONObject json) {
        FabOptions options = new FabOptions();
        if (json == null) return options;

        options.id = TextParser.parse(json, "id");
        options.backgroundColor = ColorParser.parse(json, "backgroundColor");
        options.clickColor = ColorParser.parse(json, "clickColor");
        options.visible = BoolParser.parse(json, "visible");
        if (json.has("icon")) {
            options.icon = TextParser.parse(json.optJSONObject("icon"), "uri");
        }
        options.iconColor = ColorParser.parse(json, "iconColor");
        options.alignHorizontally = TextParser.parse(json, "alignHorizontally");
        options.hideOnScroll = BoolParser.parse(json, "hideOnScroll");
        options.size = TextParser.parse(json, "size");
        options.customSize = NumberParser.parse(json, "customSize");

        return options;
    }

    public Text id = new NullText();
    public Colour backgroundColor = new NullColor();
    public Colour clickColor = new NullColor();
    public Text icon = new NullText();
    public Colour iconColor = new NullColor();
    public Bool visible = new NullBool();
    public Text alignHorizontally = new NullText();
    public Bool hideOnScroll = new NullBool();
    public Text size = new NullText();
    public Number customSize = new NullNumber();

    void mergeWith(final FabOptions other) {
        if (other.id.hasValue()) {
            id = other.id;
        }
        if (other.backgroundColor.hasValue()) {
            backgroundColor = other.backgroundColor;
        }
        if (other.clickColor.hasValue()) {
            clickColor = other.clickColor;
        }
        if (other.visible.hasValue()) {
            visible = other.visible;
        }
        if (other.icon.hasValue()) {
            icon = other.icon;
        }
        if (other.iconColor.hasValue()) {
            iconColor = other.iconColor;
        }
        if (other.alignHorizontally.hasValue()) {
            alignHorizontally = other.alignHorizontally;
        }
        if (other.hideOnScroll.hasValue()) {
            hideOnScroll = other.hideOnScroll;
        }
        if (other.size.hasValue()) {
            size = other.size;
        }
        if (other.customSize.hasValue()) {
            customSize = other.customSize;
        }
    }

    void mergeWithDefault(FabOptions defaultOptions) {
        if (!id.hasValue()) {
            id = defaultOptions.id;
        }
        if (!backgroundColor.hasValue()) {
            backgroundColor = defaultOptions.backgroundColor;
        }
        if (!clickColor.hasValue()) {
            clickColor = defaultOptions.clickColor;
        }
        if (!visible.hasValue()) {
            visible = defaultOptions.visible;
        }
        if (!icon.hasValue()) {
            icon = defaultOptions.icon;
        }
        if (!iconColor.hasValue()) {
            iconColor = defaultOptions.iconColor;
        }
        if (!alignHorizontally.hasValue()) {
            alignHorizontally = defaultOptions.alignHorizontally;
        }
        if (!hideOnScroll.hasValue()) {
            hideOnScroll = defaultOptions.hideOnScroll;
        }
        if (!size.hasValue()) {
            size = defaultOptions.size;
        }
        if (!customSize.hasValue()) {
            customSize = defaultOptions.customSize;
        }
    }

    public boolean hasValue() {
        return id.hasValue() || icon.hasValue();
    }
}
