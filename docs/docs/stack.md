# Stack

A stack is a container layout promoting a hierarchical navigation. It is used for navigating between screens at consecutive levels of hierarchy, steps in a flow or across an app.

The first child in the stack (represented by the `children` array) is the root and is displayed at the bottom of the stack. The last child in the children array is the child currently being displayed.

In this layout, only a single child screen is visible at any given time and consecutive screen can be added to the top of the stack using the `Navigation.push` command. Tapping the back button will pop the stack and remove the top most screen.

The stack manages the TopBar at the top of the stack. The TopBar displays the current screens' title and buttons. It can be hidden with the `topBar: { visible: false }` option. By default, screens are rendered below the TopBar. This behavior can be changed by setting `topBar: { drawBehind: true }` in the current screens' options.

# Customization
```typescript
options: {
  topBar: {
    drawBehind?: boolean, // default false
    visible?: boolean, // default true
    animate?: boolean, // default true
    testID?: string,
    leftButtonColor?: Color,
    rightButtonColor?: Color,
    hideOnScroll?: boolean, // default false
    title?: {
      text?: string,
      fontSize?: number,
      color?: Color,
      fontFamily?: string,
      component?: {
        id?: string,
        name: string,
        alignment?: 'center' | 'fill',
        passProps?: object
      },
      background?: {
        color?: Color,
        component?: {
          name: string
        }
      },
      // Android specific
      height?: number, // title height in dp
      alignment: 'center' | 'fill'
    },
    subtitle?: {
      text?: string,
      fontSize?: number,
      color?: Color,
      fontFamily?: FontFamily,
      alignment?: 'center'
    },
    backButton?: {
      icon?: require('icon.png'),
      visible?: boolean,
      // iOS only
      title?: string,
      showTitle?: boolean,
      // Android specific
      color?: Color
    },
    background?: {
      color?: Color,
      component?: {
        id?: string,
        name: string,
        passProps?: object
      },
      // iOS specific
      translucent?: boolean,
      blur?: boolean
    },
    // iOS specific
    barStyle?: 'default' | 'black',
    noBorder?: boolean,
    searchBar?: boolean, // iOS 11+ native UISearchBar inside TopBar
    searchBarHiddenWhenScrolling?: boolean,
    searchBarPlaceholder?: string,
    largeTitle?: {
      visible?: boolean,
      fontSize?: number,
      color?: Color,
      fontFamily?: string,
      fontWeight?: 'regular' | 'bold' | 'thin', 'ultraLight' | 'light' | 'medium' | 'semibold' | 'heavy' | 'black' // will ignore fontFamily style and use the iOS system fonts instead.
    },
    // Android specific
    height?: number, // TopBar height in dp
    borderColor?: Color,
    borderHeight?: float, // border height in dp
    elevation?: float, // TopBar elevation in dp
    topMargin?: number, // top margin in dp
  }
}
``` 

# Examples
## Single child
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

## Multiple children
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

## TopBar Title
```js
const stack = {
  children: [
    {
      component: {
        name: 'RootComponent',
        options: {
          topBar: {
            title: {
              text: 'Home'
            }
          }
        }
      }
    }
  ]
}
```

## TopBar Buttons
```js
const stack = {
  children: [
    {
      component: {
        name: 'RootComponent',
        options: {
          topBar: {
            rightButtons: [
              {
                id: 'optionsButton',
                text: 'Options'
              }
            ]
          }
        }
      }
    }
  ]
}
```