import 'dart:developer';

import 'package:efatorh/core/Router/Router.dart';
import 'package:efatorh/core/services/navigation_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:efatorh/core/utils/Utils.dart';
import 'package:efatorh/core/utils/alerts.dart';
import 'package:efatorh/modules/auth/domain/model/user_model.dart';
import 'package:efatorh/modules/auth/domain/request/register_request.dart';
import '../../../core/utils/injection.dart';
import '../domain/repository/repository.dart';
import 'states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  AuthRepository authRepository = locator<AuthRepository>();

  ForgetPasswordRequest forgetPasswordRequest = ForgetPasswordRequest();

  initForgetPasswordRequest() {
    emit(AuthInitial());
    forgetPasswordRequest = ForgetPasswordRequest();
  }

  initRegisterRequest() {
    emit(AuthInitial());
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRepository.login(
        email: email,
        password: password,
      );
      if (response != null) {
        Utils.user = response;
        updateToken(response.token ?? "");

        emit(AuthLoginSuccess());
      }
    } catch (e) {
      Alerts.defaultError();
    }
  }

  Future<void> register({
    required RegisterRequest registerRequest,
  }) async {
    // try {
    final response =
        await authRepository.register(registerRequest: registerRequest);
    if (response != null) {
      updateToken(response.token ?? "");

      Utils.user = response;

      emit(AuthRegisterSuccess());
    }
    // } catch (e) {
    //   Alerts.defaultError();
    // }
  }

  // guest send otp
  Future<void> guestSendOtp({
    required String phone,
    required String countryCode,
  }) async {
    try {
      final response = await authRepository.guestSendOtp(
        phone: phone,
        countryCode: countryCode,
      );
      if (response != null) {
        emit(AuthGuestSendOtpSuccess());
      }
    } catch (e) {
      Alerts.defaultError();
    }
  }

  // guest verify otp

  Future<void> guestVerifyOtp({
    required String phone,
    required String otp,
    required String countryCode,
  }) async {
    try {
      final response = await authRepository.guestVerifyOtp(
        phone: phone,
        otp: otp,
        countryCode: countryCode,
      );
      if (response != null) {
        Utils.user = response;
        emit(AuthGuestVerifyOtpSuccess());
      }
    } catch (e) {
      Alerts.defaultError();
    }
  }
  //send otp

  Future<void> sendOtp({
    required String phone,
    required String countryCode,
  }) async {
    try {
      final response = await authRepository.sendOtp(
        phone: phone,
        countryCode: countryCode,
      );
      if (response != null) {}
    } catch (e) {
      Alerts.defaultError();
    }
  }

  Future<void> verifyOtp({
    required String phone,
    required String otp,
    required String countryCode,
  }) async {
    try {
      final response = await authRepository.verifyOtp(
        phone: phone,
        otp: otp,
        countryCode: countryCode,
      );
      if (response != null) {
        emit(AuthVerifyOtpSuccess());
        NavigationService.pushNamed(Routes.cashier);
      }
    } catch (e) {
      Alerts.defaultError();
    }
  }

  // profile
  Future<void> getProfile() async {
    try {
      final response = await authRepository.getProfile();
      if (response != null) {
        Utils.user = response;
      }
    } catch (e) {
      log(e.toString());

      Alerts.defaultError();
    }
  }

  // update profile
  Future<void> updateProfile({
    required UserModel model,
  }) async {
    try {
      final response = await authRepository.updateProfile(userModel: model);
      if (response != null) {
        Utils.user = UserModel.fromJson(response["data"]);
        Alerts.snack(text: response["message"], state: SnackState.success);
      }
    } catch (e) {
      Alerts.defaultError();
    }
  }

  //logout
  Future logout() async {
    try {
      final response = await authRepository.logout();
      if (response) {
        Utils.user = null;
        Utils.removeToken();
        return true;
      } else {
        Utils.user = null;
        Utils.removeToken();
      }
    } catch (e) {
      Alerts.defaultError();
    }
  }

  //delete account
  Future deleteAccount() async {
    try {
      final response = await authRepository.deleteAccount();
      if (response != null) {
        Utils.user = null;
        Utils.removeToken();
        Alerts.snack(text: response["message"], state: SnackState.success).then(
          (value) {
            NavigationService.goNamed(Routes.loginRoute);
          },
        );

        return true;
      }
    } catch (e) {
      Alerts.defaultError();
    }
  }

  updateToken(String token) {
    Utils.token = token;
    Utils.setToken(token);
  }

  // forget password
  Future forgetPassword({
    String? email,
    String? phone,
    String? countryCode,
  }) async {
    try {
      final response = await authRepository.sendForgetPasswordOtp(
        email: email,
        phone: phone,
        countryCode: countryCode,
      );
      if (response != null) {
        initForgetPasswordRequest();
        forgetPasswordRequest.countryCode = countryCode;
        forgetPasswordRequest.email = email;
        forgetPasswordRequest.phone = phone;
        emit(AuthForgetPasswordSuccess());
      }
    } catch (e) {
      Alerts.defaultError();
    }
  }

  //reset password
  Future resetPassword() async {
    try {
      final response = await authRepository.forgetPassword(
        request: forgetPasswordRequest,
      );
      if (response != null) {
        emit(AuthResetPasswordSuccess());
      }
    } catch (e) {
      Alerts.defaultError();
    }
  }

  @override
  void emit(AuthStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
