// @ts-check
console.log("Running android postlink script\n");


var linkTools = require('./linkToolsAndroid')
var path = require('./path');
var fs = require("fs");
var { log, logn, warn } = require("./log");
var AppLinker = require("./applicationLinker");

module.exports = () => {
  log("1. Linking MainActivity... ");
  var mainActivityJavaPath = path.mainActivityJava;
  if (mainActivityJavaPath) {
    var mainActivityJavaContents = fs.readFileSync(mainActivityJavaPath, "utf8");
    if (linkTools.doesActivityExtendNavigationActivity(mainActivityJavaContents)) {
      logn("MainActivity.java is already linked");
    } else {
      var mainActivityContents = mainActivityJavaContents.replace(
        linkTools.mainActivityJavaDeclaration,
        linkTools.mainActivityJavaDeclarationPatched
      ).replace(
        linkTools.reactActivityImport,
        linkTools.navigationActivityImport
      );

      fs.writeFileSync(mainActivityJavaPath, mainActivityContents);
      logn("MainActivity linked successfully!");
    }
  } else {
    warn("MainActivity not found!");
  }

  logn("2. Linking MainApplication...");
  new AppLinker().link();

  console.log("3. Patching root build.gradle");
  // ext.kotlinVersion = '1.3.61'



  console.log("react-native-navigation linked successfully")

  // console.log("RNN", "1. Patching settings.gradle");
  // var settingsGradlePath = linkTools.settingsGradlePath;
}
