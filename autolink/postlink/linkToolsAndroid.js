var glob = require("glob");



exports.mainActivityJavaDeclaration = /public class MainActivity extends ReactActivity\s*\{/
exports.mainActivityJavaDeclarationPatched = 'public class MainActivity extends NavigationActivity {'
exports.reactActivityImport = 'import com.facebook.react.ReactActivity;';
exports.navigationActivityImport = 'import com.reactnativenavigation.NavigationActivity;';



exports.isSettingsGradleAlreadyContainRNN = function(settingsGradleContent) {

}

exports.doesActivityExtendNavigationActivity = function(mainActivityContents) {
  return /public class MainActivity extends NavigationActivity\s*\{/.test(mainActivityContents);
}
