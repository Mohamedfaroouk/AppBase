import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppResponsiveWrapper extends StatelessWidget {
  const AppResponsiveWrapper({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
        //maxWidth: 1200,

        breakpoints: [
          const Breakpoint(start: 0, end: 600, name: MOBILE),
          const Breakpoint(start: 601, end: 1200, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: Builder(builder: (context) {
          return ResponsiveScaledBox(
              width: ResponsiveValue<double>(context, conditionalValues: [
                Condition.equals(name: MOBILE, value: 510),
                Condition.equals(name: TABLET, value: 1200),
                Condition.equals(name: DESKTOP, value: 1900),
                Condition.equals(name: "4k", value: 2300),
                // There are no conditions for width over 1200
                // because the `maxWidth` is set to 1200 via the MaxWidthBox.
              ]).value,
              child: child!);
        }));
  }
}
