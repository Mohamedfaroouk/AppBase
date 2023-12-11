import 'package:flutter/material.dart';

import 'themes_color.dart';

enum AppThemeMode { primary, primaryDark, pink, blue, custom }

class AppColors {
  static AppThemes selectedTheme = AppThemes();
  static Color get primary => selectedTheme.selectedSchema.primary;

  static Color get secondary => selectedTheme.selectedSchema.secondary;
  static Color get secondaryContainer => selectedTheme.selectedSchema.secondaryContainer;

  static Color get error => selectedTheme.selectedSchema.error;

  static Color get background => selectedTheme.selectedSchema.background;
  static Color get surface => selectedTheme.selectedSchema.surface;

  static Color get shadow => selectedTheme.selectedSchema.shadow;
  static Color get outline => selectedTheme.selectedSchema.outline;

  static Color get brightnessColor => selectedTheme.selectedSchema.brightnessColor;
  static Color get brightnessColorInv => selectedTheme.selectedSchema.brightnessColorInverse;
  static Brightness get brightness => selectedTheme.selectedSchema.brightness;
  static Color get grey => const Color(0xffF5F5F5);
  static Color get green => const Color(0xff62C83F);
}
