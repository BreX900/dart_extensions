import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension BuildContextDartExtensions on BuildContext {
  ThemeData theme({bool shadowThemeOnly = false}) =>
      Theme.of(this, shadowThemeOnly: shadowThemeOnly);

  DefaultTextStyle defaultTextStyle() => DefaultTextStyle.of(this);

  IconThemeData iconTheme() => IconTheme.of(this);

  /// Localizations

  T localizations<T>() => Localizations.of<T>(this, T);

  Locale locale({bool nullOk = false}) => Localizations.localeOf(this, nullOk: nullOk);

  NavigatorState navigator({bool rootNavigator = false, bool nullOk = false}) {
    return Navigator.of(this, rootNavigator: rootNavigator, nullOk: nullOk);
  }

  T tryRead<T>() {
    try {
      return read<T>();
    } on ProviderNotFoundException {
      return null;
    }
  }

  T tryWatch<T>() {
    try {
      return watch<T>();
    } on ProviderNotFoundException {
      return null;
    }
  }
}

extension TargetPlatformDartExtensions on TargetPlatform {
  bool get isMobile => this == TargetPlatform.android || this == TargetPlatform.iOS;
  bool get isDesktop => this == TargetPlatform.fuchsia;
}
