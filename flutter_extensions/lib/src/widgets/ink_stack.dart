import 'package:flutter/material.dart';

class InkStack extends StatelessWidget {
  final VoidCallback onTap;
  final List<Widget> background;
  final List<Widget> foreground;

  const InkStack({
    Key key,
    this.onTap,
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
            ),
          ),
        ),
        ...foreground,
      ],
    );
  }
}
