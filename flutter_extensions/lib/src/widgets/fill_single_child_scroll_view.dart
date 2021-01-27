import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Assigns the scroll view a minimum size equal to the maximum view size
///
/// Allows you to use flex widgets within a scroll view
class FillSingleChildScrollView extends StatelessWidget {
  /// [SingleChildScrollView.controller]
  final ScrollController controller;

  /// [SingleChildScrollView.scrollDirection]
  final Axis scrollDirection;

  /// [SingleChildScrollView.reverse]
  final bool reverse;

  /// [SingleChildScrollView.padding]
  final EdgeInsetsGeometry padding;

  /// [SingleChildScrollView.primary]
  final bool primary;

  /// [SingleChildScrollView.physics]
  final ScrollPhysics physics;

  /// [SingleChildScrollView.dragStartBehavior]
  final DragStartBehavior dragStartBehavior;

  /// [SingleChildScrollView.clipBehavior]
  final Clip clipBehavior;

  /// [SingleChildScrollView.restorationId]
  final String restorationId;

  /// [SingleChildScrollView.child]
  final Widget child;

  const FillSingleChildScrollView({
    Key key,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final current = padding != null
            ? Padding(
                padding: padding,
                child: child,
              )
            : child;
        return SingleChildScrollView(
          controller: controller,
          scrollDirection: scrollDirection,
          reverse: reverse,
          primary: primary,
          physics: physics,
          dragStartBehavior: dragStartBehavior,
          clipBehavior: clipBehavior,
          restorationId: restorationId,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: scrollDirection == Axis.vertical ? box.maxHeight - 1.0 : double.infinity,
              minWidth: scrollDirection == Axis.horizontal ? box.maxWidth - 1.0 : double.infinity,
            ),
            child: scrollDirection == Axis.vertical
                ? IntrinsicHeight(child: current)
                : IntrinsicWidth(child: current),
          ),
        );
      },
    );
  }
}
