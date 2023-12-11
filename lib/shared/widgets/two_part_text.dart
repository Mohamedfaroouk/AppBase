import 'package:flutter/material.dart';

import 'customtext.dart';

class TwoPartsText extends StatelessWidget {
  const TwoPartsText({
    Key? key,
    required this.title,
    required this.value,
    this.color = const Color(0xff707070),
    this.titleStyle,
    this.maxLines = 2,
    this.valueStyle,
    this.valueWidget,
  }) : super(key: key);

  final String title;
  final String value;
  final Color color;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final Widget? valueWidget;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          "$title : ",
          style: titleStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        Flexible(
          child: valueWidget ??
              CustomText(
                value,
                maxLine: maxLines,
                overflow: TextOverflow.ellipsis,
                style: valueStyle ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
        ),
      ],
    );
  }
}

class TwoFieldsLabel extends StatelessWidget {
  const TwoFieldsLabel({
    Key? key,
    required this.title,
    required this.value,
    this.color = const Color(0xff707070),
    this.titleStyle,
    this.maxLines = 2,
    this.valueStyle,
    this.valueWidget,
  }) : super(key: key);

  final String title;
  final String value;
  final Color color;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final Widget? valueWidget;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          "$title : ",
          style: titleStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const Spacer(),
        valueWidget ??
            CustomText(
              value,
              maxLine: maxLines,
              overflow: TextOverflow.ellipsis,
              style: valueStyle ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
      ],
    );
  }
}
