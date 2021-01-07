import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_extensions/src/widgets/stream/RxStreamConsumerBase.dart';
import 'package:rxdart/streams.dart';

abstract class RxStreamConditions {
  static bool onChangeData(AsyncSnapshot previous, AsyncSnapshot current) {
    return previous.data != current.data;
  }

  static bool onChangeDataOrError(AsyncSnapshot previous, AsyncSnapshot current) {
    return previous.data != current.data || previous.error != current.error;
  }
}

class RxStreamConsumer<T> extends _AsyncRxStreamConsumer<T>
    with RxStreamListenerBase<AsyncSnapshot<T>>, RxStreamBuilderBase<AsyncSnapshot<T>> {
  final bool Function(AsyncSnapshot<T> p, AsyncSnapshot<T> c) listenWhen;
  final void Function(BuildContext context, AsyncSnapshot<T> snapshot) listener;
  final bool Function(AsyncSnapshot<T> p, AsyncSnapshot<T> c) buildWhen;
  final AsyncWidgetBuilder<T> builder;

  RxStreamConsumer({
    Key key,
    T initialValue,
    @required Stream<T> stream,
    this.listenWhen,
    @required this.listener,
    this.buildWhen,
    @required this.builder,
  }) : super(key: key, initialValue: initialValue, stream: stream);

  @override
  _RxStreamConsumerState<T> createState() => _RxStreamConsumerState();
}

class _RxStreamConsumerState<T> extends _AsyncRxStreamConsumerState<RxStreamConsumer<T>, T>
    with
        RxStreamListenerBaseState<RxStreamConsumer<T>, AsyncSnapshot<T>, T>,
        RxStreamBuilderBaseState<RxStreamConsumer<T>, AsyncSnapshot<T>, T> {}

class RxStreamListener<T> extends _AsyncRxStreamConsumer<T>
    with RxStreamListenerBase<AsyncSnapshot<T>> {
  final bool Function(AsyncSnapshot<T> p, AsyncSnapshot<T> c) listenWhen;
  final void Function(BuildContext context, AsyncSnapshot<T> snapshot) listener;
  final Widget child;

  RxStreamListener({
    Key key,
    T initialValue,
    @required Stream<T> stream,
    this.listenWhen,
    @required this.listener,
    @required this.child,
  }) : super(key: key, initialValue: initialValue, stream: stream);

  @override
  _RxStreamListenerState<T> createState() => _RxStreamListenerState();
}

class _RxStreamListenerState<T> extends _AsyncRxStreamConsumerState<RxStreamListener<T>, T>
    with RxStreamListenerBaseState<RxStreamListener<T>, AsyncSnapshot<T>, T> {
  @override
  Widget build(BuildContext context) => widget.child;
}

class RxStreamBuilder<T> extends _AsyncRxStreamConsumer<T>
    with RxStreamBuilderBase<AsyncSnapshot<T>> {
  @override
  final bool Function(AsyncSnapshot<T> p, AsyncSnapshot<T> c) buildWhen;
  @override
  final AsyncWidgetBuilder<T> builder;

  RxStreamBuilder({
    Key key,
    T initialValue,
    @required Stream<T> stream,
    this.buildWhen,
    @required this.builder,
  }) : super(key: key, initialValue: initialValue, stream: stream);

  @override
  _RxStreamBuilderState<T> createState() => _RxStreamBuilderState<T>();
}

class _RxStreamBuilderState<T> extends _AsyncRxStreamConsumerState<RxStreamBuilder<T>, T>
    with RxStreamBuilderBaseState<RxStreamBuilder<T>, AsyncSnapshot<T>, T> {}

abstract class _AsyncRxStreamConsumer<T> extends StatefulWidget {
  final T initialValue;
  final Stream<T> stream;

  const _AsyncRxStreamConsumer({Key key, @required this.initialValue, @required this.stream})
      : super(key: key);

  @override
  _AsyncRxStreamConsumerState<_AsyncRxStreamConsumer<T>, T> createState();
}

abstract class _AsyncRxStreamConsumerState<W extends _AsyncRxStreamConsumer<T>, T>
    extends RxStreamConsumerBaseState<W, AsyncSnapshot<T>, T> {
  @override
  Stream<T> get stream => widget.stream;

  @override
  AsyncSnapshot<T> initial() {
    if (widget.initialValue != null)
      return AsyncSnapshot.withData(ConnectionState.none, widget.initialValue);
    return AsyncSnapshot.nothing();
  }

  @override
  AsyncSnapshot<T> afterConnected(AsyncSnapshot<T> current) {
    final stream = this.stream;

    return stream is ValueStream<T> && stream.hasValue
        ? AsyncSnapshot.withData(ConnectionState.active, stream.value)
        : current.inState(ConnectionState.waiting);
  }

  @override
  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) =>
      AsyncSnapshot.withData(ConnectionState.active, data);

  @override
  AsyncSnapshot<T> afterError(AsyncSnapshot<T> current, Object error) =>
      AsyncSnapshot.withError(ConnectionState.active, error);

  @override
  AsyncSnapshot<T> afterDone(AsyncSnapshot<T> current) => current.inState(ConnectionState.done);

  @override
  AsyncSnapshot<T> afterDisconnected(AsyncSnapshot<T> current) =>
      current.inState(ConnectionState.none);
}
