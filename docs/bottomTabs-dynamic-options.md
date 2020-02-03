---
id: bottomTabs-dynamic-options
title: Updating tab options dynamically
sidebar_label: Updating tab options dynamically
---

To update a tab option, like icon, text or color, simply call `mergeOptions` with the new options using the id of a component or layout contained in the tab we wish to update.

The following snippet demonstrate how to update the color of a specific tab.
```js
Navigation.mergeOptions(componentId, {
  bottomTab: {
    iconColor: 'red',
    textColor: 'red'
  },
});
```