import 'package:flutter/material.dart';

extension ColorSchemeExt on ColorScheme {
  ThemeData toTheme({
    TextTheme textTheme,
    ButtonThemeData buttonTheme,
    SnackBarThemeData snackBarTheme,
    VisualDensity visualDensity,
  }) {
    final bool isDark = brightness == Brightness.dark;

    // For surfaces that use primary color in light themes and surface color in dark
    final Color primarySurfaceColor = isDark ? surface : primary;
    final Color onPrimarySurfaceColor = isDark ? onSurface : onPrimary;

    return ThemeData(
      brightness: this.brightness,
      primaryColor: primarySurfaceColor,
      primaryColorBrightness:
          ThemeData.estimateBrightnessForColor(primarySurfaceColor),
      canvasColor: this.background,
      accentColor: this.secondary,
      accentColorBrightness:
          ThemeData.estimateBrightnessForColor(this.secondary),
      scaffoldBackgroundColor: this.background,
      bottomAppBarColor: this.surface,
      cardColor: this.surface,
      dividerColor: this.onSurface.withOpacity(0.12),
      backgroundColor: this.background,
      dialogBackgroundColor: this.background,
      errorColor: this.error,
      textTheme: textTheme,
      indicatorColor: onPrimarySurfaceColor,
      applyElevationOverlayColor: isDark,
      colorScheme: this,

      /// Extra
      buttonColor: secondary,
      buttonTheme: buttonTheme ?? SnackBarThemeData(),
      snackBarTheme: snackBarTheme,
      visualDensity: visualDensity,
    );
  }
}
