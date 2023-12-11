import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/dynamic_theme/colors.dart';
import '../../../../shared/widgets/customtext.dart';

class SwitchLoginAndRegister extends StatelessWidget {
  const SwitchLoginAndRegister({
    super.key,
    required this.isLogin,
  });
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 0,
        color: AppColors.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomText(isLogin ? "dontHaveAccount".tr() : "alreadyHaveAccount".tr(), fontSize: 17, color: AppColors.outline),
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.primary, width: 1))),
                child: CustomText(isLogin ? "register".tr() : "login".tr(), fontSize: 17, weight: FontWeight.bold, color: AppColors.primary),
              ),
            ),
          ],
        ));
  }
}
