import 'package:easy_localization/easy_localization.dart';
import 'package:appbase/core/theme/dynamic_theme/colors.dart';
import 'package:appbase/shared/widgets/textfield.dart';
import 'package:flutter/material.dart';

import 'customtext.dart';

class CustomDateTimeRangePicker extends StatefulWidget {
  const CustomDateTimeRangePicker(
      {Key? key,
      required this.onChanged,
      this.firstlable = "from",
      this.secondlable = 'to',
      this.date1,
      this.date2,
      this.validator,
      this.showLabel = false})
      : super(key: key);
  final Function(DateTimeRange?) onChanged;
  final String firstlable;
  final String secondlable;
  final TextEditingController? date1;
  final TextEditingController? date2;
  final String? Function(String?)? validator;
  final bool showLabel;

  @override
  State<CustomDateTimeRangePicker> createState() =>
      _CustomDateTimeRangePickerState();
}

class _CustomDateTimeRangePickerState extends State<CustomDateTimeRangePicker> {
  late TextEditingController date1;
  late TextEditingController date2;

  DateTimeRange? dateTime;
  @override
  void initState() {
    date1 = widget.date1 ?? TextEditingController();
    date2 = widget.date2 ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: widget.validator,
        // initialValue: date1.text,
        builder: (state) {
          return InkWell(
            splashColor: Colors.transparent,
            onTap: () async {
              dateTime = await showDateRangePicker(
                  context: context,
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                          appBarTheme:
                              AppBarTheme(backgroundColor: AppColors.primary)),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Card(
                            color: Colors.transparent,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                            child: child!),
                      ),
                    );
                  },
                  firstDate: DateTime.parse("2000-01-01"),
                  lastDate: DateTime.parse("2050-01-01"));

              if (dateTime != null) {
                date1.text = DateFormat("dd/MM/yyyy").format(dateTime!.start);
                date2.text = DateFormat("dd/MM/yyyy").format(dateTime!.end);
                state.didChange(date1.text);

                widget.onChanged(dateTime);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.showLabel)
                  const SizedBox(
                    height: 10,
                  ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: DefaultTextField(
                        padding: EdgeInsets.zero,
                        label: widget.firstlable.tr(),
                        controller: date1,
                        readOnly: true,
                        enable: false,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: DefaultTextField(
                        padding: EdgeInsets.zero,
                        label: widget.secondlable.tr(),
                        controller: date2,
                        readOnly: true,
                        enable: false,
                      ),
                    ),
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
