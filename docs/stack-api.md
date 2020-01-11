---
id: stack-api
title: Stack API
sidebar_label: API
---

A stack is a container layout promoting a hierarchical navigation. It is used for navigating between screens at consecutive levels of hierarchy, steps in a flow or across an app.

The first child in the stack (represented by the `children` array) is the root and is displayed at the bottom of the stack. The last child in the children array is the child currently being displayed.

In this layout, only a single child screen is visible at any given time and consecutive screen can be added to the top of the stack using the `Navigation.push` command. Tapping the back button will pop the stack and remove the top most screen.

The stack manages the TopBar at the top of the stack. The TopBar displays the current screens' title and buttons. It can be hidden with the `topBar: { visible: false }` option. By default, screens are rendered below the TopBar. This behavior can be changed by setting `topBar: { drawBehind: true }` in the current screens' options.

## API
### push(componentId, layout)
Push a screen into the stack and updates the display according to the screen's options.
#### Parameters
* **componentId: string**<br>
The componentId of a screen pushed into the stack, or the stack's id.
* **layout: Layout**<br>
The layout being pushed into the stack. Any type of layout (except stack) can be pushed into stacks. Typically, Component layout is pushed into stacks but it's possible to push SideMenu or BottomTabs as well.

#### **Component**
The most common use case - push a single react component.
```js
Navigation.push(this.props.componentId, {
  component: {
    name: 'example.PushedScreen'
  }
});
```

#### **Update options on push **
Options are applied when screen becomes visible.
```js
Navigation.push(this.props.componentId, {
  component: {
    name: 'example.PushedScreen',
    options: {
      topBar: {
        title: {
          text: 'Pushed screen title'
        }
      }
    }
  }
});
```

#### **Push other layouts**
Any layout type can be pushed. In this example we push a SideMenu layout.
```js
Navigation.push(this.props.componentId, {
  sideMenu: {
    left: {
      component: {
        name: 'drawerScreen'
      }
    },
    center: {
      component: {
        name: 'centerScreen'
      }
    }
  }
});
```

### pop(id, mergeOptions?)
Pop the top screen from the stack.
#### Parameters
* **componentId: string**<br>
The componentId of a screen pushed into the stack, or the stack's id.
* **mergeOptions?: object**<br>
Optional options to be merged before popping the screen.
```js
Navigation.pop(this.props.componentId);
```

### popToRoot(componentId, mergeOptions?)
Pop all screens pushed into the stack.
```
Navigation.popToRoot(this.props.componentId);
```

### popTo(componentId, mergeOptions?)
Pop the stack to a given component.
```js
Navigation.popTo(componentId);
```

### setStackRoot(componentId, layout)
Reset the stack to the given layout (accepts multiple children).

<!-- tabs:start -->
#### **Single child**
```js
Navigation.setStackRoot(this.props.componentId, {
  component: {
    name: 'example.NewRootScreen'
  }
});
```

#### **Multiple children**
In the example below we reset the stack with two components. The first one will be the root component and the second (`PushedScreen`) will be displayed. Pressing the back button (either hardware or software) will pop it, revealing the root component - `NewRootScreen`.
```js
Navigation.setStackRoot(this.props.componentId, [
  {
    component: {
      name: 'NewRootScreen',
    }
  },
  {
    component: {
      name: 'PushedScreen',
    }
  }
]);
```




### Component
#### name: string
The key used when registering the component with `Navigation.registerComponent`.
#### id?: string
Unique id used when interacting with the view with the Navigation api, usually `Navigation.mergeOptions` which accepts the componentId as it's first argument.
#### alignment?: 'center' | 'fill'
This option is relevant only to title components. `fill` will make the component stretch and consume all available space in the TopBar while `center` will center it in the middle of the TopBar.

?> `center` is the default option on iOS while `fill` is the default for Android.
#### waitForRender?: boolean
Wait for this component to fully render before showing the screen. This option is useful for ensuring that both a child screen pushed into the stack and all of the TopBar components (title, background and buttons) are displayed to the user at the same time.

To enable this option, `waitForRender` in the relevant screen animation option needs to be enabled as well.

!> While this option improves ux, it might introduce delays when pushing screens.
#### passProps?: object
A JavaScript object with props accessible inside the component using `this.props`.

### IconInsets

