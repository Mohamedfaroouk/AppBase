import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/shared/widgets/customtext.dart';
import 'package:appbase/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'buttons.dart';

class ReturnInvoiceDialog extends StatefulWidget {
  const ReturnInvoiceDialog({super.key, required this.onTap});
  final Function(String) onTap;
  @override
  State<ReturnInvoiceDialog> createState() => _ReturnInvoiceDialogState();
}

class _ReturnInvoiceDialogState extends State<ReturnInvoiceDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            CustomText(
              "refund".tr(),
              weight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
            const Spacer(),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close))
          ],
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              DefaultTextField(
                flex: 1,
                controller: controller,
                label: "invoiceNumber".tr(),
                hintText: "invoiceNumber".tr(),
                keyboardType: TextInputType.number,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: DefaultButton(
                      text: "refund".tr(),
                      onTap: () {
                        if (controller.text.isNotEmpty) {
                          widget.onTap.call(controller.text);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
