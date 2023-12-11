import 'package:efatorh/core/utils/Utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../../core/theme/dynamic_theme/colors.dart';
import 'customtext.dart';
import 'divide_screen_ondesktop.dart';

class DefaultTextField extends StatefulWidget {
  const DefaultTextField({
    Key? key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.label,
    this.hintText,
    this.suffixIcon,
    this.border,
    this.showLabel = false,
    this.minlines,
    this.maxlines,
    this.onChange,
    this.validate,
    this.focusNode,
    this.inputFormatter = const [],
    this.contentPadding,
    this.readOnly = false,
    this.showRequiredStar = false,
    this.enable = true,
    this.fillable = true,
    this.autovalidateMode,
    this.prefixIcon,
    this.flex = 2,
    this.onTap,
    this.enabledBorder,
    this.style,
    this.autoFoces = false,
    this.padding,
    this.onSave,
    this.initValue,
    this.backgroundColor,
  }) : super(key: key);
  final bool enable;
  final bool readOnly;
  final bool autoFoces;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validate;
  final Function()? onTap;
  final FocusNode? focusNode;
  final List<TextInputFormatter> inputFormatter;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final int? minlines;
  final Widget? prefixIcon;
  final int? maxlines;
  final Color? backgroundColor;
  final AutovalidateMode? autovalidateMode;
  final int flex;
  final TextStyle? style;
  final bool showLabel;
  final bool showRequiredStar;
  final TextAlign textAlign = TextAlign.start;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final String? initValue;
  final bool fillable;
  final Function(String)? onChange;
  final void Function(String?)? onSave;
  @override
  _DefaultTextFieldState createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool? isPass;
  bool? visible;
  TextEditingController? controller;
  @override
  void initState() {
    controller =
        widget.controller ?? TextEditingController(text: widget.initValue);
    isPass =
        widget.keyboardType == TextInputType.visiblePassword ? true : false;
    visible = isPass;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final BorderRadius borderRadius = BorderRadius.circular(12.0);
  @override
  Widget build(BuildContext context) {
    return DivideScreenByFlexOnDesktop(
      flex: widget.flex,
      child: Padding(
          padding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showLabel)
                CustomText(
                  widget.label ?? "",
                  fontSize: 16,
                  weight: FontWeight.w600,
                ),
              if (widget.showLabel)
                const SizedBox(
                  height: 10,
                ),
              IgnorePointer(
                ignoring: widget.enable == true ? false : true,
                child: TextFormField(
                  magnifierConfiguration: const TextMagnifierConfiguration(
                      shouldDisplayHandlesInMagnifier: false),
                  // initialValue: widget.initValue,
                  onSaved: widget.onSave,
                  autovalidateMode: widget.autovalidateMode,
                  textAlign: widget.textAlign,
                  style: widget.style,
                  onChanged: (s) {
                    widget.onChange?.call(s);
                  },
                  autofocus: false,
                  focusNode: widget.focusNode,
                  controller: controller,
                  keyboardType: widget.keyboardType,
                  obscureText: visible!,
                  minLines: widget.minlines,
                  maxLines: widget.maxlines ?? 1,
                  onTap: () {
                    Utils.fixRtlLastChar(controller);
                    widget.onTap?.call();
                  },
                  validator: widget.validate,
                  inputFormatters: widget.inputFormatter,
                  readOnly: widget.readOnly,
                  decoration: InputDecoration(
                      filled: widget.fillable,
                      fillColor: AppColors.grey,
                      prefixIcon: widget.prefixIcon != null
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                widget.prefixIcon!,
                              ],
                            )
                          : null,
                      contentPadding: widget.contentPadding ??
                          const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                      // fillColor: whiteColor70,
                      hintText: widget.hintText,
                      labelText: widget.showLabel ? null : widget.label,
                      labelStyle: const TextStyle(color: Colors.black),
                      focusColor: AppColors.primary,
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 12),
                      suffixIcon: widget.suffixIcon ??
                          (isPass!
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      visible = !visible!;
                                    });
                                  },
                                  icon: Icon(
                                    visible!
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    //color: widget.suffixIconColor,
                                  ),
                                )
                              : widget.suffixIcon),
                      border: widget.border ??
                          OutlineInputBorder(
                            borderRadius: borderRadius,
                          ),
                      enabledBorder: widget.enabledBorder ??
                          OutlineInputBorder(
                              borderRadius: borderRadius,
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1)),
                      disabledBorder: widget.enabledBorder ??
                          OutlineInputBorder(
                              borderRadius: borderRadius,
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1))),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          )),
    );
  }
}
