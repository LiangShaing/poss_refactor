import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/main.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';


class MyNavigator extends NavigatorObserver {
  static Future? push(name, [args]) {
    Logger.debug(message: 'push [ $name ]');
    // NewRelicPlugin.route(message: 'push [ $name ]');
    return navigationKey.currentState?.pushNamed(name, arguments: args);
  }

  /// 回上一頁,value是回調的值
  static void pop([value]) {
    Logger.debug(message: 'pop');
    navigationKey.currentState?.pop(value);
  }

  /// pop到指定頁面
  static void popTo(name) {
    Logger.debug(message: 'popTo $name');
    // NewRelicPlugin.route(message: "popTo $name");
    navigationKey.currentState?.popUntil(ModalRoute.withName(name));
  }

  /// 當頁可否回上一頁
  static bool canPop() {
    Logger.debug(message: 'canPop');
    return navigationKey.currentState?.canPop() ?? false;
  }

  /// 會先調用canPop，若返回false則無效果
  static void maybePop() {
    Logger.debug(message: 'maybePop');
    navigationKey.currentState?.maybePop();
  }

  ///取代當頁
  static Future replace(name, [args]) async {
    Logger.debug(message: 'replace [ $name ]');
    // NewRelicPlugin.route(message: 'replace [ $name ]');
    await navigationKey.currentState?.pushReplacementNamed(name, arguments: args);
  }

  /// 先執行pop再執行push
  static void popAndPush(name, [args]) {
    Logger.debug(message: 'popAndPush [ $name ]');
    // NewRelicPlugin.route(message: 'popAndPush [ $name ]');
    navigationKey.currentState?.popAndPushNamed(name, arguments: args);
  }

  /// push並重至路由
  static Future? pushReset(name, [args, util]) {
    if (util == null) {
      Logger.debug(message: 'pushReset [ $name ]');
      // NewRelicPlugin.route(message: 'pushReset [ $name ]');
      return navigationKey.currentState?.pushNamedAndRemoveUntil(name, (route) => false, arguments: args);
    } else {
      Logger.debug(message: 'pushReset [ $util -> $name ]');
      // NewRelicPlugin.route(message: 'pushReset [ $util -> $name ]');
      return navigationKey.currentState?.pushNamedAndRemoveUntil(name, ModalRoute.withName(util), arguments: args);
    }
  }

  static String? restorablePopAndPushNamed(name, [args]) {
    Logger.debug(message: 'restorablePopAndPushNamed $name');
    return navigationKey.currentState?.restorablePopAndPushNamed(name);
  }
}
