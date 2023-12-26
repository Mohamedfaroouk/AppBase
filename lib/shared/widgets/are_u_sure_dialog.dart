import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/theme/dynamic_theme/colors.dart';
import 'package:appbase/shared/widgets/customtext.dart';
import 'package:flutter/material.dart';

class AreYouSureDialog extends StatelessWidget {
  const AreYouSureDialog({
    Key? key,
    required this.title,
    required this.onConfirm,
  }) : super(key: key);

  final String title;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        title,
        fontSize: 15,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: CustomText(
              "no".tr(),
              fontSize: 13,
              color: AppColors.primary,
            )),
        TextButton(
            onPressed: onConfirm,
            child: CustomText(
              "yes".tr(),
              fontSize: 13,
              color: AppColors.primary,
            ))
      ],
    );
  }
}
