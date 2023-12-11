import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.whiteFont = false});
  final bool whiteFont;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/${whiteFont ? "logo_font_wight" : "logo_new_black"}.png",
      width: 110,
      height: 110,
    );
  }
}
