
import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/routes/base/base_route.dart';
import 'package:mobile_poss_gp01/util/exception/exception.dart';

class GenerateRoute {
  static Route? route({required RouteSettings routeSettings}) {
    final routeName = routeSettings.name?.split('/');
    if (routeName == null || routeName.isEmpty) return null;
    String key = routeName[0];
    Map<String, Route?> map = {
      BaseRoute.prefixRouteName: BaseRoute.route(routeSettings: routeSettings),
    };
    return (map.containsKey(key)) ? map[key] : throw BadRouteException("Route not found. ${routeSettings.name}");
  }
}
