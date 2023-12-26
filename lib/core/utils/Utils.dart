import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:appbase/modules/auth/domain/model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/componants/store_setting_model.dart';
import '../../shared/models/general_setting.dart';
import 'injection.dart';
import '../data_source/PrefService.dart';

class Utils {
  static PrefService pref() => locator<PrefService>();
  static GlobalKey<ScaffoldState> drawer() =>
      locator<GlobalKey<ScaffoldState>>();
  static GlobalKey<NavigatorState> navigatorKey() =>
      locator<GlobalKey<NavigatorState>>();
  static UserModel? user;
  static LatLng? userLocation;
  static String token = "";
  static String local = "ar";
  static bool taxable = true;
  static double taxValue = 15;
  static RegExp englishRegEx = RegExp('[a-zA-Z ]|[1-9]');
  static RegExp doubleNumRegEx = RegExp(r'(^\d*\.?\d*)');
  static RegExp intNumRegEx = RegExp(r'(^\d*)');
  static RegExp arabicRegEx = RegExp(
      '[\u0600-\u06ff ]|[\u0750-\u077f ]|[\ufb50-\ufc3f ]|[\ufe70-\ufefc ]|[1-9]');
  static GeneralSettings generalSettings = GeneralSettings();
  static StoreSetting storeSettings = StoreSetting();

  //////////[UseForHideSomeAppFeaturesFromAppleReview]////////////////
  static bool get showIfAppleEndReview {
    if (Platform.isIOS == false) return true;
    return Utils.generalSettings.isInAppReview == false;
  }

  static setToken(String token) {
    Utils.token = token;
    pref().userToken = token;
  }

  static removeToken() {
    token = "";
    pref().userToken = "";
  }

  static getToken() {
    token = pref().userToken;
  }

  static requestHelp() {
    String phone = "+966558030980";
    var url = "";
    if (Platform.isIOS) {
      url = "whatsapp://wa.me/$phone";
    } else {
      url = "whatsapp://send?phone=$phone";
    }
    launchUrl(Uri.parse(url));
  }

  static void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  static void fixRtlLastChar(TextEditingController? controller) {
    if (controller != null) {
      if (controller.selection ==
          TextSelection.fromPosition(
              TextPosition(offset: (controller.text.length) - 1))) {
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      }
    }
  }

  static genrateBarcode() {
    return (Random().nextInt(99999999) + 10000000).toString();
  }

  static double getSizeOfFile(File file) {
    final size = file.readAsBytesSync().lengthInBytes;
    final kb = size / 1024;
    final mb = kb / 1024;
    print(mb);
    return mb;
  }
}

extension DoubleExtensions on num? {
  String get roundTo2numberString {
    return this == null
        ? "0"
        : this!.truncateToDouble() == this!
            ? this!.toStringAsFixed(0)
            : this!.toStringAsFixed(2);
  }

  String get roundTo4numberString {
    return this == null
        ? "0"
        : this!.truncateToDouble() == this!
            ? this!.toStringAsFixed(0)
            : this!.toStringAsFixed(4);
  }
}

extension StringExtensions on String? {
  // remove zero from the start of the string
  String get removeZero {
    if (this == null) return "";
    if (this!.startsWith("0")) {
      return this!.substring(1);
    } else {
      return this!;
    }
  }

  String get formateDate {
    if (this == null) return "";

    var date = DateTime.tryParse(this!) ?? DateTime.now();
    return DateFormat("yyyy-MM-dd HH:mm", "en").format(
      date,
    );
  }

  String get formateDateTime {
    if (this == null) return "";

    var date = DateTime.tryParse(this!) ?? DateTime.now();
    return DateFormat("yyyy-MM-dd HH:mm:ss", "en").format(
      date,
    );
  }

  String get formateDateOnly {
    if (this == null) return "";

    var date = DateTime.tryParse(this!) ?? DateTime.now();
    return DateFormat("yyyy-MM-dd", "en").format(
      date,
    );
  }

  // todouble
  double toDouble() => double.tryParse(this ?? "0") ?? 0;
}

extension formatData on DateTime {
  String get formatedDateTime =>
      DateFormat("yyyy-MM-dd HH:mm", "en").format(this);
}

extension LocalReverse on List {
  get reverseLocal {
    if (Utils.local == "ar") {
      return reversed.toList();
    }
    return this;
  }
}
