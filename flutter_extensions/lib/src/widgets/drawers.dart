import 'package:flutter/widgets.dart';

mixin WidgetsBindingObserverOnState<W extends StatefulWidget> on State<W> implements WidgetsBindingObserver {
  WidgetsBinding get widgetsBinding => WidgetsBinding.instance;

  @override
  void initState() {
    super.initState();
    widgetsBinding.addObserver(this);
  }

  @override
  void dispose() {
    widgetsBinding.removeObserver(this);
    super.dispose();
  }
}

class PhysicalSizeBuilder extends StatefulWidget {
  final bool Function(Size previous, Size current) buildWhen;
  final Widget Function(BuildContext context, Size size) builder;

  const PhysicalSizeBuilder({Key key, this.buildWhen, @required this.builder}) : super(key: key);

  @override
  _PhysicalSizeBuilderState createState() => _PhysicalSizeBuilderState();
}

class _PhysicalSizeBuilderState extends State<PhysicalSizeBuilder>
    with WidgetsBindingObserver, WidgetsBindingObserverOnState {
  Size _size;
  Size get currentSize => widgetsBinding.window.physicalSize;

  @override
  void initState() {
    super.initState();
    _size = currentSize;
  }

  @override
  void didChangeMetrics() {
    if (widget.buildWhen == null || widget.buildWhen(_size, currentSize)) {
      setState(() {
        _size = currentSize;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _size);
  }
}

class DrawerBarBuilder extends StatefulWidget {
  final double widthLimit;
  final Widget Function(BuildContext context, bool isBarDimension) builder;

  const DrawerBarBuilder({Key key, this.widthLimit = 500, @required this.builder}) : super(key: key);

  @override
  _DrawerBarBuilderState createState() => _DrawerBarBuilderState();
}

class _DrawerBarBuilderState extends State<DrawerBarBuilder>
    with WidgetsBindingObserver, WidgetsBindingObserverOnState {
  bool _isBarDimension;

  bool get isPhysicalWidthBarDimension => widgetsBinding.window.physicalSize.width <= widget.widthLimit;

  @override
  void initState() {
    super.initState();
    _isBarDimension = isPhysicalWidthBarDimension;
  }

  @override
  void didChangeMetrics() {
    if (isPhysicalWidthBarDimension && !_isBarDimension) {
      setState(() {
        _isBarDimension = true;
      });
    } else if (_isBarDimension) {
      setState(() {
        _isBarDimension = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _isBarDimension);
  }
}
