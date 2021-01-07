import 'package:flutter/material.dart';

/// Build the child only when the index is selected
class FixedIndexedStack extends StatefulWidget {
  /// see [IndexedStack.index]
  final int index;

  /// see [Stack.alignment]
  final AlignmentGeometry alignment;

  /// see [Stack.textDirection]
  final TextDirection textDirection;

  /// see [Stack.fit]
  final StackFit sizing;

  /// see [MultiChildRenderObjectWidget.children]
  final List<Widget> children;

  const FixedIndexedStack({
    Key key,
    this.index = 0,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
    this.children = const <Widget>[],
  }) : super(key: key);

  @override
  _FixedIndexedStackState createState() => _FixedIndexedStackState();
}

class _FixedIndexedStackState extends State<FixedIndexedStack> {
  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = List.generate(widget.children.length, (index) => const SizedBox.shrink());
    _children[widget.index] = widget.children[widget.index];
  }

  @override
  void didUpdateWidget(covariant FixedIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length) {
      _children.length = widget.children.length;
    }
    // add or update child when index change
    _children[widget.index] = widget.children[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: _children,
    );
  }
}
