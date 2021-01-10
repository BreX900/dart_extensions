import 'package:flutter/widgets.dart';

extension SizeFlutterExtensions on Size {
  /// Copy with new values.
  Size copyWith({double width, double height}) {
    return Size(width ?? this.width, height ?? this.height);
  }
}
