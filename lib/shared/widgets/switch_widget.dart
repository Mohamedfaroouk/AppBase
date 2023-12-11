import 'package:efatorh/core/theme/dynamic_theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customtext.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    Key? key,
    required this.value,
    required this.onChange,
    required this.title,
    this.tooltip,
  }) : super(key: key);
  final Function(bool) onChange;
  final bool value;
  final String title;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomText(
            title,
            color: Colors.black,
            fontSize: 18,
          ),
          if (tooltip != null)
            const SizedBox(
              width: 5,
            ),
          if (tooltip != null)
            Tooltip(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(10),
              textStyle: const TextStyle(color: Colors.white, fontSize: 16),
              triggerMode: TooltipTriggerMode.tap,
              message: tooltip,
              child: Icon(Icons.info, color: AppColors.primary),
            ),
          const Spacer(),
          CupertinoSwitch(
              value: value,
              onChanged: (s) {
                onChange.call(s);
              }),
        ],
      ),
    );
  }
}
