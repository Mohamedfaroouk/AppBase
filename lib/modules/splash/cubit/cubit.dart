import 'package:appbase/modules/auth/domain/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appbase/modules/splash/cubit/states.dart';

import '../../../core/utils/Utils.dart';
import '../../../core/utils/injection.dart';
import '../../auth/domain/repository/repository.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);

  Future<void> navigateTo() async {
    emit(SplashInitial());
    await Future.delayed(const Duration(seconds: 2));
    Utils.getToken();
    emit(GoHomeState());
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
