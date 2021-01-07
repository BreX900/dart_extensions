import 'dart:math' as math;

import 'package:rational/rational.dart';

extension NumDartExtensions on num {
  Rational toRational() => Rational.parse(toString());

  num min(num other) => math.min<num>(this, other);
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
}

extension doubleDartExtensions on double {
  Rational toRational() => Rational.parse(toString());

  double min(double other) => math.min<double>(this, other);
  double max(double other) => math.max<double>(this, other);
}

extension intDartExtensions on int {
  Rational toRational() => Rational.fromInt(this);

  int min(int other) => math.min<int>(this, other);
  int max(int other) => math.max<int>(this, other);
}
