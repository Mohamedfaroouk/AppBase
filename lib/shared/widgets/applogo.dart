import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.whiteFont = false});
  final bool whiteFont;
  @override
  Widget build(BuildContext context) {
    return const FlutterLogo(
      size: 100,
    );
  }
}
