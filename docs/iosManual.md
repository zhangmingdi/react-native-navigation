---
id: iosManual
title: Manual installation
sidebar_label: Manual installation
---

## 1. Add react-native-navigation library
In Xcode, in Project Navigator (left pane), right-click on the `Libraries` > `Add files to [project name]`. Add `node_modules/react-native-navigation/lib/ios/ReactNativeNavigation.xcodeproj` ([screenshots](https://facebook.github.io/react-native/docs/linking-libraries-ios.html#manual-linking)).

## 2. Add react-native-navigation build phase
In Xcode, in Project Navigator (left pane), click on your project (top), then click on your *target* row (on the "project and targets list", which is on the left column of the right pane) and select the `Build Phases` tab (right pane). In the `Link Binary With Libraries` section add `libReactNativeNavigation.a` ([screenshots](https://facebook.github.io/react-native/docs/linking-libraries-ios.html#step-2)).

### a. ReactNativeNavigation.h' file not found
	If you're seeing an error message in Xcode such as:
	```
	'ReactNativeNavigation/ReactNativeNavigation.h' file not found.
	```
	You may also need to add a Header Search Path: ([screenshots](https://facebook.github.io/react-native/docs/linking-libraries-ios.html#step-3)).
	```objectivec
	$(SRCROOT)/../node_modules/react-native-navigation/lib/ios
	```

## 3. Edit AppDelegate.m
In Xcode, edit this file: `AppDelegate.m`. This function is the main entry point for your app:

	```objectivec
	 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { ... }
	```

	Its content should look like this:

	```objectivec
	#import "AppDelegate.h"

	#import <React/RCTBundleURLProvider.h>
	#import <React/RCTRootView.h>
	#import <ReactNativeNavigation/ReactNativeNavigation.h>

	@implementation AppDelegate

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{
		NSURL *jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
		[ReactNativeNavigation bootstrap:jsCodeLocation launchOptions:launchOptions];

		return YES;
	}

	@end
	```

### a. RCTBundleURLProvider.h file not found
If, in Xcode, you see the following error message in `AppDelegate.m` next to `#import "RCTBundleURLProvider.h"`: 
	```
	! 'RCTBundleURLProvider.h' file not found
	```
	This is because the `React` scheme is missing from your project. You can verify this by opening the `Product` menu and the `Scheme` submenu. 
	To make the `React` scheme available to your project, run `npm install -g react-native-git-upgrade` followed by `react-native-git-upgrade`. Once this is done, you can click back to the menu in Xcode: `Product -> Scheme -> Manage Schemes`, then click '+' to add a new scheme. From the `Target` menu, select "React", and click the checkbox to make the scheme `shared`. This should make the error disappear.

### b. Class 'AppDelegate' does not conform to protocol 'RCTBridgeDelegate'
If, in Xcode, you see the following warning message in `AppDelegate.m` next to `#import "@implementation AppDelegate"`:
	```
	Class 'AppDelegate' does not conform to protocol 'RCTBridgeDelegate'
	```
	You can remove `RCTBridgeDelegate` from this file: `AppDelegate.h`:
	```diff
	- #import <React/RCTBridgeDelegate.h>
	- @interface AppDelegate : UIResponder <UIApplicationDelegate, RCTBridgeDelegate>
	+ @interface AppDelegate : UIResponder <UIApplicationDelegate>
		...
	```