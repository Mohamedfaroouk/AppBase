import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/theme/dynamic_theme/colors.dart';
import 'package:appbase/shared/widgets/customtext.dart';
import 'package:flutter/material.dart';

enum InvoiceType { simpleTaxed, taxed }

class InvoiceTypeSelect extends StatefulWidget {
  const InvoiceTypeSelect(
      {super.key, required this.onSelect, this.invoiceType});
  final ValueChanged<InvoiceType> onSelect;
  final InvoiceType? invoiceType;
  @override
  State<InvoiceTypeSelect> createState() => _InvoiceTypeSelectState();
}

class _InvoiceTypeSelectState extends State<InvoiceTypeSelect> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Wrap(
              spacing: 20,
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    widget.onSelect.call(InvoiceType.taxed);

                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.invoiceType == InvoiceType.taxed
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 5),
                        CustomText(
                          "taxedInvoice".tr(),
                          align: TextAlign.start,
                          weight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.onSelect.call(InvoiceType.simpleTaxed);

                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.invoiceType == InvoiceType.simpleTaxed
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 5),
                        CustomText(
                          "simpleTaxedInvoice".tr(),
                          align: TextAlign.start,
                          weight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
