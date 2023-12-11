import 'package:flutter/material.dart';

import '../../core/theme/dynamic_theme/colors.dart';
import 'customtext.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      this.color,
      this.shape,
      required this.text,
      this.onTap,
      this.padding,
      this.icon,
      this.fontColor,
      this.fontSize = 20})
      : super(key: key);
  final Color? color;
  final Color? fontColor;
  final OutlinedBorder? shape;
  final String text;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final Widget? icon;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 48,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: shape ??
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                backgroundColor: color ?? AppColors.primary,
                foregroundColor: fontColor ?? Colors.white),
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (icon != null) icon!,
                const SizedBox(
                  width: 5,
                ),
                CustomText(
                  text,
                  textStyleEnum: TextStyleEnum.caption,
                  weight: FontWeight.bold,
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ],
            )),
      ),
    );
  }
}

class DefaultButtonOutLined extends StatelessWidget {
  const DefaultButtonOutLined(
      {Key? key,
      this.color,
      this.shape,
      required this.text,
      this.onTap,
      this.style,
      this.padding,
      this.icon,
      this.fontColor})
      : super(key: key);
  final Color? color;
  final Color? fontColor;

  final OutlinedBorder? shape;
  final String text;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final TextStyle? style;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: 48,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: shape ??
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
              foregroundColor: fontColor ?? Colors.white,
              side: BorderSide(color: color ?? AppColors.primary),
            ),
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: color,
                    size: 30,
                  ),
                const SizedBox(
                  width: 5,
                ),
                CustomText(
                  text,
                  style: style,
                  weight: FontWeight.bold,
                  color: color ?? AppColors.primary,
                  fontSize: 20,
                ),
              ],
            )),
      ),
    );
  }
}

class ButtonIcon extends StatelessWidget {
  const ButtonIcon({
    Key? key,
    this.color,
    this.iconColor,
    this.onTap,
    required this.icon,
    this.iconImage,
  }) : super(key: key);
  final Color? color;
  final Color? iconColor;
  final VoidCallback? onTap;
  final IconData icon;
  final String? iconImage;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      color: color ?? AppColors.primary,
      child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: iconImage != null
                ? ImageIcon(
                    AssetImage(iconImage ?? ""),
                    size: 50,
                    color: iconColor ?? Colors.white,
                  )
                : Icon(
                    icon,
                    size: 50,
                    color: iconColor ?? Colors.white,
                  ),
          )),
    );
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.background,
  });
  final String title;
  final VoidCallback? onTap;
  final Color background;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: background,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            minimumSize: const Size(40, 30)),
        onPressed: onTap,
        child: CustomText(
          title,
          fontSize: 16,
          color: Colors.white,
          weight: FontWeight.bold,
        ));
  }
}
