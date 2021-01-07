import 'package:flutter/widgets.dart';

extension SizeFlutterExtensions on Size {
  Size copyWith({double width, double height}) {
    return Size(width ?? this.width, height ?? this.height);
  }
}
