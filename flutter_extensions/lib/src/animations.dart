import 'dart:ui';

import 'package:flutter/widgets.dart';

class PaddingTransition extends AnimatedWidget {
  const PaddingTransition({
    Key? key,
    required this.padding,
    required this.child,
  }) : super(key: key, listenable: padding);

  /// Animation of the padding to paint.
  final Animation<EdgeInsetsGeometry> padding;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding.value,
      child: child,
    );
  }
}

class DoubleTween extends Tween<double> {
  DoubleTween({double? begin, double? end}) : super(begin: begin, end: end);
}

class TransformTween<T> extends Animatable<T> {
  final T Function(double value) transformer;

  TransformTween({required this.transformer});

  @override
  T transform(double value) {
    return transformer(value);
  }
}

/// Transform the current value by including it between [begin] and [end]
class AdapterTween extends Tween<double?> {
  AdapterTween({required double begin, required double end}) : super(begin: begin, end: end);

  @override
  double? transform(double t) {
    if (t <= begin!) {
      return begin;
    } else if (t >= end!) {
      return end;
    } else {
      return lerp(t - begin!);
    }
  }
}

/// Define rotation by gradi 0 -> 360
class RotationTween extends Tween<double> {
  RotationTween({required double begin, required double end}) : super(begin: begin, end: end);

  @override
  double transform(double t) {
    return lerp(t) / 360;
  }
}

class OffsetTween extends Tween<Offset> {
  OffsetTween({Offset? begin, Offset? end}) : super(begin: begin, end: end);
}

class PathTween extends Animatable<Offset> {
  final Path path;
  final bool invertOffset;

  PathTween({required this.path, this.invertOffset = false});

  @override
  Offset transform(double value) {
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return invertOffset ? -pos!.position : pos!.position;
  }
}
