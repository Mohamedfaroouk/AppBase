import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/shared/widgets/applogo.dart';
import 'package:appbase/shared/widgets/buttons.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../../core/utils/alerts.dart';
import 'customtext.dart';

class SnackDesign extends StatelessWidget {
  const SnackDesign({
    Key? key,
    required this.state,
    required this.text,
  }) : super(key: key);
  final SnackState state;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state == SnackState.success
                ? Lottie.asset(
                    "assets/json/success.json",
                    width: 100,
                    height: 90,
                  )
                : const AppLogo(
                    whiteFont: true,
                  ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: CustomText(
                text,
                weight: FontWeight.bold,
                align: TextAlign.center,
                fontSize: 20,
                textStyleEnum: TextStyleEnum.normal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: DefaultButton(
                text: "done".tr(),
                onTap: () {
                  SmartDialog.dismiss();
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
