---
id: bottomTabs
title: Bottom Tabs
sidebar_label: Bottom Tabs
---

Extends [ContainerLayout](ContainerLayout.md)

A container view that manages a radio-style selection interface, where the selection determines which child view controller to display.

```js
{
  id: 'BOTTOM_TABS_LAYOUT',
  children: [
    {
      component: {
        id: 'HOME_SCREEN'
        name: 'HomeScreen'
      }
    },
    stack: {
      id: 'PROFILE_TAB',
      children: [
        {
          component: {
            id: 'PROFILE_SCREEN',
            name: 'ProfileScreen'
          }
        }
      ]
    }
  ]
}
```

## `id?: string`
Unique id used when interacting with the view with the Navigation api, usually `Navigation.mergeOptions` which accepts the componentId as it's first argument.
## `children: Layout[]`
Children layouts of any kind.
## `options?: Options`