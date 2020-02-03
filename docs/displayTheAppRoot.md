---
id: displayTheAppRoot
title: Display the app root
sidebar_label: Display the app root
---

# Update index.js file
`index.js` is typically used as the entry point to the app. It's first parsed and executed by the JS engine, therefore we'll want to show our UI from there.

The following diff demonstrates the changes needed to be made to an `index.js` file initialized by `react-native init`.

```diff
+import { Navigation } from "react-native-navigation";
-import {AppRegistry} from 'react-native';
import App from "./App";
-import {name as appName} from './app.json';

-AppRegistry.registerComponent(appName, () => App);
+Navigation.registerComponent('com.myApp.WelcomeScreen', () => App);

+Navigation.events().registerAppLaunchedListener(() => {
+   Navigation.setRoot({
+     root: {
+       stack: {
+         component: {
+           name: 'com.myApp.WelcomeScreen'
+         }
+       }
+     }
+  });
+});
```