import 'package:efatorh/core/Router/auth_guard.dart';
import 'package:efatorh/modules/auth/presentation/change_password.dart';
import 'package:efatorh/modules/auth/presentation/change_phone.dart';
import 'package:efatorh/modules/auth/presentation/forgot_password.dart';
import 'package:efatorh/modules/auth/presentation/otp.dart';
import 'package:efatorh/modules/layout/presentation/layout.dart';
import 'package:efatorh/modules/static_page/presentation/about_us.dart';
import 'package:efatorh/modules/static_page/presentation/contact_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../modules/auth/presentation/login.dart';
import '../../modules/auth/presentation/register.dart';
import '../../modules/client/presentation/client.dart';
import '../../modules/client/presentation/edit_add/edit_add_client.dart';
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
  static const String onBoardingRoute = "/onBoarding";
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
  static const String invoice = "/invoice";
  static const String paymentMethodPage = "/paymentMethodPage";
  static const String addClient = "/add_client";
  static const String profilePage = "/ProfilePage";
  static const String editClient = "/edit_client";
  static const String updateClient = "/update_client";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/store-details";
  static const String client = "/clients";
  static const String payment = "/payment";
  static const String posOffline = "/posOffline";
  static const String reports = "/reports";
  static const String purchaseRefund = "/purchaseRefund";
  static const String currentPackedge = "/current_packedge";
  static const String upgradePackedge = "/upgrade_packedge";
  static const String notification = "/notificat/CreatePurchaseInvoiceion";
  static const String contactUs = "/contact-us";
  static const String aboutUs = "/about-us";
  static const String createTaxReturn = "/createTaxReturn";
  static const String suppliers = "/suppliers";
  static const String editAddSupplier = "/editAddSupplier";
  static const String productMovement = "/productMovement";
  static const String cashier = "/cashier";

  static const String paymentMethod = "/paymentMethod";
  static const String addPaymentMethod = "/addPaymentMethod";
  static const String editPaymentMethod = "/editPaymentMethod";

  static const String supplier = "/supplier";
  static const String addSupplier = "/addSupplier";
  static const String editSupplier = "/editSupplier";

  static const String category = "/category";
  static const String addCategory = "/addCategory";
  static const String editCategory = "/editCategory";

  static const String tiler = "/tiler";
  static const String addTiler = "/addTiler";
  static const String editTiler = "/editTiler";
  static const String shifts = "/shifts";

  static const String employee = "/employee";
  static const String addEmployee = "/addEmployee";
  static const String editEmployee = "/editEmployee";

  static const String product = "/product";
  static const String addProduct = "/addProduct";
  static const String editProduct = "/editProduct";

  static const String sales = "/sales";
  static const String showSales = "/showSales";
  static const String refundSales = "/refundSales";

  static const String purchaseInvoice = "/purchaseInvoice";
  static const String addPurchaseInvoice = "/addPurchaseInvoice";
  static const String showPurchaseInvoice = "/showPurchaseInvoice";
  static const String refundPurchase = "/refundPurchase";

  static const String quatation = "/quotation";
  static const String createQuotation = "/createQuotation";
  static const String viewQuotation = "/viewQuotation";

  static const String taxReturn = "/taxReturn";
  static const String addTaxReturn = "/addTaxReturn";
  static const String viewTaxReturn = "/viewTaxReturn";

  static const String stock = "/stock";

  static const String packages = "/packages";
  static const String viewPackages = "/viewPackages";
  static const String upgradePackedgeDetails = "/upgrade_packedge_details";

  static const String storeSetting = "/storeSetting";
  static const String profile = "/profile";

  static String currentRoute = "/";
  static String needUpgrade = "/needUpgrade";
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
                  routes: [
                    GoRoute(
                        parentNavigatorKey: mobileRouteKey,
                        path: "/clients",
                        name: Routes.client,
                        pageBuilder: (context, state) => Routes.pageBuilder(
                            context, state,
                            child: const ClientScreen()),
                        routes: [
                          GoRoute(
                            parentNavigatorKey: layoutRouteKey,
                            path: "add",
                            name: Routes.addClient,
                            pageBuilder: (context, state) => Routes.pageBuilder(
                                context, state,
                                child: const EditAddClient()),
                          ),
                          GoRoute(
                            parentNavigatorKey: layoutRouteKey,
                            path: "edit",
                            name: Routes.editClient,
                            redirect: (context, state) {
                              state.extra == null ? Routes.client : null;
                              return null;
                            },
                            pageBuilder: (context, state) => Routes.pageBuilder(
                              context,
                              state,
                              child: EditAddClient(
                                client: (state.extra as Map?)?['client'],
                              ),
                            ),
                          ),
                        ])
                  ]),

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
