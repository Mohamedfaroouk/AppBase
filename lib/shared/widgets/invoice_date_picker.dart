import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/theme/dynamic_theme/colors.dart';
import 'package:appbase/shared/widgets/customtext.dart';
import 'package:flutter/material.dart';

class InvoiceDatePicker extends StatelessWidget {
  InvoiceDatePicker({
    Key? key,
    required this.onChanged,
    this.label = "",
    required this.date1,
    this.validator,
    this.flex,
    this.isDesktop = false,
  }) : super(key: key);
  final Function(String?) onChanged;
  final TextEditingController date1;
  final String label;
  final String? Function(String?)? validator;
  DateTime? dateTime;
  final int? flex;
  final bool isDesktop;
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: validator,
        initialValue: "",
        builder: (state) {
          return InkWell(
            onTap: () async {
              dateTime = await showDatePicker(
                  locale: const Locale("ar"),
                  context: context,
                  builder: (context, child) {
                    return child!;
                  },
                  initialDate: DateTime.now(),
                  firstDate: DateTime.parse("2000-01-01"),
                  lastDate: DateTime.parse("2050-01-01"));

              if (dateTime != null) {
                date1.text = DateFormat("yyyy-MM-dd", "en").format(dateTime!);
                state.didChange(date1.text);

                onChanged(date1.text);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: CustomText(date1.text,
                          color: Colors.black, fontSize: isDesktop ? 12 : 15),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Icon(
                        Icons.calendar_today,
                        size: isDesktop ? 12 : 24,
                        color: AppColors.primary,
                      ),
                    )
                  ],
                ),
                if (state.hasError)
                  CustomText(
                    state.errorText ?? "",
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          );
        });
  }
}
