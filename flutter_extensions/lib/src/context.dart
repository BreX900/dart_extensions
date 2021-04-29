import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension BuildContextDartExtensions on BuildContext {
  /// The [ThemeData] instance from the closest context.
  ThemeData theme() => Theme.of(this);

  /// The [DefaultTextStyle] instance from the closest context.
  DefaultTextStyle defaultTextStyle() => DefaultTextStyle.of(this);

  /// The [IconThemeData] instance from the closest context.
  IconThemeData iconTheme() => IconTheme.of(this);

  /// The [Localizations] instance from the closest context.
  T? localizations<T>() => Localizations.of<T>(this, T);

  /// The [Locale] instance from the closest context.
  Locale locale({bool nullOk = false}) => Localizations.localeOf(this);

  /// The [Navigator] instance from the closest context.
  NavigatorState navigator({bool rootNavigator = false, bool nullOk = false}) {
    return Navigator.of(this, rootNavigator: rootNavigator);
  }

  /// Returns the read value if it exists otherwise null.
  T? maybeRead<T>() {
    try {
      return read<T>();
    } on ProviderNotFoundException {
      return null;
    }
  }

  /// Returns the watch value if it exists otherwise null.
  T? maybeWatch<T>() {
    try {
      return watch<T>();
    } on ProviderNotFoundException {
      return null;
    }
  }
}

extension TargetPlatformDartExtensions on TargetPlatform {
  bool get isAndroid => this == TargetPlatform.android;
  bool get isFuchsia => this == TargetPlatform.fuchsia;
  bool get isIOS => this == TargetPlatform.iOS;
  bool get isLinux => this == TargetPlatform.linux;
  bool get isMacOS => this == TargetPlatform.macOS;
  bool get isWindows => this == TargetPlatform.windows;

  bool get isMobile {
    switch (this) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return true;
      default:
        return false;
    }
  }
}
