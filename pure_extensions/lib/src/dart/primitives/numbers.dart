import 'dart:math' as math;

import 'package:rational/rational.dart';

extension NumDartExtensions on num {
  Rational toRational() => Rational.parse(toString());

  num min(num other) => math.min<num>(this, other);
  num max(num other) => math.max<num>(this, other);
  num pow(num exponent) => math.pow(this, exponent);
  double sin() => math.sin(this);
  double cos() => math.cos(this);
  double tan() => math.tan(this);
  double acos() => math.acos(this);
  double asin() => math.asin(this);
  double atan() => math.atan(this);
  double sqrt() => math.sqrt(this);
  double exp() => math.exp(this);
  double log() => math.log(this);

  /// Convert degrees to radians
  num toRad() => this * (math.pi / 180.0);

  /// Convert radians to degrees
  num toDeg() => this * (180.0 / math.pi);
}

extension DoubleDartExtensions on double {
  Rational toRational() => Rational.parse(toString());

  double min(double other) => math.min<double>(this, other);
  double max(double other) => math.max<double>(this, other);

  /// Convert degrees to radians
  double toRad() => this * (math.pi / 180.0);

  /// Convert radians to degrees
  double toDeg() => this * (180.0 / math.pi);
}

extension IntDartExtensions on int {
  Rational toRational() => Rational.fromInt(this);

  int min(int other) => math.min<int>(this, other);
  int max(int other) => math.max<int>(this, other);
}
