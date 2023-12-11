import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/core/theme/dynamic_theme/colors.dart';
import 'package:efatorh/shared/widgets/customtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/Utils.dart';

class QuantityDialog extends StatefulWidget {
  const QuantityDialog({super.key, this.qty = 1});
  final int qty;
  @override
  State<QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  TextEditingController controller = TextEditingController(text: "1");
  // timer
  Timer? timer;
  bool isDone = false;
  @override
  void initState() {
    controller.text = widget.qty.toString();
    // close after 5 s
    timer = Timer(const Duration(seconds: 3), () {
      if (isDone) return;
      Navigator.pop(context, int.parse(controller.text));
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 250,
        width: 120,
        child: Padding(
          padding: const EdgeInsets.all(29.0),
          child: Column(
            children: [
              CustomText(
                "qty".tr(),
                weight: FontWeight.bold,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if (controller.text == "1") return;
                        controller.text = (int.parse(controller.text) - 1).toString();
                        //close timer
                        timer?.cancel();
                      },
                      icon: const Icon(Icons.remove_circle_outline)),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                      controller: controller,
                      keyboardType: TextInputType.number,
                      onChanged: (s) {
                        //close timer
                        timer?.cancel();
                      },
                      inputFormatters: [FilteringTextInputFormatter.allow(Utils.doubleNumRegEx)],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.text = (int.parse(controller.text) + 1).toString();
                        //close timer
                        timer?.cancel();
                      },
                      icon: const Icon(Icons.add_circle_outline)),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: CustomText("cancel".tr(), weight: FontWeight.bold, color: AppColors.primary, fontSize: 16)),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          isDone = true;
                          Navigator.pop(context, double.parse(controller.text));
                        },
                        child: CustomText("done".tr(), weight: FontWeight.bold, color: AppColors.primary, fontSize: 16)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
