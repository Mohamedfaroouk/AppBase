import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/core/theme/dynamic_theme/colors.dart';
import 'package:flutter/material.dart';

class ToggleWidget extends StatefulWidget {
  const ToggleWidget(
      {super.key,
      required this.onChange,
      this.selectedType,
      required this.firstTitle,
      required this.secondTitle,
      this.selectedColor,
      this.width = 300});
  final Function(bool)? onChange;
  final bool? selectedType;
  final String firstTitle;
  final String secondTitle;
  final Color? selectedColor;
  final double width;

  @override
  State<ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget> {
  Color selectedColor = AppColors.primary;

  @override
  void didUpdateWidget(covariant ToggleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  bool isSelectFirstType = true;
  @override
  void initState() {
    selectedColor = widget.selectedColor ?? AppColors.primary;
    isSelectFirstType = widget.selectedType ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: widget.width,
          height: 50,
          child: Card(
            elevation: 0,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: AppColors.primary, width: 1),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  height: 50,
                  right: context.locale.languageCode == "ar"
                      ? isSelectFirstType
                          ? 0
                          : widget.width / 2
                      : null,
                  left: context.locale.languageCode == "ar"
                      ? null
                      : isSelectFirstType
                          ? 0
                          : widget.width / 2,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: widget.width / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: selectedColor,
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                isSelectFirstType = true;
                                widget.onChange?.call(isSelectFirstType);

                                setState(() {});
                              },
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: Center(
                                  key: UniqueKey(),
                                  child: Text(
                                    widget.firstTitle,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isSelectFirstType == true ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ))),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                isSelectFirstType = false;
                                widget.onChange?.call(isSelectFirstType);

                                setState(() {});
                              },
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: Center(
                                  key: UniqueKey(),
                                  child: Text(
                                    widget.secondTitle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: isSelectFirstType == false ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              ))),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
