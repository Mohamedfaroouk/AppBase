import '../../../../core/data_source/dio.dart';
import '../model/user_model.dart';
import '../request/register_request.dart';
import 'endpoints.dart';

class AuthRepository {
  final DioService dioService;
  AuthRepository(this.dioService);

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    final response = await dioService.postData(
      url: AuthEndPoints.login,
      body: {
        "email": email,
        "password": password,
      },
      loading: true,
    );
    if (response.isError == false) {
      return UserModel.fromJson(response.response?.data);
    }
    return null;
  }

  // register
  Future<UserModel?> register({
    required RegisterRequest registerRequest,
  }) async {
    final response = await dioService.postData(
      url: AuthEndPoints.register,
      body: registerRequest.toJson(),
      loading: true,
    );
    if (response.isError == false) {
      return UserModel.fromJson(response.response?.data);
    }
    return null;
  }
  // guest send otp

  Future guestSendOtp({
    required String phone,
    required String countryCode,
  }) async {
    final response = await dioService.postData(
      url: AuthEndPoints.guestRegistration,
      body: {
        "phone": phone,
        "country_code": countryCode,
      },
      loading: true,
    );
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  // guest verify otp

  Future<UserModel?> guestVerifyOtp({
    required String phone,
    required String countryCode,
    required String otp,
  }) async {
    final response = await dioService.postData(
      url: AuthEndPoints.guestRegisterVerify,
      body: {
        "phone": phone,
        "country_code": countryCode,
        "otp": otp,
      },
      loading: true,
    );
    if (response.isError == false) {
      return UserModel.fromJson(response.response?.data["data"]);
    }
    return null;
  }

  // verify otp
  Future<UserModel?> verifyOtp({
    required String phone,
    required String countryCode,
    required String otp,
  }) async {
    final response = await dioService.postData(
      url: AuthEndPoints.verifyOtp,
      body: {
        "phone": phone,
        "country_code": countryCode,
        "otp": otp,
      },
      loading: true,
    );
    if (response.isError == false) {
      return UserModel.fromJson(response.response?.data["data"]);
    }
    return null;
  }
  // send otp

  Future sendOtp({
    required String phone,
    required String countryCode,
  }) async {
    final response = await dioService.postData(
      url: AuthEndPoints.sendOtp,
      body: {
        "phone": phone,
        "country_code": countryCode,
      },
      loading: true,
    );
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  // logout
  Future<bool> logout() async {
    final response = await dioService.getData(
      url: AuthEndPoints.logout,
      loading: true,
    );
    if (response.isError == false) {
      return true;
    }
    return false;
  }

  // delete account
  Future deleteAccount() async {
    final response = await dioService.getData(
      url: AuthEndPoints.deleteAccount,
      loading: true,
    );
    if (response.isError == false) {
      return response.response?.data;
    }
  }

  // profile

  Future<UserModel?> getProfile() async {
    final response = await dioService.getData(
      url: AuthEndPoints.profile,
      loading: false,
    );
    if (response.isError == false) {
      return UserModel.fromJson({"data": response.response?.data});
    }
    return null;
  }

  Future updateProfile({
    required UserModel userModel,
  }) async {
    final response = await dioService.postData(
      url: AuthEndPoints.updateProfile,
      body: userModel.toJson(),
      loading: true,
    );
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  // user data
  Future<UserModel?> getUserData() async {
    final response = await dioService.getData(
      url: AuthEndPoints.userData,
      loading: false,
    );
    if (response.isError == false) {
      return UserModel.fromJson({"data": response.response?.data});
    }
    return null;
  }

  // forget pass
  Future forgetPassword({required ForgetPasswordRequest request}) async {
    final response = await dioService.postData(url: AuthEndPoints.resetPassword, body: request.toJson(), loading: true);
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }

  // send forget pass otp
  Future sendForgetPasswordOtp({String? email, String? phone, String? countryCode}) async {
    final response = await dioService.postData(
        url: AuthEndPoints.resetPasswordOtp,
        body: {
          if (email != null) "email": email,
          if (phone != null) "phone": phone,
          if (countryCode != null) "country_code": countryCode,
        },
        loading: true);
    if (response.isError == false) {
      return response.response?.data;
    }
    return null;
  }
}
