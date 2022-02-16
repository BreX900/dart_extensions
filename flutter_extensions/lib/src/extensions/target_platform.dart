import 'package:flutter/widgets.dart';

extension TargetPlatformFlutterExtensions on TargetPlatform {
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

  bool get isDesktop {
    switch (this) {
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
        return true;
      default:
        return false;
    }
  }
}
