import 'package:efatorh/core/Router/Router.dart';
import 'package:efatorh/core/services/navigation_service.dart';
import 'package:efatorh/core/utils/Utils.dart';

class AuthGuard {
  final excludeRoutes = [
    Routes.splashRoute,
    Routes.otpScreen,
    Routes.onBoardingRoute,
    Routes.loginRoute,
    Routes.registerRoute,
    Routes.forgotPasswordRoute,
    Routes.changePassword,
    Routes.changePhoneScreen,
  ];

  bool canNavigate(String routeName) {
    if (excludeRoutes.contains(NavigationService.route.goRouter.namedLocation(routeName))) {
      return true;
    }
    if (Utils.token.isEmpty) {
      return false;
    }
    return true;
  }
}
