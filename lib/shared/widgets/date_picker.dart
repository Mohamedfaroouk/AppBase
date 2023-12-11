import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/theme/dynamic_theme/colors.dart';

class CustomDateTimePicker extends StatefulWidget {
  const CustomDateTimePicker({
    Key? key,
    required this.onChanged,
    this.validator,
    this.flex,
    required this.label,
    this.initValue,
  }) : super(key: key);
  final Function(String?) onChanged;
  final String label;
  final String? Function(String?)? validator;
  final int? flex;
  final String? initValue;

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  final TextEditingController date1 = TextEditingController();
  @override
  void initState() {
    date1.text = widget.initValue ?? "";
    super.initState();
  }

  @override
  void dispose() {
    date1.dispose();

    super.dispose();
  }

  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        dateTime = await showDatePicker(
            context: context,
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primary,
                    onPrimary: Colors.white,
                    surface: Colors.blue,
                    onSurface: Colors.black,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child!,
              );
            },
            initialDate:
                DateTime.now().subtract(const Duration(days: 365 * 18)),
            firstDate: DateTime.parse("1920-01-01"),
            lastDate: DateTime.now().subtract(const Duration(days: 365 * 16)));

        if (dateTime != null) {
          date1.text = DateFormat("yyyy-MM-dd", "en").format(dateTime!);

          widget.onChanged(dateTime.toString().split(" ").first);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: TextFormField(
          controller: date1,
          validator: widget.validator,
          readOnly: true,
          enabled: false,
          decoration: InputDecoration(
            labelText: widget.label,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
