---
id: bottomTabs-visibility
title: Changing BottomTabs visibility
sidebar_label: Changing BottomTabs visibility
---

## Changing BottomTabs visibility
The `visible` property is used to control the BottomTab visibility. Visibility can be toggled dynamically using the `mergeOptions` command.
```js
Navigation.mergeOptions(componentId, {
  bottomTabs: {
    visible: false
  },
});
```

visibility can also be changed when pushing screens.
```js
Navigation.push(componentId, {
  component: {
    name: 'pushedScreen',
    options: {
      bottomTabs: {
        visible: false
      }
    }
  }
});
```
