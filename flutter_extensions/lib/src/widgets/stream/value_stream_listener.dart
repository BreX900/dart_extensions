import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_extensions/src/utility/typedef.dart';
import 'package:provider/single_child_widget.dart';

class ValueStreamListener<TValue> extends SingleChildStatefulWidget {
  final Stream<TValue>? stream;
  final ValueCondition<TValue>? listenWhen;
  final ValueListener<TValue> listener;

  const ValueStreamListener({
    Key? key,
    this.stream,
    this.listenWhen,
    required this.listener,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  _ValueStreamListenerState<TValue> createState() => _ValueStreamListenerState();
}

class _ValueStreamListenerState<TValue> extends SingleChildState<ValueStreamListener<TValue>> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _listenStream();
  }

  @override
  void didUpdateWidget(covariant ValueStreamListener<TValue> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stream != oldWidget.stream) {
      _sub?.cancel();
      _listenStream();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _sub?.cancel();
  }

  void _listenStream() {
    _sub = widget.stream?.distinct((p, c) {
      if (widget.listenWhen != null) {
        return !widget.listenWhen!(p, c);
      }
      return false;
    }).listen((value) {
      widget.listener(context, value);
    });
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => child!;
}
