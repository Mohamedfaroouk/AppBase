class RegisterRequest {
  String? name;
  String? phone;
  String? email;
  String? address;
  String? cityId;
  String? password;
  String? countryCode;

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (password != null) {
      result.addAll({'password': password});
    }
    if (countryCode != null) {
      result.addAll({'country_code': countryCode});
    }
    if (cityId != null) {
      result.addAll({'city_id': cityId});
    }

    return result;
  }
}

class ForgetPasswordRequest {
  String? email;
  String? phone;
  String? countryCode;
  String? token;
  String? password;
  String? passwordConfirmation;
  ForgetPasswordRequest({
    this.email,
    this.phone,
    this.token,
    this.password,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (email != null && email!.isNotEmpty) {
      result.addAll({'email': email});
    }
    if (phone != null && phone!.isNotEmpty) {
      result.addAll({'phone': phone});
    }
    if (countryCode != null && countryCode!.isNotEmpty) {
      result.addAll({'country_code': countryCode});
    }

    if (token != null) {
      result.addAll({'otp': token});
    }
    if (password != null) {
      result.addAll({'password': password});
    }
    if (passwordConfirmation != null) {
      result.addAll({'password_confirmation': passwordConfirmation});
    }

    return result;
  }
}
