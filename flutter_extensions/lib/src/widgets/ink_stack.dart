import 'package:flutter/material.dart';

/// Add [InkWell] on image
class InkStack extends StatelessWidget {
  /// [InkResponse.onTap]
  final GestureTapCallback onTap;

  /// [InkResponse.onDoubleTap]
  final GestureTapCallback onDoubleTap;

  /// [InkResponse.onLongPress]
  final GestureLongPressCallback onLongPress;

  /// They are the widgets background the ink well animation
  final List<Widget> background;

  /// They are the widgets foreground the ink well animation
  final List<Widget> foreground;

  const InkStack({
    Key key,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.background = const <Widget>[],
    this.foreground = const <Widget>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...background,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              onDoubleTap: onDoubleTap,
              onLongPress: onLongPress,
            ),
          ),
        ),
        ...foreground,
      ],
    );
  }
}
