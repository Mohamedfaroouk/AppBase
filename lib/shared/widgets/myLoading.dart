import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';

class MyLoading {
  static bool shown = false;

  static show({
    bool fullScreen = true,
  }) {
    if (shown == false) {
      SmartDialog.show(
          clickMaskDismiss: false,
          animationType: SmartAnimationType.scale,
          animationTime: const Duration(milliseconds: 100),
          keepSingle: true,
          builder: (context) => fullScreen
              ? loadingWidget()
              : Dialog(
                  child: SizedBox(
                      width: 200, height: 200, child: loadingWidget())));

      shown = true;
    }
  }

  static Center loadingWidget() => Center(
          child: //LOTTIE
              Lottie.asset(
        'assets/json/loading.json',
        width: 200,
        height: 200,
        fit: BoxFit.fill,
        repeat: true,
      ));

  static dismis() {
    if (shown) {
      SmartDialog.dismiss();
      shown = false;
    } else {}
  }
}
