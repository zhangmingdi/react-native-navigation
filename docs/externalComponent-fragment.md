---
id: externalComponent-fragment
title: Fragment
sidebar_label: Fragment
---

Using a Fragment as an external component is done by attaching the Fragment to a FrameLayout, and returning the FrameLayout from the `asView()` method of the ExternalComponent.

```java
public class FragmentComponent implements ExternalComponent {
    private final FrameLayout content;

    FragmentComponent(FragmentActivity activity, JSONObject props) {
        // Create the FrameLayout to which we'll attach our Fragment to
        content = new FrameLayout(activity);
        content.setId(R.id.fragment_screen_content);
        // Attach the Fragment to the FrameLayout
        activity.getSupportFragmentManager()
                .beginTransaction()
                .add(R.id.fragment_screen_content, createFragment(props))
                .commitAllowingStateLoss();
    }

    private FragmentScreen createFragment(JSONObject props) {
        FragmentScreen fragment = new FragmentScreen();
        // Pass the props sent from Js in a bundle
        Bundle args = new Bundle();
        args.putString("text", props.optString("text", ""));
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View asView() {
        return content;
    }
}
```