import 'dart:async';
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

  static Timer? timer;

  static mobileNavigateTo(String routeName) {
    // check for slide left or right
    final slide = slideLeftOrRight(routeName);
    if (timer?.isActive == true) return;
    goNamed(routeName, extra: {"transition": slide});
    timer = Timer(const Duration(milliseconds: 800), () {
      timer?.cancel();
    });
    //start timer

    log("slide $slide");
  }

  //pop
  static pop<T>([T? result]) {
    route.goRouter.pop(result);
  }

  //check for current route
  static bool isRouteContain(String routeName) {
    return Routes.currentRoute == routeName;
  }
  // is mobile route

  static bool isMobileRouteContain() {
    final currentRouteIndex = mobileRoutes()
        .indexOf(route.goRouter.namedLocation(Routes.currentRoute));
    return currentRouteIndex != -1;
  }

  static String slideLeftOrRight(String newRoute) {
    final currentRoute = Routes.currentRoute;
    final currentRouteIndex = mobileRoutes()
        .indexOf(route.goRouter.namedLocation(currentRoute) ?? "");

    final newRouteIndex = mobileRoutes().indexOf(newRoute);
    if (currentRouteIndex < newRouteIndex) {
      return "slideRight";
    } else {
      return "slideLeft";
    }
  }

// MOBILE NAVIGATION ROUTES
  static mobileRoutes() {
    return [
      Routes.feature1,
      Routes.feature2,
      Routes.feature3,
      Routes.home,
    ];
  }
}
