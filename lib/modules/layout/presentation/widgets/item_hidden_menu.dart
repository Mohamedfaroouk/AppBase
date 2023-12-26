import 'package:flutter/material.dart';

import '../../../../shared/widgets/customtext.dart';

class ItemHiddenMenu extends StatelessWidget {
  /// name of the menu item
  final String? name;
  final String? lable;
  final Widget? icon;
  final VoidCallback? onTap;
  final Color? colorLineSelected;
  final Color arrowColor;
  final TextStyle? baseStyle;
  final TextStyle? selectedStyle;
  final bool? selected;
  // final AppFeatures? appFeatures;

  const ItemHiddenMenu({
    super.key,
    this.name,
    this.icon,
    this.lable,
    this.selected = false,
    this.onTap,
    this.colorLineSelected = Colors.blue,
    this.baseStyle,
    this.arrowColor = Colors.grey,
    this.selectedStyle,
    // this.appFeatures,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          child: InkWell(
            onTap: () {
              onTap!();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 10.0, top: 10.0, left: 24, right: 24),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 32, child: icon),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: CustomText(name ?? '',
                          style: (baseStyle ??
                              const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
        ),
        const Divider(
          height: 0,
        )
      ],
    );
  }
}
