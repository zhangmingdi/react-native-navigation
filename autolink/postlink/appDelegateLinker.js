// @ts-check
var path = require('./path');
var fs = require("fs");
var {warnn, logn, infon, debugn} = require("./log");

class ApplicationLinker {
  constructor() {
    this.appDelegatePath = path.appDelegate;
  }

  link() {
    if (this.appDelegatePath) {
      logn("Linking AppDelegate...");
      var appDelegateContents = fs.readFileSync(this.appDelegatePath, "utf8");
      appDelegateContents = this._removeUnneededImports(appDelegateContents);
      appDelegateContents = this._importNavigation(appDelegateContents);
      appDelegateContents = this._bootstrapNavigation(appDelegateContents);
      appDelegateContents = this._removeApplicationLaunchContent(appDelegateContents);
      fs.writeFileSync(this.appDelegatePath, appDelegateContents);
      infon("AppDelegate linked successfully!\n");
    }
  }

  _removeUnneededImports(applicationContent) {
    const unneededImports = [/\#import\s+\<React\/RCTBridge.h>\s/, /#import\s+\<React\/RCTRootView.h>\s/];
    debugn("   Removing Unneeded imports");
    unneededImports.forEach(unneededImport => {
      if (unneededImport.test(applicationContent)) {
        applicationContent = applicationContent.replace(element, "");
      }
    });

    return applicationContent;
  }

  _importNavigation(applicationContent) {
    if (!this._doesImportNavigation(applicationContent)) {
      debugn("   ");
      return applicationContent
        .replace(/#import\s+"AppDelegate.h"/, "#import \"AppDelegate.h\"\n#import <ReactNativeNavigation/ReactNativeNavigation.h>")
    }
    warnn("   MainApplication already extends NavigationApplication");
    return applicationContent;
  }

  _removeApplicationLaunchContent(applicationContent) {
    const toRemove = [/RCTRootView\s+\*rootView((.|\r|\s)*?)];\s+/, /rootView.backgroundColor((.|\r)*)];\s+/,
      /self.window((.|\r)*)];\s+/, /UIViewController\s\*rootViewController((.|\r)*)];\s+/, /rootViewController\.view\s+=\s+rootView;\s+/,
      /self.window.rootViewController\s+=\s+rootViewController;\s+/, /\[self.window\s+makeKeyAndVisible];\s+/
    ]

    toRemove.forEach(element => {
      if (element.test(applicationContent)) {
        applicationContent = applicationContent.replace(element, "");
      }
    });

    return applicationContent;
  }

  _bootstrapNavigation(applicationContent) {
    return applicationContent.replace(/RCTBridge.*];/, "[ReactNativeNavigation bootstrapWithDelegate:self launchOptions:launchOptions];");
  }

  _doesImportNavigation(applicationContent) {
    return /#import\s+\<ReactNativeNavigation\/ReactNativeNavigation.h>/.test(applicationContent);
  }

  _extendNavigationHost(applicationContent) {
    if (this._doesExtendReactNativeHost(applicationContent)) {
      debugn("   Changing host implementation to NavigationReactNativeHost");
      return applicationContent
        .replace(/\#import\s+\<React\/RCTBridge.h>((.|\n+))\#import\s+\<React\/RCTRootView.h>/, " #import <ReactNativeNavigation/ReactNativeNavigation.h>")
        .replace("import com.facebook.react.ReactNativeHost;", "import com.facebook.react.ReactNativeHost;\nimport com.reactnativenavigation.react.NavigationReactNativeHost;")
    }
    warnn("   NavigationReactNativeHost is already used");
    return applicationContent;
  }

  _removeSOLoaderInit(applicationContent) {
    if (this._isSOLoaderInitCalled(applicationContent)) {
      debugn("   Removing call to SOLoader.init()");
      return applicationContent.replace(/SoLoader.init\(\s*this\s*,\s*[/* native exopackage */]*\s*false\s*\);/, "")
    }
    warnn("   SOLoader.init() is not called");
    return applicationContent;
  }

  _isSOLoaderInitCalled(applicationContent) {
    return /SoLoader.init\(this,\s*[/* native exopackage */]*\s*false\);/.test(applicationContent);
  }

  _doesExtendReactNativeHost(applicationContent) {
    return /\s*new ReactNativeHost\(this\)\s*/.test(applicationContent);
  }
}

module.exports = ApplicationLinker;