import 'package:flutter/material.dart';
import 'package:appbase/core/utils/extentions.dart';

enum TextStyleEnum {
  normal,
  title,
  caption,
}

class CustomText extends StatelessWidget {
  TextStyle getTextStyle(BuildContext context, TextStyleEnum textStyleEnum,
      {Color? color,
      double? fontsize,
      String? fontFamily,
      TextOverflow? overflow,
      TextDecoration? decoration,
      FontWeight? weight}) {
    switch (textStyleEnum) {
      case TextStyleEnum.normal:
        return context.textTheme.titleMedium?.copyWith(
                decoration: decoration,
                color: color,
                fontWeight: weight,
                fontSize: fontsize,
                overflow: overflow ?? TextOverflow.visible,
                fontFamily: fontFamily) ??
            const TextStyle();
      case TextStyleEnum.caption:
        return context.textTheme.bodyMedium?.copyWith(
                decoration: decoration,
                color: color,
                fontWeight: weight,
                fontSize: fontsize,
                overflow: overflow ?? TextOverflow.visible,
                fontFamily: fontFamily) ??
            const TextStyle();
      case TextStyleEnum.title:
        return context.textTheme.headlineSmall?.copyWith(
                decoration: decoration,
                color: color,
                fontWeight: weight,
                fontSize: fontsize,
                overflow: overflow ?? TextOverflow.visible,
                fontFamily: fontFamily) ??
            const TextStyle();

      default:
        return context.textTheme.bodyMedium?.copyWith(
                decoration: decoration,
                color: color,
                fontWeight: weight,
                fontSize: fontsize,
                overflow: overflow ?? TextOverflow.visible,
                fontFamily: fontFamily) ??
            const TextStyle();
    }
  }

  const CustomText(
    this.text, {
    Key? key,
    this.textStyleEnum,
    this.color,
    this.fontSize,
    this.weight,
    this.fontFamily,
    this.align,
    this.style,
    this.decoration,
    this.overflow,
    this.maxLine,
  }) : super(key: key);
  final String text;
  final TextStyleEnum? textStyleEnum;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final TextAlign? align;
  final FontWeight? weight;
  final TextStyle? style;
  final int? maxLine;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1,
      textAlign: align ?? TextAlign.start,
      maxLines: maxLine,
      style: style ??
          getTextStyle(context, textStyleEnum ?? TextStyleEnum.normal,
              color: color,
              fontsize: fontSize,
              fontFamily: fontFamily,
              overflow: overflow,
              decoration: decoration,
              weight: weight),
    );
  }
}
