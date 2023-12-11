import 'package:easy_localization/easy_localization.dart';

class Validation {
  static String? defaultValidation(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return ('requiredField'.tr());
      }
      //short
      // if (value.length < (3)) //value.length < 3
      // {
      //   return ('shortField'.tr());
      // }
      return null;
    }
    return null;
  }

  static String? numValidation(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return ('requiredField'.tr());
      }
      if (double.tryParse(value) == 0.0) {
        return ('requiredField'.tr());
      }
    }
    return null;
  }

  static String? phoneValidation(String? value, {bool required = true}) {
    if (value != null) {
      if (value.isEmpty && required) {
        return ('phoneRequired'.tr());
      } else if ((value.length < 9 || value.length > 12) && value.isNotEmpty) {
        return ('phoneInvalid'.tr());
      }
      return null;
    }
    return null;
  }

  static RegExp emailReg = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static String? emailValidation(
    String? value,
  ) {
    if (value!.trim().isEmpty) {
      return ('requiredField'.tr());
    } else if (!emailReg.hasMatch(value.trim())) {
      return ('wrongEmailValidation'.tr());
    } else {
      return null;
    }
  }

  static String? passwordValidation(String? value) {
    if (value!.trim().isEmpty) {
      return ('requiredField'.tr());
    } else if (value.trim().length < 8) {
      return ('smallPass'.tr());
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidation(value, String password) {
    if (value!.isEmpty) {
      return 'requiredField'.tr(args: ["confirmPassword".tr()]);
    } else if (password != value) {
      return ('passwordNotMatch'.tr());
    } else {
      return null;
    }
  }
}
