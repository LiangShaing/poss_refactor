import 'dart:developer';

// import 'package:poss_mobile/plugin/newrelic/newrelic_plugin.dart';

class Logger {
  /// System Print By DEBUG
  ///
  /// Param require message: String
  static debug({required String? message, String className = ""}) {
    String str = message.toString();
    if (className != "") str = "className[$className] : $message";
    log(str);
  }

  /// System Print Info
  ///
  /// Param require message: String
  static info({required String message, String className = "", String page = "", String event = ""}) {
    log("className[$className] page[$page] event[$event] [INFO] : $message");
    // NewRelicPlugin.customMessage(
    //     eventName: "INFO", message: "className[$className] page[$page] event[$event] [INFO] : $message");
  }

  /// System Print Error
  ///
  /// Param require message: String
  ///
  /// Param className: String
  static error({required String message, String className = "", String page = "", String event = ""}) {
    log("className[$className] page[$page] event[$event] [ERROR] : $message");
    // NewRelicPlugin.error(errorMessage: "className[$className] page[$page] event[$event] [ERROR] : $message");
  }

  /// System Print Screen
  ///
  /// Param require message: String
  static screen(String screen) {
    log("Screen [$screen]");
    // NewRelicPlugin.screen(screen: screen);
  }

  /// System Print login
  ///
  /// Param require message: String
  static login({required String message, String status = "INFO", String className = "", String event = ""}) {
    log("className[$className] page[LoginScreen] event[$event] [$status] : $message");
    // NewRelicPlugin.customMessage(
    //     eventName: "INFO", message: "className[$className] page[$page] event[$event] [INFO] : $message");
  }
}
