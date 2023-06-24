import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/routes/base/arguments/login_screen_route_arguments.dart';
import 'package:mobile_poss_gp01/routes/custom_page_route.dart';
import 'package:mobile_poss_gp01/widgets/screens/index/index_screen.dart';
import 'package:mobile_poss_gp01/widgets/screens/index/menu_screen.dart';
import 'package:mobile_poss_gp01/widgets/screens/login/login_screen.dart';

class BaseRoute {
  static String prefixRouteName = "base";

  /* 登入頁 */
  static String loginScreenRouteName = "${BaseRoute.prefixRouteName}/loginScreen";

  static String indexScreenRouteName = "${BaseRoute.prefixRouteName}/indexScreen";

  static String menuScreenRouteName = "${BaseRoute.prefixRouteName}/menuScreen";

  static Route? route({required RouteSettings routeSettings}) {
    dynamic args = routeSettings.arguments;

    Map<String, WidgetBuilder> map = {
      BaseRoute.loginScreenRouteName: (_) => LoginScreen(args: args ?? LoginScreenArguments()),
      BaseRoute.indexScreenRouteName: (_) => const IndexScreen(),
      BaseRoute.menuScreenRouteName: (_) => const MenuScreen(),
    };
    debugPrint("routeSettings.name ${routeSettings.name}");
    return (map.containsKey(routeSettings.name)) ? CustomPageRoute(builder: map[routeSettings.name]!) : null;
  }
}
