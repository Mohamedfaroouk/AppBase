import 'package:flutter/material.dart';

class AppColorScheme extends ColorScheme {
  Color get brightnessColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;
  Color get brightnessColorInverse =>
      brightness == Brightness.light ? Colors.white : Colors.black;

  AppColorScheme fromColor(Color color, Brightness brightness) {
    final scheme =
        ColorScheme.fromSeed(seedColor: color, brightness: brightness);
    return AppColorScheme(
      brightness: scheme.brightness,
      primary: color,
      onPrimary: scheme.onPrimary,
      primaryContainer: scheme.primaryContainer,
      onPrimaryContainer: scheme.onPrimaryContainer,
      secondary: scheme.secondary,
      onSecondary: scheme.onSecondary,
      secondaryContainer: scheme.secondaryContainer,
      onSecondaryContainer: scheme.onSecondaryContainer,
      tertiary: scheme.tertiary,
      onTertiary: scheme.onTertiary,
      tertiaryContainer: scheme.tertiaryContainer,
      onTertiaryContainer: scheme.onTertiaryContainer,
      error: scheme.error,
      onError: scheme.onError,
      errorContainer: scheme.errorContainer,
      onErrorContainer: scheme.onErrorContainer,
      background: scheme.background,
      onBackground: scheme.onBackground,
      surface: scheme.surface,
      onSurface: scheme.onSurface,
      surfaceVariant: scheme.surfaceVariant,
      onSurfaceVariant: scheme.onSurfaceVariant,
      outline: scheme.outline,
      shadow: scheme.shadow,
      inverseSurface: scheme.inverseSurface,
      onInverseSurface: scheme.onInverseSurface,
      inversePrimary: scheme.inversePrimary,
      surfaceTint: scheme.primary,
    );
  }

  const AppColorScheme({
    super.brightness = Brightness.dark,
    super.primary = Colors.white,
    super.onPrimary = Colors.white,
    super.primaryContainer,
    super.onPrimaryContainer,
    super.secondary = Colors.white,
    super.onSecondary = Colors.white,
    super.secondaryContainer,
    super.onSecondaryContainer,
    super.tertiary,
    super.onTertiary,
    super.tertiaryContainer,
    super.onTertiaryContainer,
    super.error = Colors.white,
    super.onError = Colors.white,
    super.errorContainer,
    super.onErrorContainer,
    super.background = Colors.white,
    super.onBackground = Colors.white,
    super.surface = Colors.white,
    super.onSurface = Colors.white,
    super.surfaceVariant,
    super.onSurfaceVariant,
    super.outline,
    super.shadow,
    super.inverseSurface,
    super.onInverseSurface,
    super.inversePrimary,
    super.surfaceTint,
  });

  // from color
}
