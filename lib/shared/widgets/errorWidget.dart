import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:efatorh/shared/widgets/customtext.dart';

class ErrorWidgetWithTryAgain extends StatelessWidget {
  const ErrorWidgetWithTryAgain({
    this.title,
    this.message,
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final String? title;
  final String? message;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title ?? "somethingWentWrong".tr(),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomText(
              message ?? "errorMassage".tr(),
            ),
            if (onTryAgain != null)
              const SizedBox(
                height: 48,
              ),
            if (onTryAgain != null)
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTryAgain,
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  label: CustomText(
                    'pleaseTryAgain'.tr(),
                    color: Colors.white,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
