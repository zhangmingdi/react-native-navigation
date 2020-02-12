---
id: component
title: Component
sidebar_label: Component
---

Extends [Layout](Layout.md)

```js
{
  name: 'MyRegisteredComponent'
}
```

## `name: string`
The key used when registering the component with `Navigation.registerComponent`.
## `id?: string`
Unique id used when interacting with the view with the Navigation api, usually `Navigation.mergeOptions` which accepts the componentId as it's first argument.
## `options?: Options`

## `alignment?: 'center' | 'fill'`
This option is relevant only to title components. `fill` will make the component stretch and consume all available space in the TopBar while `center` will center it in the middle of the TopBar.

?> `center` is the default option on iOS while `fill` is the default for Android.
## `waitForRender?: boolean`
Wait for this component to fully render before showing the screen. This option is useful for ensuring that both a child screen pushed into the stack and all of the TopBar components (title, background and buttons) are displayed to the user at the same time.

To enable this option, `waitForRender` in the relevant screen animation option needs to be enabled as well.

!> While this option improves ux, it might introduce delays when pushing screens.
## `passProps?: object`
A JavaScript object with props accessible inside the component using `this.props`.

