// @ts-check
console.log("Running android postlink script\n");

var { infon } = require("./log");
var AppLinker = require("./applicationLinker");
var ActivityLinker = require("./activityLinker");

module.exports = () => {
  new AppLinker().link();
  new ActivityLinker().link();

  // console.log("Patching root build.gradle");
  // ext.kotlinVersion = '1.3.61'

  infon("react-native-navigation linked successfully")
}
