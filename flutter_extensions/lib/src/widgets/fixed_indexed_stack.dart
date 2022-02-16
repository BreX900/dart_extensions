import 'package:flutter/material.dart';

// Build the child only when the index is selected
class FixedIndexedStack extends StatefulWidget {
  /// see [IndexedStack.index]
  final int index;

  /// see [Stack.alignment]
  final AlignmentGeometry alignment;

  /// see [Stack.textDirection]
  final TextDirection? textDirection;

  /// see [Stack.fit]
  final StackFit sizing;

  /// see [MultiChildRenderObjectWidget.children]
  final List<Widget> children;

  FixedIndexedStack({
    Key? key,
    this.index = 0,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
    this.children = const <Widget>[],
  })  : assert(children.every((child) => child.key != null)),
        super(key: key);

  @override
  _FixedIndexedStackState createState() => _FixedIndexedStackState();
}

class _FixedIndexedStackState extends State<FixedIndexedStack> {
  late Set<Key> _indexedChildren;

  @override
  void initState() {
    super.initState();
    _indexedChildren = {};
  }

  @override
  void didUpdateWidget(covariant FixedIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    _indexedChildren.removeWhere((key) => !widget.children.any((child) => child.key == key));

    if (widget.index != oldWidget.index) {
      final child = widget.children[widget.index];
      _indexedChildren.add(child.key!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = widget.children.map((child) {
      return _indexedChildren.contains(child.key) ? child : const SizedBox.shrink();
    }).toList();

    return IndexedStack(
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: children,
    );
  }
}
