import 'dart:math' as Math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:pure_extensions/src/color/HslColor.dart';
import 'package:tinycolor/conversion.dart';

extension ColorExt on Color {
  bool isDark() => this.getBrightness() < 128.0;

  bool isLight() => !this.isDark();

  double getBrightness() => (red * 299 + green * 587 + blue * 114) / 1000;

  double getLuminance() => computeLuminance();

  HSVColor toHsv() => colorToHsv(this);

  HslColor toHsl() {
    final hsl = rgbToHsl(
      r: red.toDouble(),
      g: green.toDouble(),
      b: blue.toDouble(),
    );
    return HslColor(h: hsl.h * 360, s: hsl.s, l: hsl.l, a: alpha.toDouble());
  }

  Color brighten([int amount = 10]) {
    return Color.fromARGB(
      alpha,
      Math.max(0, Math.min(255, red - (255 * -(amount / 100)).round())),
      Math.max(0, Math.min(255, green - (255 * -(amount / 100)).round())),
      Math.max(0, Math.min(255, blue - (255 * -(amount / 100)).round())),
    );
  }

  Color tint([int amount = 10]) => mix(input: Color.fromRGBO(255, 255, 255, 1.0));

  Color shade([int amount = 10]) => mix(input: Color.fromRGBO(0, 0, 0, 1.0));

  Color mix({@required Color input, int amount = 50}) {
    final int p = (amount / 100).round();
    return Color.fromARGB(
      (input.alpha - alpha) * p + alpha,
      (input.red - red) * p + red,
      (input.green - green) * p + green,
      (input.blue - blue) * p + blue,
    );
  }

  /// Required HSL
  @visibleForTesting
  Color lighten([int amount = 10]) => toHsl().lighten(amount).toColor();
  @visibleForTesting
  Color darken([int amount = 10]) => toHsl().darken(amount).toColor();
  @visibleForTesting
  Color desaturate([int amount = 10]) => toHsl().desaturate(amount).toColor();
  @visibleForTesting
  Color saturate([int amount = 10]) => toHsl().saturate(amount).toColor();
  @visibleForTesting
  Color greyscale() => desaturate(100);
  @visibleForTesting
  Color spin(double amount) => toHsl().spin(amount).toColor();
  @visibleForTesting
  Color complement() => toHsl().complement().toColor();
}
