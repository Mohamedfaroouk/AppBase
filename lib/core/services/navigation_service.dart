import 'dart:developer';

import 'package:flutter/material.dart';

import '../Router/Router.dart';
import '../utils/injection.dart';

class NavigationService {
  static final route = locator<Routes>();
  static goNamed(
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    route.goRouter.goNamed(routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
  }

  static BuildContext get context => route.goRouter.routeInformationParser
      .configuration.navigatorKey.currentState!.context;
  // pushNamed
  static Future<T?> pushNamed<T>(String routeName,
      {Map<String, String> pathParameters = const <String, String>{},
      Map<String, dynamic> queryParameters = const <String, dynamic>{},
      Object? extra}) async {
    return route.goRouter.pushNamed<T>(routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra);
  }

  static mobileNavigateTo(String routeName) {
    // check for slide left or right
    final slide = slideLeftOrRight(routeName);
    goNamed(routeName, extra: {"transition": slide});
    log("slide $slide");
  }

  //pop
  static pop<T>([T? result]) {
    route.goRouter.pop(result);
  }

  //check for current route
  static bool isRouteContain(String routeName) {
    return route.goRouter.routeInformationProvider.value.location
            ?.contains(routeName) ??
        false;
  }
  // is mobile route

  static bool isMobileRouteContain() {
    return mobileRoutes()
        .contains(route.goRouter.routeInformationProvider.value.location ?? "");
  }

  static mobileRoutes() {
    return [
      Routes.sales,
      Routes.client,
      Routes.cashier,
      Routes.product,
      Routes.storeDetailsRoute,
    ];
  }

  static String slideLeftOrRight(String newRoute) {
    final currentRoute =
        route.goRouter.routeInformationProvider.value.location ?? "";
    final currentRouteIndex = mobileRoutes()
        .indexOf(route.goRouter.namedLocation(currentRoute) ?? "");

    final newRouteIndex = mobileRoutes().indexOf(newRoute);
    if (currentRouteIndex < newRouteIndex) {
      return "slideRight";
    } else {
      return "slideLeft";
    }
  }
}
