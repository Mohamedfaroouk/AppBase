import 'package:appbase/core/Router/auth_guard.dart';
import 'package:appbase/modules/auth/presentation/change_password.dart';
import 'package:appbase/modules/auth/presentation/change_phone.dart';
import 'package:appbase/modules/auth/presentation/forgot_password.dart';
import 'package:appbase/modules/auth/presentation/otp.dart';
import 'package:appbase/modules/home/presentation/home.dart';
import 'package:appbase/modules/layout/presentation/layout.dart';
import 'package:appbase/modules/static_page/presentation/about_us.dart';
import 'package:appbase/modules/static_page/presentation/contact_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/auth/presentation/login.dart';
import '../../modules/auth/presentation/register.dart';
import '../../modules/layout/presentation/mobile_layout.dart';
import '../../modules/splash/presentation/splash.dart';

// rootkey
GlobalKey<NavigatorState> rootKey =
    GlobalKey<NavigatorState>(debugLabel: "rootKey");
//mobile route  key
GlobalKey<NavigatorState> mobileRouteKey =
    GlobalKey<NavigatorState>(debugLabel: "mobileRouteKey");
GlobalKey<NavigatorState> layoutRouteKey =
    GlobalKey<NavigatorState>(debugLabel: "layoutRouteKey");

class Routes {
  static const String changeBase = "changebase";
  static const String splashRoute = "/";
  static const String home = "/home";
  static const String otpScreen = "/otp-screen";
  static const String changePassword = "/reset-password";
  static const String verifyUser = "/verftyUser";
  static const String registerWithPhone = "/registerWithPhone";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forget-password";
  static const String changePhoneScreen = "/change-phone";
  static const String loginRoute = "/login";
/////////////
////////////
////////////
  static const String feature1 = "/feature1";
  static const String feature2 = "/feature2";
  static const String feature3 = "/feature3";

  static const String contactUs = "/contact-us";
  static const String aboutUs = "/about-us";

  static String currentRoute = "";
  static AuthGuard authGuard = AuthGuard();
  GoRouter goRouter = GoRouter(
      // redirect: (context, state) {
      //   if (!authGuard.canNavigate(state.fullPath ?? "")) {
      //     print("redirect  ${state.fullPath!}");
      //     return Routes.loginRoute;
      //   }
      //   return null;
      // },
      navigatorKey: rootKey,
      initialLocation: Routes.splashRoute,
      routes: [
        GoRoute(
          path: '/',
          name: Routes.splashRoute,
          pageBuilder: (context, state) =>
              pageBuilder(context, state, child: const SplashScreen()),
        ),
        GoRoute(
          path: '/login',
          name: Routes.loginRoute,
          pageBuilder: (context, state) =>
              pageBuilder(context, state, child: const LoginScreen()),
        ),
        GoRoute(
            path: '/register',
            name: Routes.registerRoute,
            pageBuilder: (context, state) => pageBuilder(
                  context,
                  state,
                  child: const RegisterScreen(),
                )),
        GoRoute(
            path: '/forget-password',
            name: Routes.forgotPasswordRoute,
            pageBuilder: (context, state) => pageBuilder(
                  context,
                  state,
                  child: const ForgotPasswordView(),
                )),
        GoRoute(
          path: '/reset-password',
          name: Routes.changePassword,
          pageBuilder: (context, state) =>
              pageBuilder(context, state, child: const ChangePassword()),
        ),
        GoRoute(
          path: '/change-phone',
          name: Routes.changePhoneScreen,
          pageBuilder: (context, state) =>
              pageBuilder(context, state, child: const ChangePhoneScreen()),
        ),
        ShellRoute(
            navigatorKey: layoutRouteKey,
            builder: (context, state, child) {
              return LayoutScreen(
                child: child,
              );
            },
            routes: [
              ShellRoute(
                  parentNavigatorKey: layoutRouteKey,
                  navigatorKey: mobileRouteKey,
                  builder: (context, state, child) {
                    return MobileLayoutScreen(
                      child: child,
                    );
                  },
                  //THIS FOR ROUTES IN THE BOTTOM NAVIGATION BAR
                  //THIS FOR ROUTES IN THE BOTTOM NAVIGATION BAR
                  //THIS FOR ROUTES IN THE BOTTOM NAVIGATION BAR
                  routes: [
                    GoRoute(
                      parentNavigatorKey: mobileRouteKey,
                      path: "/Feature1",
                      name: Routes.feature1,
                      pageBuilder: (context, state) =>
                          Routes.pageBuilder(context, state,
                              child: Container(
                                color: Colors.amber,
                              )),
                    ),
                    GoRoute(
                      parentNavigatorKey: mobileRouteKey,
                      path: "/home",
                      name: Routes.home,
                      pageBuilder: (context, state) => Routes.pageBuilder(
                          context, state,
                          child: const HomeScreen()),
                    ),
                    GoRoute(
                      parentNavigatorKey: mobileRouteKey,
                      path: "/Feature2",
                      name: Routes.feature2,
                      pageBuilder: (context, state) =>
                          Routes.pageBuilder(context, state,
                              child: Container(
                                color: Colors.red,
                              )),
                    ),
                    GoRoute(
                      parentNavigatorKey: mobileRouteKey,
                      path: "/Feature3",
                      name: Routes.feature3,
                      pageBuilder: (context, state) =>
                          Routes.pageBuilder(context, state,
                              child: Container(
                                color: Colors.green,
                              )),
                    ),
                  ]),

              /// ROUTES OUTSIDE THE BOTTOM NAVIGATION BAR
              GoRoute(
                parentNavigatorKey: layoutRouteKey,
                path: '/contactUs',
                name: Routes.contactUs,
                pageBuilder: (context, state) =>
                    pageBuilder(context, state, child: const ContactUs()),
              ),
              //aboutUs
              GoRoute(
                parentNavigatorKey: layoutRouteKey,
                path: '/aboutUs',
                name: Routes.aboutUs,
                pageBuilder: (context, state) =>
                    pageBuilder(context, state, child: const AboutUS()),
              ),
            ]),
        GoRoute(
          path: '/otp',
          name: Routes.otpScreen,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            return Otpscreen(
              onReSend: args['onReSend'],
              phone: args['phone'] as String,
              code: args['countryCode'] as String,
              onVerify: args['onVerify'],
              sendOnStart: args['sendOnStart'],
            );
          },
        ),
      ]);
  static Page pageBuilder(BuildContext context, GoRouterState state,
      {required Widget child, bool maintainState = false}) {
    currentRoute = state.name ?? "";
    switch ((state.extra as Map?)?["transition"]) {
      case "slideLeft":
        return slideLeftTransition(context, state,
            child: child, maintainState: maintainState);
      case "slideRight":
        return slideRightTranslation(context, state,
            child: child, maintainState: maintainState);

      default:
        return CupertinoPage(
          maintainState: maintainState,
          key: state.pageKey,
          child: child,
        );
    }
  }

  // slide lift nav
  static Page slideLeftTransition(BuildContext context, GoRouterState state,
      {required Widget child, bool maintainState = false}) {
    return CustomTransitionPage(
      maintainState: maintainState,
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

  static Page slideRightTranslation(BuildContext context, GoRouterState state,
      {required Widget child, bool maintainState = false}) {
    return CustomTransitionPage(
      maintainState: maintainState,
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
