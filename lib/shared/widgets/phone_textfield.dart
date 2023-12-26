import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';

import '../../core/theme/dynamic_theme/colors.dart';
import 'customtext.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({
    super.key,
    this.phoneController,
    required this.numberChange,
    this.initCode,
    required this.codeChange,
    required this.validate,
    this.initPhone,
  });
  final TextEditingController? phoneController;
  final String? initCode;
  final String? initPhone;
  final Function(String) numberChange;
  final Function(String) codeChange;
  final String? Function(String?) validate;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  String code = '966';
  late TextEditingController controller;
  @override
  void initState() {
    controller = widget.phoneController ??
        TextEditingController(text: widget.initPhone ?? "");
    code = widget.initCode ?? code;
    log(widget.initCode.toString(), name: "code");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PhoneNumberField oldWidget) {
    if (oldWidget.initCode != widget.initCode) {
      code = widget.initCode ?? code;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 16),
        SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "countryCode".tr(),
                fontSize: 16,
                weight: FontWeight.w600,
              ),
              const SizedBox(height: 10),
              CountryCodePicker(
                boxDecoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                builder: (p0) => Container(
                  clipBehavior: Clip.hardEdge,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: Colors.black38),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(p0!.dialCode.toString(),
                          fontSize: 15, color: AppColors.brightnessColor),
                      // const SizedBox(
                      //   width: 5,
                      // ),
                      // Image.asset(
                      //   p0.flagUri!,
                      //   package: 'country_code_picker',
                      //   width: 20,
                      // ),
                    ],
                  ),
                ),
                initialSelection: "+$code",
                dialogSize: const Size(400, 500),
                countryFilter: const <String>['SA', "EG"],
                onChanged: (s) {
                  code = s.dialCode!.replaceAll("+", "");
                  widget.codeChange(code);
                  widget.numberChange(controller.text);
                },
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: DefaultTextField(
            flex: 1,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            label: "phone".tr(),
            showLabel: true,
            showRequiredStar: true,
            controller: controller,
            onChange: (s) {
              widget.codeChange(code);
              widget.numberChange(controller.text);
            },
            validate: widget.validate,
          ),
        ),
      ],
    );
  }
}
