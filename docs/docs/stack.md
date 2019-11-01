<!-- panels:start -->
<!-- div:left-panel -->
# Stack
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

<!-- tabs:start -->
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
<!-- tabs:end -->
___
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
___
### popToRoot(componentId, mergeOptions?)
Pop all screens pushed into the stack.
```
Navigation.popToRoot(this.props.componentId);
```
___
### popTo(componentId, mergeOptions?)
Pop the stack to a given component.
```js
Navigation.popTo(componentId);
```
___
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
<!-- tabs:end -->
___
## Buttons
Buttons can be added to the [right](#/docs/stack?id=rightbuttons-arraylt-button-gt) and [left](#/docs/stack?id=leftbuttons-arraylt-button-gt) areas of the TopBar. Buttons can have either an icon or a text. They are declared in the child's options object and, as with any other option, can be updated dynamically with the `Navigation.mergeOptions` command.

### Overflow menu
It's common practice to group less important actions in a menu or an action sheet.

To do so on iOS, include a button with a menu icon and open an [ActionSheet](https://facebook.github.io/react-native/docs/actionsheetios) with the relevant actions when the button is clicked. On Android, use the `showAsAction` options to control when the button should appear in the menu.

### Left button
* single left button Android
* Textual left button isn't supported on Android atm

### Back button

### Custom button


* long press on a button android

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
### TopBar
#### animate?: boolean
Determines if changing the TopBar visibility will be animated or not.
___
### BackButton
#### icon?: number
Change the default back button icon.
___
#### visible?: boolean
Hide or show the back button.
___
#### title?: string (iOS specific)
Change the text displayed next to the title. Usually the back button shows the title of the previous screen. 
___
#### showTitle?: boolean (iOS specific)
Show or hide the text displayed next to the back button.
___
#### color?: Color
Change the back button's color. This will change the text color as well.
___
### Background
#### color?: Color
Set the background color. Ignored if a component is specified.
___
#### component?: Component
Set a react [component](#component) as the background. Useful for example to show a gradient as background.

?> On Android, Setting an `id` to the Component will prevent the component from being recreated each time it's used by a screen. The component will be created once and whenever possible it will be reused.
___
#### barStyle?: 'default' | 'black' (iOS specific)
Control the TopBar blur style. Requires `translucent: true`.
___
#### borderColor?: Color (iOS specific)
Change the topBar border color.
___
#### borderHeight?: number (Android specific)
Set the border height of the navbar in dp.
___
#### drawBehind?: boolean
Controls if the child should be drawn behind the TopBar or below it.
___
#### elevation?: number (Android specific)
Set the elevation of the TopBar in dp. This option changes how the shadow under the TopBar looks. Setting this value to 0 will remove the shadow completely.
___
#### height?: number
The height of the TopBar in dp.
___
#### hideOnScroll?: boolean
Hide the TopBar when a scrolling layout is scrolled.
___
#### hideNavBarOnFocusSearchBar?: boolean (iOS 11+ specific)
Indicates whether the navigation bar should be hidden when searching. True by default.
___
### LargeTitle (iOS specific)
Available on iOS 11 and above.

#### visible?: boolean
Controls whether the large title is visible or not.
___
#### fontSize?: number
Set the title font size. On Android this value is treated in sp units.
___
#### color?: Color
Large title text color.
___
#### fontFamily?: FontFamily
Set the large title's [FontFamily]().
___
#### fontWeight?: number
Set the large title's font weight.
___
#### leftButtons?: Array< Button >
An array of buttons to be displayed at the right side of the TopBar. Buttons are layed out in order from left to right. See the [Buttons](#Buttons) section for more details.

?> Android currently only supports a single left button and does not support custom left Buttons
___
#### leftButtonColor?: Color
Default color for left buttons.
___
#### noBorder?: boolean (iOS specific)
Disables the border at bottom of the TopBar.
___
#### rightButtons?: Array< Button >
An array of buttons to be displayed at the right side of the TopBar. Buttons are layed out in order from right to left. See the [Buttons](#Buttons) section for more details.
___
#### rightButtonColor?: Color
Default color for right buttons.
___
#### searchBar?: boolean (iOS 11+ specific)
Show a UISearchBar in the TopBar.
___
#### searchBarHiddenWhenScrolling?: boolean (iOS 11+ specific)
Hides the UISearchBar when scrolling.
___
#### searchBarPlaceholder?: string (iOS 11+ specific)
The placeholder value in the UISearchBar.
___
### Subtitle
#### text: string
The subtitle text.
___
#### fontSize?: number
The subtitle fontSize. On Android this value is treated in sp units.
___
#### color?: Color
The subtitle color.
___
#### fontFamily?: FontFamily
The subtitle FontFamily.
___
#### alignment?: 'center' | 'fill'
`fill` will make the subtitle stretch and consume all available space in the TopBar while `center` will center the subtitle in the middle of the TopBar.
___
#### testID?: string
Used to interact with the TopBar in e2e tests.
___
### Title
#### text: string
Set the title for the TopBar.
___
#### fontSize?: number
Set the title font size. On Android this value is treated in sp units.
___
#### color?: Color
Set the title color.
___
#### fontFamily?: FontFamily
Set the title font family.
___
#### alignment?: 'center' | 'fill'
`fill` will make the title stretch and consume all available space in the TopBar while `center` will center the title in the middle of the TopBar.

?> `center` is the default option on iOS while `fill` is the default for Android.
___
#### component?: Component
Set a react [component](#component) as the title. If this option is specified then text is ignored.
___
#### background?: Background
Set the [Background](#background) for the title.
___
#### topMargin?: number (Android specific)
Change to TopBar's top margin.
___
#### visible?: boolean
Determines whether the TopBar is visible or not.
___
### Button
#### id: string
Buttons are identified by their id property. When a button is clicked, a buttonPress event is emitted to js with the button's id.
___
#### icon?: number
Button icon. If the button is pushed to the overflow menu the button's [text](#text-string) is used instead.
___
#### text?: string
Button text, ignored an an icon is specified unless the button is displayed in the overflow menu.
___
#### component?: Component
Set a react [component](#component) as this button's view which will be displayed instead of the regular view.
___
#### iconInsets?: IconInsets (iOS specific)
[IconInsets](#iconinsets) are applied to the icon to translate its original position on the screen.
___
#### systemItem?: string (iOS specific)
System icon, it is ignored if an [icon](#icon-number) is specified. For more information see [apple's guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/system-icons/).

##### Available icons
* done
* cancel
* edit
* save
* add
* flexibleSpace
* fixedSpace
* compose
* reply
* action
* organize
* bookmarks
* search
* refresh
* stop
* camera
* trash
* play
* pause
* rewind
* fastForward
* undo
* redo
___
### Component
#### name: string
The key used when registering the component with `Navigation.registerComponent`.
___
#### id?: string
Unique id used when interacting with the view with the Navigation api, usually `Navigation.mergeOptions` which accepts the componentId as it's first argument.
___
#### alignment?: 'center' | 'fill'
This option is relevant only to title components. `fill` will make the component stretch and consume all available space in the TopBar while `center` will center it in the middle of the TopBar.

?> `center` is the default option on iOS while `fill` is the default for Android.
___
#### waitForRender?: boolean
Wait for this component to fully render before showing the screen. This option is useful for ensuring that both a child screen pushed into the stack and all of the TopBar components (title, background and buttons) are displayed to the user at the same time.

To enable this option, `waitForRender` in the relevant screen animation option needs to be enabled as well.

!> While this option improves ux, it might introduce delays when pushing screens.
___
#### passProps?: object
A JavaScript object with props accessible inside the component using `this.props`.
___
### IconInsets
___

<!-- div:right-panel -->
<ul id="optionsUl">
  <li><span class="caret">TopBar</span>
    <ul class="nested active">
      <li><a href="#/docs/stack?id=animate-boolean">animate</a></li>
      <li><span class="caret">backButton</span>
        <ul class="nested">
          <li><a href="">icon</a></li>
          <li><a href="">visible</a></li>
          <li><a href="">title</a></li>
          <li><a href="">showTitle</a></li>
          <li><a href="">color</a></li>
        </ul>
      </li>
      <li><span class="caret">background</span>
        <ul class="nested">
          <li><a href="#/docs/stack?id=color-color-5">color</a></li>
          <li><span class="caret">component</span>
            <ul class="nested">
              name
            </ul>
          </li>
        </ul>
      </li>
      <li><a href="#/docs/stack?id=barstyle-39default39-39black39-ios-specific">barStyle</a></li>
      <li><a href="#/docs/stack?id=bordercolor-color-ios-specific">borderColor</a></li>
      <li><a href="#/docs/stack?id=borderheight-number-android-specific">borderHeight</a></li>
      <li><a href="#/docs/stack?id=drawbehind-boolean">drawBehind</a></li>
      <li><a href="#/docs/stack?id=elevation-number-android-specific">elevation</a></li>
      <li><a href="#/docs/stack?id=height-number">height</a></li>
      <li><a href="#/docs/stack?id=hideonscroll-boolean">hideOnScroll</a></li>
      <li><a href="#/docs/stack?id=hidenavbaronfocussearchbar-boolean-ios-11-specific">hideNavBarOnFocusSearchBar</a></li>
      <li><span class="caret">largeTitle</span>
        <ul class="nested">
          <li><a href="#/docs/stack?id=visible-boolean-1">visible</a></li>
          <li><a href="/#/docs/stack?id=fontsize-number-2">fontSize</a></li>
          <li><a href="#/docs/stack?id=color-color-2">color</a></li>
          <li><a href="#/docs/stack?id=fontfamily-fontfamily-2">fontFamily</a></li>
          <li><a href="#/docs/stack?id=fontweight-number">fontWeight</a></li>
        </ul>
      </li>
      <li><a href="#/docs/stack?id=leftbuttons-arraylt-button-gt">leftButtons</a></li>
      <li><a href="#/docs/stack?id=leftbuttoncolor-color">leftButtonColor</a></li>
      <li><a href="#/docs/stack?id=noborder-boolean-ios-specific">noBorder</a></li>
      <li><a href="#/docs/stack?id=rightbuttons-arraylt-button-gt">rightButtons</a></li>
      <li><a href="#/docs/stack?id=rightbuttoncolor-color">rightButtonColor</a></li>
      <li><a href="#/docs/stack?id=searchbar-boolean-ios-11-specific">searchBar</a></li>
      <li><a href="#/docs/stack?id=searchbarhiddenwhenscrolling-boolean-ios-11-specific">searchBarHiddenWhenScrolling</a></li>
      <li><a href="#/docs/stack?id=searchbarplaceholder-string-ios-11-specific">searchBarPlaceholder</a></li>
      <li><span class="caret">subtitle</span>
        <ul class="nested">
          <li><a href="#/docs/stack?id=text-string-1">text</a></li>
          <li><a href="#/docs/stack?id=fontsize-number-1">fontSize</a></li>
          <li><a href="#/docs/stack?id=color-color-1">color</a></li>
          <li><a href="#/docs/stack?id=fontfamily-fontfamily-1">fontFamily</a></li>
          <li><a href="#/docs/stack?id=alignment-39center39-39fill39-1">alignment</a></li>
        </ul>
      </li>
      <li><a href="#/docs/stack?id=testid-string">testID</a></li>
      <li><span class="caret">title</span>
        <ul class="nested">
          <li><a href="#/docs/stack?id=text-string">text</a></li>
          <li><a href="#/docs/stack?id=fontsize-number">fontSize</a></li>
          <li><a href="#/docs/stack?id=color-color">color</a></li>
          <li><a href="#/docs/stack?id=fontfamily-fontfamily">fontFamily</a></li>
          <li><a href="#/docs/stack?id=alignment-39center39-39fill39">alignment</a></li>
          <li><span class="caret">component</span>
            <ul class="nested">
              <li><a href="#/docs/stack?id=name-string">name</a></li>
              <li><a href="#/docs/stack?id=id-string-1">id</a></li>
              <li><a href="#/docs/stack?id=alignment-39center39-39fill39-2">alignment</a></li>
              <li><a href="#/docs/stack?id=passprops-object">passProps</a></li>
            </ul>
          </li>
          <li><span class="caret">background</span>
            <ul class="nested">
              <li><a href="#/docs/stack?id=color-color-2">color</a></li>
              <li><span class="caret">component</span>
                <ul class="nested">
                  <li><a href="#/docs/stack?id=name-string">name</a></li>
                  <li><a href="#/docs/stack?id=id-string-1">id</a></li>
                  <li><a href="#/docs/stack?id=alignment-39center39-39fill39-1">alignment</a></li>
                  <li><a href="#/docs/stack?id=passprops-object">passProps</a></li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
      </li>
      <li><a href="#/docs/stack?id=topmargin-number-android-specific">topMargin</a></li>
      <li><a href="#/docs/stack?id=visible-boolean">visible</a></li>
  </li>
</ul>
<!-- panels:end -->