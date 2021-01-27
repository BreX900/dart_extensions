import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ButtonStyleBuilder {
  /// [ButtonStyle.textStyle]
  final TextStyle textStyle;

  /// [ButtonStyle.backgroundColor]
  final Color backgroundColor;

  /// [ButtonStyle.foregroundColor]
  final Color foregroundColor;

  /// [ButtonStyle.overlayColor]
  final Color overlayColor;

  /// [ButtonStyle.shadowColor]
  final Color shadowColor;

  /// [ButtonStyle.elevation]
  final double elevation;

  /// [ButtonStyle.padding]
  final EdgeInsetsGeometry padding;

  /// [ButtonStyle.minimumSize]
  final Size minimumSize;

  /// [ButtonStyle.side]
  final BorderSide side;

  /// [ButtonStyle.shape]
  final OutlinedBorder shape;

  /// [ButtonStyle.mouseCursor]
  final MouseCursor mouseCursor;

  /// [ButtonStyle.visualDensity]
  final VisualDensity visualDensity;

  /// [ButtonStyle.tapTargetSize]
  final MaterialTapTargetSize tapTargetSize;

  /// [ButtonStyle.animationDuration]
  final Duration animationDuration;

  /// [ButtonStyle.enableFeedback]
  final bool enableFeedback;

  const ButtonStyleBuilder({
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.overlayColor,
    this.shadowColor,
    this.elevation,
    this.padding,
    this.minimumSize,
    this.side,
    this.shape,
    this.mouseCursor,
    this.visualDensity,
    this.tapTargetSize,
    this.animationDuration,
    this.enableFeedback,
  });

  ButtonStyleBuilder copyWith({
    TextStyle textStyle,
    Color backgroundColor,
    Color foregroundColor,
    Color overlayColor,
    Color shadowColor,
    double elevation,
    EdgeInsetsGeometry padding,
    Size minimumSize,
    BorderSide side,
    OutlinedBorder shape,
    MouseCursor mouseCursor,
    VisualDensity visualDensity,
    MaterialTapTargetSize tapTargetSize,
    Duration animationDuration,
    bool enableFeedback,
  }) {
    return new ButtonStyleBuilder(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      overlayColor: overlayColor ?? this.overlayColor,
      shadowColor: shadowColor ?? this.shadowColor,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      minimumSize: minimumSize ?? this.minimumSize,
      side: side ?? this.side,
      shape: shape ?? this.shape,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      visualDensity: visualDensity ?? this.visualDensity,
      tapTargetSize: tapTargetSize ?? this.tapTargetSize,
      animationDuration: animationDuration ?? this.animationDuration,
      enableFeedback: enableFeedback ?? this.enableFeedback,
    );
  }

  ButtonStyle build() {
    return ButtonStyle(
      textStyle: MaterialStateProperty.all(textStyle),
      backgroundColor: MaterialStateProperty.all(backgroundColor),
      foregroundColor: MaterialStateProperty.all(foregroundColor),
      overlayColor: MaterialStateProperty.all(overlayColor),
      shadowColor: MaterialStateProperty.all(shadowColor),
      elevation: MaterialStateProperty.all(elevation),
      padding: MaterialStateProperty.all(padding),
      minimumSize: MaterialStateProperty.all(minimumSize),
      side: MaterialStateProperty.all(side),
      shape: MaterialStateProperty.all(shape),
      mouseCursor: MaterialStateProperty.all(mouseCursor),
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
    );
  }
}

extension ElevatedButtonThemeDataFlutterExtension on ElevatedButtonThemeData {
  ElevatedButtonThemeData copyWith({ButtonStyle style}) {
    return ElevatedButtonThemeData(style: style ?? this.style);
  }
}

extension TextButtonThemeDataFlutterExtension on TextButtonThemeData {
  ElevatedButtonThemeData copyWith({ButtonStyle style}) {
    return ElevatedButtonThemeData(style: style ?? this.style);
  }
}

extension OutlinedButtonThemeDataFlutterExtension on OutlinedButtonThemeData {
  ElevatedButtonThemeData copyWith({ButtonStyle style}) {
    return ElevatedButtonThemeData(style: style ?? this.style);
  }
}
