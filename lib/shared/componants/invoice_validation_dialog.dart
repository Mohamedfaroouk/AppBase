import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/theme/dynamic_theme/colors.dart';
import 'package:appbase/shared/widgets/customtext.dart';
import 'package:flutter/material.dart';

import '../widgets/applogo.dart';
import '../widgets/buttons.dart';

class InvoiceValidationDialog extends StatelessWidget {
  const InvoiceValidationDialog({super.key, required this.validations});
  final List<String> validations;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppLogo(),
          const SizedBox(
            height: 20,
          ),
          CustomText("shouldEnterValidData".tr(),
              align: TextAlign.center, fontSize: 16),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...validations.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: CustomText(" * $e",
                      align: TextAlign.start, color: AppColors.error),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          DefaultButton(
            text: "accept".tr(),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
