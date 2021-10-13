import 'package:flutter/material.dart';

extension ElevatedButtonThemeDataFlutterExtension on ElevatedButtonThemeData {
  ElevatedButtonThemeData copyWith({ButtonStyle? style}) {
    return ElevatedButtonThemeData(style: style ?? this.style);
  }
}

extension TextButtonThemeDataFlutterExtension on TextButtonThemeData {
  ElevatedButtonThemeData copyWith({ButtonStyle? style}) {
    return ElevatedButtonThemeData(style: style ?? this.style);
  }
}

extension OutlinedButtonThemeDataFlutterExtension on OutlinedButtonThemeData {
  ElevatedButtonThemeData copyWith({ButtonStyle? style}) {
    return ElevatedButtonThemeData(style: style ?? this.style);
  }
}
