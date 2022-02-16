import 'package:flutter/widgets.dart';

extension AppLifecycleStateFlutterExtensions on AppLifecycleState {
  /// [AppLifecycleState.resumed]
  bool get isResumed => this == AppLifecycleState.resumed;

  /// [AppLifecycleState.inactive]
  bool get isInactive => this == AppLifecycleState.inactive;

  /// [AppLifecycleState.paused]
  bool get isPaused => this == AppLifecycleState.paused;

  /// [AppLifecycleState.detached]
  bool get isDetached => this == AppLifecycleState.detached;
}
