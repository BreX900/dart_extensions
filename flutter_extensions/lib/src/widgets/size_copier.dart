import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

/// Provides the size of another widget
class SizeCopierController extends ChangeNotifier {
  Size _size;

  SizeCopierController({Size initialSize = Size.zero}) : _size = initialSize;

  Size get size => _size;

  set size(Size size) {
    if (_size == size) return;
    _size = size;
    notifyListeners();
  }
}

abstract class SizeCopierBinders {
  SizeCopierBinders._();

  static BoxConstraints tight(Size size) {
    return BoxConstraints(minWidth: size.width, minHeight: size.height);
  }

  static BoxConstraints identical(Size size) {
    return BoxConstraints(
      minWidth: size.width,
      maxWidth: size.width,
      minHeight: size.height,
      maxHeight: size.height,
    );
  }

  static BoxConstraints loose(Size size) {
    return BoxConstraints(maxWidth: size.width, maxHeight: size.height);
  }
}

/// Copy the widget size into `SizeCopierController`
class SizeCopier extends StatefulWidget {
  final Widget child;

  SizeCopier({Key? key, required this.child}) : super(key: key);

  @override
  SizeCopierState createState() => SizeCopierState();
}

class SizeCopierState extends State<SizeCopier> {
  @override
  void initState() {
    super.initState();
    _copySize();
  }

  void _copySize() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      final box = context.findRenderObject() as RenderBox;
      Provider.of<SizeCopierController>(context, listen: false).size = box.size;
    });
  }

  bool _handleNotification(SizeChangedLayoutNotification notification) {
    _copySize();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: _handleNotification,
      child: SizeChangedLayoutNotifier(
        child: widget.child,
      ),
    );
  }
}

/// Read the widget size into `SizeCopierController` and build the child
class SizeCopy extends StatefulWidget {
  final Widget Function(BuildContext, Size) builder;

  SizeCopy({
    Key? key,
    BoxConstraints Function(Size) binder = SizeCopierBinders.identical,
    Widget Function(BuildContext, Widget)? builder,
    Widget? child,
  }) : this.builder(
          key: key,
          builder: (context, size) {
            final copy = ConstrainedBox(constraints: binder(size), child: child);
            if (builder != null) return builder(context, copy);
            return copy;
          },
        );

  const SizeCopy.builder({Key? key, required this.builder}) : super(key: key);

  @override
  _SizeCopyState createState() => _SizeCopyState();
}

class _SizeCopyState extends State<SizeCopy> {
  late SizeCopierController _controller = SizeCopierController();
  late Size _size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newController = Provider.of<SizeCopierController>(context);
    if (_controller != newController) {
      _removeListener();
      _controller = newController;
      _addListener();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _removeListener();
  }

  void _addListener() {
    _controller.addListener(_updateSize);
    _size = _controller.size;
  }

  void _removeListener() {
    _controller.removeListener(_updateSize);
  }

  void _updateSize() {
    if (_size != _controller.size) {
      setState(() {
        _size = _controller.size;
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _size);
}
