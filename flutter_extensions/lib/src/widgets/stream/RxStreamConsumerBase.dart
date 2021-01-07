import 'dart:async';

import 'package:flutter/widgets.dart';

mixin RxStreamListenerBase<S> on StatefulWidget {
  bool Function(S p, S c) get listenWhen;
  void Function(BuildContext context, S snapshot) get listener;
}

mixin RxStreamListenerBaseState<W extends RxStreamListenerBase<S>, S, T>
    on RxStreamConsumerBaseState<W, S, T> {
  @override
  bool onUpdate(S previous, S current) {
    if (widget.listenWhen == null || widget.listenWhen(previous, current)) {
      widget.listener(context, current);
    }
    return super.onUpdate(previous, current);
  }
}

mixin RxStreamBuilderBase<S> on StatefulWidget {
  bool Function(S p, S c) get buildWhen;
  Widget Function(BuildContext context, S summary) get builder;
}

mixin RxStreamBuilderBaseState<W extends RxStreamBuilderBase<S>, S, T> on RxStreamConsumerBaseState<W, S, T> {
  @override
  bool onUpdate(S previous, S current) {
    final res = super.onUpdate(previous, current);
    if (!res && (widget.buildWhen == null || widget.buildWhen(previous, current))) {
      setState(() {
        summary = current;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, summary);
}

abstract class RxStreamConsumerBaseState<W extends StatefulWidget, S, T> extends State<W> {
  Stream<T> _stream;
  StreamSubscription<T> _subscription;
  S summary;

  @override
  void initState() {
    super.initState();
    _stream = stream;
    summary = initial();
    _subscribe();
  }

  @override
  void didUpdateWidget(W oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newStream = stream;
    if (_stream != newStream) {
      _stream = newStream;
      if (_subscription != null) {
        _unsubscribe();
        summary = afterDisconnected(summary);
      }
      _subscribe();
    }
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    if (_stream != null) {
      _subscription = _stream.listen((T data) {
        _update(afterData(summary, data));
      }, onError: (Object error) {
        _update(afterError(summary, error));
      }, onDone: () {
        _update(afterDone(summary));
      });
      summary = afterConnected(summary);
    }
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }

  void _update(S newSummary) {
    if (onUpdate(summary, newSummary)) return;
    summary = newSummary;
  }

  bool onUpdate(S previous, S current) => false;

  Stream<T> get stream;

  S initial();

  S afterConnected(S current) => current;

  S afterData(S current, T data);

  S afterError(S current, Object error) => current;

  S afterDone(S current) => current;

  S afterDisconnected(S current) => current;
}
