<!-- panels:start -->
<!-- div:left-panel -->
# Stack

A stack is a container layout promoting a hierarchical navigation. It is used for navigating between screens at consecutive levels of hierarchy, steps in a flow or across an app.

The first child in the stack (represented by the `children` array) is the root and is displayed at the bottom of the stack. The last child in the children array is the child currently being displayed.

In this layout, only a single child screen is visible at any given time and consecutive screen can be added to the top of the stack using the `Navigation.push` command. Tapping the back button will pop the stack and remove the top most screen.

The stack manages the TopBar at the top of the stack. The TopBar displays the current screens' title and buttons. It can be hidden with the `topBar: { visible: false }` option. By default, screens are rendered below the TopBar. This behavior can be changed by setting `topBar: { drawBehind: true }` in the current screens' options.

## Examples
### Single child
A stack declared with a single child.
```js
const stack = {
  children: [
    {
      component: {
        name: 'MyComponent'
      }
    }
  ]
}
```

### Multiple children
A stack can be initialized with more than one child, in which case the last child will be the currently displayed child and the first child will be hidden. In this case the back button will be visible automatically, clicking it will go back in the stack revealing the first (previous) child.
Once the root child becomes visible, the back button is hidden.

```js
const stack = {
  children: [
    {
      component: {
        name: 'RootComponent'
      }
    },
    {
      component: {
        name: 'SecondComponent'
      }
    }
  ]
}
```

## Options
#### height?: number
The height of the TopBar in dp.

#### drawBehind?: boolean
Controls if the child should be drawn behind the TopBar or below it.

<!-- div:right-panel -->
<div>
  <pre>
    Options
      TopBar
        <a href="http://localhost:3000/#/docs/stack?id=height-number">Height</a>
        <a href="http://localhost:3000/#/docs/stack?id=drawbehind-boolean">drawBehind</a>
        visible
        animate
        testID
        leftButtonColor
        rightButtonColor
        hideOnScroll
        title
          text
          fontSize
          color
          fontFamily
          alignment
          component
            id
            name
            alignment
            passProps
        background
          color
          component
            name
        subtitle
          text
          fontSize
          color
          fontFamily
          alignment
      backButton
        icon
        visible
        title
        showTitle
        color
      background
        color
        translucent
        blur
        component
          id
          name
          passProps
      barStyle
      noBorder
      searchBar
      searchBarHiddenWhenScrolling
      searchBarPlaceholder
      largeTitle
        visible
        fontSize
        color
        fontFamily
        fontWeight
      height
      borderColor
      borderHeight
      elevation
      topMargin
  </pre>
</div>

<!-- panels:end -->