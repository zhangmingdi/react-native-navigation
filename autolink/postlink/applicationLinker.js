// @ts-check
var path = require('./path');
var fs = require("fs");
var { warnn, infon, debugn } = require("./log");

class ApplicationLinker {
  constructor() {
    this.mainApplicationJavaPath = path.mainApplicationJava;
  }

  link() {
    if (this.mainApplicationJavaPath) {
      var applicationContents = fs.readFileSync(this.mainApplicationJavaPath, "utf8");
      applicationContents = this._extendNavigationApplication(applicationContents);
      applicationContents = this._extendNavigationHost(applicationContents);
      applicationContents = this._removeSOLoaderInit(applicationContents);
      infon("MainApplication linked successfully!");
      fs.writeFileSync(this.mainApplicationJavaPath, applicationContents);
    }
  }

  _extendNavigationApplication(applicationContents) {
    if (this._doesExtendApplication(applicationContents)) {
      debugn("   Extending NavigationApplication");
      return applicationContents
        .replace("extends Application", "extends NavigationApplication")
        .replace("import com.facebook.react.ReactApplication;", "import com.reactnativenavigation.NavigationApplication;");
    }
    warnn("   MainApplication already extends NavigationApplication");
    return applicationContents;
  }

  _doesExtendApplication(contents) {
    return /public class MainApplication extends Application implements ReactApplication\s*\{/.test(contents);
  }

  _extendNavigationHost(applicationContents) {
    if (this._doesExtendReactNativeHost(applicationContents)) {
      debugn("   Changing host implementation to NavigationReactNativeHost");
      return applicationContents
        .replace("new ReactNativeHost(this)", "new NavigationReactNativeHost(this)")
        .replace("import com.facebook.react.ReactNativeHost;", "import com.reactnativenavigation.react.NavigationReactNativeHost;")
    }
    warnn("   NavigationReactNativeHost is already used");
    return applicationContents;
  }

  _removeSOLoaderInit(applicationContents) {
    if (this._isSOLoaderInitCalled(applicationContents)) {
      debugn("   Removing call to SOLoader.init()");
      return applicationContents.replace(/SoLoader.init\(this,\s*[/* native exopackage */]*\s*false\);/, "")
    }
    warnn("   SOLoader.init() is not called");
    return applicationContents;
  }

  _isSOLoaderInitCalled(contents) {
    return /SoLoader.init\(this,\s*[/* native exopackage */]*\s*false\);/.test(contents);
  }

  _doesExtendReactNativeHost(contents) {
    return /\s*new ReactNativeHost\(this\)\s*/.test(contents);
  }
}

module.exports = ApplicationLinker;