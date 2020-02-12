---
id: stack-buttons
title: Buttons
sidebar_label: Buttons
---

Buttons can be added to the [right](#rightButtons) and [left](#leftButtons) areas of the TopBar. Buttons can have either an icon or a text. They are declared in the the options object and, as with any other option, can be updated dynamically with the `Navigation.mergeOptions` command.

?> When using an icon button on **Android**, you should always pass a title as well. The title is used when the button is collapsed to the overflow menu and as a tooltip when the button is long pressed.

### Overflow menu
It's common practice to group less important actions in a menu or an action sheet.

To do so on iOS, include a button with a menu icon and open an [ActionSheet](https://facebook.github.io/react-native/docs/actionsheetios) with the relevant actions when the button is clicked.

On Android, use the [showAsAction](#showasaction) options to control when the button should appear in the menu.

### Left button
Left buttons behave like right buttons with two caveats on Android:
* single left button Android
* Textual left button isn't supported on Android atm

### Back button
The back button is added automatically when two or more screens are pushed into the stack and can be customized via [options](http://localhost:3000/#/docs/stack?id=backbutton). Handling the back button is not possible. However, you can set a left button with a chevron and handle it like you'd handle any other button, calling `Navigation.pop` when desired.

### Custom button