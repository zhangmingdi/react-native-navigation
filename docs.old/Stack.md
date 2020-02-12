---
id: stack
title: Stack
sidebar_label: Stack
---

Extends [ContainerLayout](ContainerLayout.md)

A stack is a container layout promoting a hierarchical navigation. It is used for navigating between screens at consecutive levels of hierarchy, steps in a flow or across an app.

The first child in the stack (represented by the `children` array) is the root and is displayed at the bottom of the stack. The last child in the children array is the child currently being displayed.

In this layout, only a single child screen is visible at any given time and consecutive screen can be added to the top of the stack using the `Navigation.push` command. Tapping the back button will pop the stack and remove the top most screen.

The stack manages the TopBar at the top of the stack. The TopBar displays the current screens' title and buttons. It can be hidden with the `topBar: { visible: false }` option. By default, screens are rendered below the TopBar. This behavior can be changed by setting `topBar: { drawBehind: true }` in the current screens' options.

```js
{
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
```

## `children: Layout[]`
Children layouts of any kind. A stack can be initialised with more than one screen, in which case the last screen will be presented at the top of the stack.