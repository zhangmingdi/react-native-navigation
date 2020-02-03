---
id: stack-options
title: Options
sidebar_label: Options
---

## TopBar
### `animate?: boolean`
Determines if changing the TopBar visibility will be animated or not.

## BackButton
### `color?: Color`
Change the back button's color. This will change the text color as well.
### `icon?: number`
Change the default back button icon.
### `showTitle?: boolean (iOS specific)`
Show or hide the text displayed next to the back button.
### `title?: string (iOS specific)`
Change the text displayed next to the title. Usually the back button shows the title of the previous screen. 
### `visible?: boolean`
Hide or show the back button.

## Background
### `color?: Color`
Set the background color. Ignored if a component is specified.
### `component?: Component`
Set a react [component](#component) as the background. Useful for example to show a gradient as background.

?> On Android, Setting an `id` to the Component will prevent the component from being recreated each time it's used by a screen. The component will be created once and whenever possible it will be reused.

### `barStyle?: 'default' | 'black' (iOS specific)`
Control the TopBar blur style. Requires `translucent: true`.

### `borderColor?: Color (iOS specific)`
Change the topBar border color.

### `borderHeight?: number (Android specific)`
Set the border height of the navbar in dp.

### `drawBehind?: boolean`
Controls if the child should be drawn behind the TopBar or below it.

### `elevation?: number (Android specific)`
Set the elevation of the TopBar in dp. This option changes how the shadow under the TopBar looks. Setting this value to 0 will remove the shadow completely.

### `height?: number`
The height of the TopBar in dp.

### `hideOnScroll?: boolean`
Hide the TopBar when a scrolling layout is scrolled.

### `hideNavBarOnFocusSearchBar?: boolean (iOS 11+ specific)`
Indicates whether the navigation bar should be hidden when searching. True by default.

### `LargeTitle (iOS specific)`
Available on iOS 11 and above.

### `visible?: boolean`
Controls whether the large title is visible or not.

### `fontSize?: number`
Set the title font size. On Android this value is treated in sp units.

### `color?: Color`
Large title text color.

### `fontFamily?: FontFamily`
Set the large title's [FontFamily]().

### `fontWeight?: number`
Set the large title's font weight.

### `leftButtons?: Array< Button >`
An array of buttons to be displayed at the right side of the TopBar. Buttons are layed out in order from left to right. See the [Buttons](#Buttons) section for more details.

?> Android currently only supports a single left button and does not support custom left Buttons

### `leftButtonColor?: Color`
Default color for left buttons.

### `noBorder?: boolean (iOS specific)`
Disables the border at bottom of the TopBar.

### `rightButtons?: Array< Button >`
An array of buttons to be displayed at the right side of the TopBar. Buttons are layed out in order from right to left. See the [Buttons](#Buttons) section for more details.

### `rightButtonColor?: Color`
Default color for right buttons.

### `searchBar?: boolean (iOS 11+ specific)`
Show a UISearchBar in the TopBar.

### `searchBarHiddenWhenScrolling?: boolean (iOS 11+ specific)`
Hides the UISearchBar when scrolling.

### `searchBarPlaceholder?: string (iOS 11+ specific)`
The placeholder value in the UISearchBar.

## Subtitle
### `text: string`
The subtitle text.
### `fontSize?: number`
The subtitle fontSize. On Android this value is treated in sp units.
### `color?: Color`
The subtitle color.
### `fontFamily?: FontFamily`
The subtitle FontFamily.
### `alignment?: 'center' | 'fill'`
`fill` will make the subtitle stretch and consume all available space in the TopBar while `center` will center the subtitle in the middle of the TopBar.
### `testID?: string`
Used to interact with the TopBar in e2e tests.

## Title
### `text?: string`
Set the title for the TopBar.
### `fontSize?: number`
Set the title font size. On Android this value is treated in sp units.
### `color?: Color`
Set the title color.
### `fontFamily?: FontFamily`
Set the title font family.
### `alignment?: 'center' | 'fill'`
`fill` will make the title stretch and consume all available space in the TopBar while `center` will center the title in the middle of the TopBar.

?> `center` is the default option on iOS while `fill` is the default for Android.
### `component?: Component`
Set a react [component](#component) as the title. If this option is specified then text is ignored.

### `topMargin?: number (Android specific)`
Change to TopBar's top margin.

### `visible?: boolean`
Determines whether the TopBar is visible or not.

## Button
### `id: string`
Buttons are identified by their id property. When a button is clicked, a buttonPress event is emitted to js with the button's id.
### `icon?: number`
Button icon. If the button is pushed to the overflow menu the button's [text](#text-string) is used instead.
### `text?: string`
Button text, ignored an an icon is specified unless the button is displayed in the overflow menu.
### `showAsAction?: 'always' | 'never' | 'withText' | 'ifRoom' (Android specific)`

* **ifRooom** - Only add the button to the TopBar if there is room for it, otherwise add it to the overflow menu.
* **never** - Never place this button in the TopBar. Instead, list the button in the overflow menu.
* **always** - Always place this button in the app bar.

### `component?: Component`
Set a react [component](#component) as this button's view which will be displayed instead of the regular view.
### `iconInsets?: IconInsets (iOS specific)`
[IconInsets](#iconinsets) are applied to the icon to translate its original position on the screen.
### `systemItem?: string (iOS specific)`
System icon, it is ignored if an [icon](#icon-number) is specified. For more information see [apple's guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/system-icons/).


<details>
    <summary>Available Icons</summary>
    <ul>
      <li>done</li>
      <li>cancel</li>
      <li>edit</li>
      <li>save</li>
      <li>add</li>
      <li>flexibleSpace</li>
      <li>fixedSpace</li>
      <li>compose</li>
      <li>reply</li>
      <li>action</li>
      <li>organize</li>
      <li>bookmarks</li>
      <li>search</li>
      <li>refresh</li>
      <li>stop</li>
      <li>camera</li>
      <li>trash</li>
      <li>play</li>
      <li>pause</li>
      <li>rewind</li>
      <li>fastForward</li>
      <li>undo</li>
      <li>redo</li>
    </ul>
</details>