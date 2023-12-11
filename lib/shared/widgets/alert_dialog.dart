import 'package:flutter/material.dart';

import '../../core/theme/dynamic_theme/colors.dart';
import 'customtext.dart';

AlertDialog alertDialog(
    Color? backgroundColor,
    AlignmentGeometry? alignment,
    Widget? icon,
    String title,
    Function action1,
    String action1title,
    Function action2,
    String action2title) {
  return AlertDialog(
    actionsAlignment: MainAxisAlignment.center,
    backgroundColor: backgroundColor,
    alignment: alignment,
    title: icon ??
        Icon(
          Icons.delete,
          size: 40,
          color: AppColors.primary,
        ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          title,
          textStyleEnum: TextStyleEnum.title,
          color: AppColors.brightnessColor,
        ),
      ],
    ),
    actions: [
      Card(
          clipBehavior: Clip.hardEdge,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: InkWell(
            onTap: () => action1.call(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              child: CustomText(
                action1title,
                textStyleEnum: TextStyleEnum.normal,
                color: AppColors.brightnessColor,
              ),
            ),
          )),
      Card(
          clipBehavior: Clip.hardEdge,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: InkWell(
            onTap: () {
              action2.call();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              child: CustomText(
                action2title,
                textStyleEnum: TextStyleEnum.normal,
                color: AppColors.brightnessColor,
              ),
            ),
          ))
    ],
  );
}
