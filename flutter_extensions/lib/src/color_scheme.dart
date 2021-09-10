import 'package:flutter/material.dart';

extension ColorSchemeExt on ColorScheme {
  ThemeData toTheme({
    TextTheme? textTheme,
    ButtonThemeData? buttonTheme,
    SnackBarThemeData? snackBarTheme,
    VisualDensity? visualDensity,
  }) {
    final bool isDark = brightness == Brightness.dark;

    // For surfaces that use primary color in light themes and surface color in dark
    final Color primarySurfaceColor = isDark ? surface : primary;
    final Color onPrimarySurfaceColor = isDark ? onSurface : onPrimary;

    return ThemeData(
      brightness: brightness,
      primaryColor: primarySurfaceColor,
      primaryColorBrightness: ThemeData.estimateBrightnessForColor(primarySurfaceColor),
      canvasColor: background,
      scaffoldBackgroundColor: background,
      bottomAppBarColor: surface,
      cardColor: surface,
      dividerColor: onSurface.withOpacity(0.12),
      backgroundColor: background,
      dialogBackgroundColor: background,
      errorColor: error,
      textTheme: textTheme,
      indicatorColor: onPrimarySurfaceColor,
      applyElevationOverlayColor: isDark,
      colorScheme: this,

      /// Extra
      buttonTheme: buttonTheme ?? const SnackBarThemeData() as ButtonThemeData?,
      snackBarTheme: snackBarTheme,
      visualDensity: visualDensity,
    );
  }
}
