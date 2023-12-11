import 'package:efatorh/modules/auth/domain/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:efatorh/modules/splash/cubit/states.dart';

import '../../../core/utils/Utils.dart';
import '../../../core/utils/injection.dart';
import '../../auth/domain/repository/repository.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);

  Future<void> navigateTo() async {
    emit(SplashInitial());
    // get Token from cash
    Utils.getToken();

    ///////////
    if (Utils.token.isNotEmpty) {
      // try to get user data
      await getUserData();
      //  un authorized Error
      if (Utils.user == null && Utils.token.isEmpty) {
        //
      }
      // network Error
      else if (Utils.user == null && Utils.token.isNotEmpty) {
        emit(SplashNetworkErrorState());
      }
      // success
      else {
        if (Utils.user?.phoneVerified == 1) {
          emit(LoginAndVerifiedState());
        } else {
          emit(LoginNeedVerifyState());
        }
      }
    } else {
      //NotLogin
      await Future.delayed(const Duration(seconds: 3));
      if (Utils.pref().viewOnboarding == false) {
        emit(NotLoginNoInBoardingState());
      } else {
        emit(NotLoginState());
      }
    }
  }

  Future<UserModel?> getUserData() async {
    final respose = await locator<AuthRepository>().getUserData();
    if (respose != null) {
      Utils.user = respose;
      return respose;
    }
    return null;
  }

  validatePhone() {
    if (Utils.user?.phoneVerified == 1) {
      return true;
    } else {
      return false;
    }
  }
}
