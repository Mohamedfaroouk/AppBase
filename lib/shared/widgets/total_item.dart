import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'customtext.dart';

class TotalItem extends StatelessWidget {
  const TotalItem({
    super.key,
    required this.title,
    required this.value,
    this.isDesktop = false,
  });
  final String title;
  final String value;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            "${title.tr()} ",
            color: Colors.black,
            fontSize: isDesktop ? 14 : 16,
            weight: FontWeight.bold,
          ),
          const Spacer(),
          CustomText(
            "$value ",
            color: Colors.black,
            fontSize: isDesktop ? 14 : 16,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
