---
id: externalComponent-viewGroup
title: ViewGroup
sidebar_label: ViewGroup
---

The ExternalComponent layout allows you to display any native view as a screen. Like JS components, to use the External Component we'll need to register it with a string name. This name is then used when declaring layouts in JS.

## Declaring the native component
```java
public class ViewGroupComponent implements ExternalComponent {
    private final FrameLayout content;

    ViewGroupComponent(FragmentActivity activity, JSONObject props) {
        content = new FrameLayout(activity);
    }

    @Override
    public View asView() {
        return content;
    }
}
```

## Registering the component
```java
public class MainApplication extends NavigationApplication {
  @Override
    public void onCreate() {
        super.onCreate();
        registerExternalComponent("MyExternalComponent", new FragmentCreator());
    }
}
```

## Using the component from JS
Once you've registered the external component in native, you can use it in your layout declarations.
For example, to show an external component modally:
```js
Navigation.showModal({
  externalComponent: {
    name: 'MyExternalComponent',
    passProps: {
      text: "Text from JS"
    }
  }
});
```

>⚠️ Important: props passed to external component are sent over the bridge and therefore need to be serializable.