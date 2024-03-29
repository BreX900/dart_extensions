import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:provider/provider.dart';

extension BuildContextFlutterExtensions on BuildContext {
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

  Future<T?> showDialog<T>({
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    required WidgetBuilder builder,
  }) {
    return m.showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: builder,
    );
  }

  Future<T?> showGeneralDialog<T>({
    bool barrierDismissible = true,
    Color barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    required WidgetBuilder builder,
  }) {
    return m.showGeneralDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      pageBuilder: (context, _, __) => builder(context),
    );
  }
}
