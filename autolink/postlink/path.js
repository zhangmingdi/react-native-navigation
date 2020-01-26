var glob = require("glob");
var ignoreFolders = { ignore: ["node_modules/**", "**/build/**"] };

var manifestPath = glob.sync("**/AndroidManifest.xml", ignoreFolders)[0];

exports.settingsGradle = glob.sync("**/settings.gradle", ignoreFolders)[0];

exports.mainActivityJava = glob.sync("**/MainActivity.java", ignoreFolders)[0];
exports.mainActivityKotlin = glob.sync("**/MainActivity.kt", ignoreFolders)[0];
exports.mainApplicationJava = glob.sync("**/MainApplication.java", ignoreFolders)[0];
