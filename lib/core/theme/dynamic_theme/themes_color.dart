import 'package:flutter/material.dart';

import 'colors_schema.dart';

class AppThemes {
  // singleton
  AppThemes._internal();
  static final AppThemes _instance = AppThemes._internal();
  factory AppThemes() => _instance;

  changeCustomScheme(String color, Brightness brightness) {
    final hexColors = int.parse(color, radix: 16);
    final Color colors = Color(hexColors);

    selectedSchema = const AppColorScheme().fromColor(colors, brightness);
  }

  changeBrightness(Brightness brightness) {
    selectedSchema = const AppColorScheme().fromColor(selectedSchema.primary, brightness);
  }

  AppColorScheme selectedSchema = const AppColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff4fca9a),
    onPrimary: Colors.white,
    secondary: Color(0xff428994),
    error: Color(0xffb00020),
    background: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    shadow: Color(0xff1f222a),
    outline: Color(0xffc5c6d0),
  );
}
