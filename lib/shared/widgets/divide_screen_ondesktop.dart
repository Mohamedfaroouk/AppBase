import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class DivideScreenByFlexOnDesktop extends StatelessWidget {
  const DivideScreenByFlexOnDesktop(
      {super.key, this.flex = 1, required this.child});
  final int flex;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      context;
      return SizedBox(
          width: ResponsiveBreakpoints.of(context).isMobile
              ? constrains.maxWidth
              : (constrains.maxWidth / flex),
          child: child);
    });
  }
}
