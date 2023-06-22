// import 'package:flutter/material.dart';
//
// class BaseRoute {
//
//   static String prefixRouteName = "base";
//
//   /* 登入頁 */
//   static String loginPageRouteName = "${BaseRoute.prefixRouteName}/loginpage";
//
//   static String indexPageRouteName = "${BaseRoute.prefixRouteName}/indexpage";
//
//
//   static Route? route({required RouteSettings routeSettings}) {
//     dynamic args = routeSettings.arguments;
//
//     Map<String, WidgetBuilder> map = {
//       BaseRoute.loginPageRouteName: (_) => LoginPageStatefulWidget(args: args ?? LoginPageArguments()),
//       BaseRoute.indexPageRouteName: (_) =>  const IndexPageStatefulWidget(),
//     };
//     debugPrint("routeSettings.name ${routeSettings.name}");
//     return (map.containsKey(routeSettings.name))
//         ? CustomPageRoute(builder: map[routeSettings.name]!)
//         : null;
//   }
// }
//
