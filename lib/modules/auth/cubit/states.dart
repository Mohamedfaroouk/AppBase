abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthRegisterSuccess extends AuthStates {}

class AuthLoginSuccess extends AuthStates {}

class AuthVerifyOtpSuccess extends AuthStates {}

class AuthGuestSendOtpSuccess extends AuthStates {}

class AuthGuestVerifyOtpSuccess extends AuthStates {}

class AuthForgetPasswordSuccess extends AuthStates {}

class AuthResetPasswordSuccess extends AuthStates {}

class AuthChangePasswordSuccess extends AuthStates {}

class AuthLogoutSuccess extends AuthStates {}
