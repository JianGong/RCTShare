'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  ScrollView,
TouchableOpacity,
  View,
TabBarIOS,
AlertIOS,

} = React;
var WXApi = require('react-native').NativeModules.WXApiManger;

module.exports = WXApi;
