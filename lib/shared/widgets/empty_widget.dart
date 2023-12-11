import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'customtext.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, this.text}) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/json/empty.json',
          width: 350,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 30.0,
        ),
        CustomText(
          text ?? 'noData'.tr(),
          fontSize: 24,
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}
