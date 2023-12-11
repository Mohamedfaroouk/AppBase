import 'package:flutter/material.dart';

import 'dynamic_theme/colors.dart';
import 'dynamic_theme/themes_color.dart';
import 'package:material_color_gen/material_color_gen.dart';

class ThemesManger {
  static ThemeData get appTheme {
    return ThemeData(
        fontFamily: 'Cairo',
        applyElevationOverlayColor: false,
        primarySwatch: AppThemes().selectedSchema.primary.toMaterialColor(),
        scaffoldBackgroundColor: AppColors.background,
        datePickerTheme: DatePickerThemeData(
            backgroundColor: Colors.white,
            headerForegroundColor: Colors.white,
            dayForegroundColor: MaterialStateProperty.all(Colors.black),
            yearForegroundColor: MaterialStateProperty.all(Colors.black),
            rangePickerHeaderHeadlineStyle: const TextStyle(fontSize: 18),
            rangePickerHeaderForegroundColor: Colors.white),
        appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.background,
            elevation: 0,
            foregroundColor: Colors.black,
            centerTitle: true,
            iconTheme: IconThemeData(color: AppColors.primary)),
        colorScheme: AppThemes().selectedSchema,
        cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )));
  }
}
