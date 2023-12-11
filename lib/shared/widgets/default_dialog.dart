import 'package:efatorh/shared/widgets/customtext.dart';
import 'package:flutter/material.dart';

import 'applogo.dart';

class DefaultDialog extends StatelessWidget {
  const DefaultDialog({super.key, this.info, this.footer});

  final String? info;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(),
            const SizedBox(
              height: 20,
            ),
            CustomText(
              info ?? "",
              align: TextAlign.center,
              weight: FontWeight.w500,
              fontSize: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            footer ?? const SizedBox(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
