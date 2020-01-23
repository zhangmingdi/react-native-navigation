module.exports = {
  dependency: {
    platforms: {
      ios: {},
      android: {
        sourceDir: './lib/android/app/',
        packageImportPath: 'import com.reactnativenavigation.react.NavigationPackage;',
        packageInstance: 'new NavigationPackage(reactNativeHost)',
      }
    },
    assets: []
  },
  project: {
    ios: {
      project: './playground/ios/playground.xcworkspace',
    },
    android: {
      sourceDir: './playground/android/',
    },
  },
};
