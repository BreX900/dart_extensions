import 'package:flutter/material.dart';

extension ElevatedButtonThemeDataFlutterExtensions on ElevatedButtonThemeData {
  ElevatedButtonThemeData copyWith({ButtonStyle? style}) {
    return ElevatedButtonThemeData(style: style ?? this.style);
  }
}

extension TextButtonThemeDataFlutterExtensions on TextButtonThemeData {
  ElevatedButtonThemeData copyWith({ButtonStyle? style}) {
    return ElevatedButtonThemeData(style: style ?? this.style);
  }
}

extension OutlinedButtonThemeDataFlutterExtensions on OutlinedButtonThemeData {
  ElevatedButtonThemeData copyWith({ButtonStyle? style}) {
    return ElevatedButtonThemeData(style: style ?? this.style);
  }
}
