import 'package:flutter/widgets.dart';

/// Build the widget with the dimension from an aspect ratio
///
/// Is same [AspectRatio]
class AspectRatioBuilder extends StatelessWidget {
  /// [AspectRatio.aspectRatio]
  final double aspectRatio;

  /// Builder
  final Widget Function(BuildContext context, Size size) builder;

  const AspectRatioBuilder({
    Key key,
    @required this.aspectRatio,
    @required this.builder,
  })  : assert(aspectRatio != null),
        assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => builder(context, _calculateSize(constraints)),
    );
  }

  Size _calculateSize(BoxConstraints constraints) {
    if (constraints.isTight) return constraints.smallest;

    double width = constraints.maxWidth;
    double height;

    if (width.isFinite) {
      height = width / aspectRatio;
    } else {
      height = constraints.maxHeight;
      width = height * aspectRatio;
    }

    if (width > constraints.maxWidth) {
      width = constraints.maxWidth;
      height = width / aspectRatio;
    }

    if (height > constraints.maxHeight) {
      height = constraints.maxHeight;
      width = height * aspectRatio;
    }

    if (width < constraints.minWidth) {
      width = constraints.minWidth;
      height = width / aspectRatio;
    }

    if (height < constraints.minHeight) {
      height = constraints.minHeight;
      width = height * aspectRatio;
    }

    return constraints.constrain(Size(width, height));
  }
}
