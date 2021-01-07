import 'package:flutter/widgets.dart';
import 'package:flutter_extensions/src/widgets/stream/RxStreamConsumerBase.dart';
import 'package:rxdart/streams.dart';

class ValueStreamConsumer<T> extends _ValueStreamConsumer<T>
    with RxStreamListenerBase<T>, RxStreamBuilderBase<T> {
  final bool Function(T p, T c) listenWhen;
  final void Function(BuildContext context, T data) listener;
  final bool Function(T p, T c) buildWhen;
  final Widget Function(BuildContext context, T data) builder;

  ValueStreamConsumer({
    Key key,
    T initialValue,
    @required Stream<T> stream,
    this.listenWhen,
    @required this.listener,
    this.buildWhen,
    @required this.builder,
  }) : super(key: key, initialValue: initialValue, stream: stream);

  @override
  _ValueStreamConsumerState<T> createState() => _ValueStreamConsumerState();
}

class _ValueStreamConsumerState<T> extends __ValueStreamConsumerState<ValueStreamConsumer<T>, T>
    with
        RxStreamListenerBaseState<ValueStreamConsumer<T>, T, T>,
        RxStreamBuilderBaseState<ValueStreamConsumer<T>, T, T> {}

class ValueStreamListener<T> extends _ValueStreamConsumer<T> with RxStreamListenerBase<T> {
  final bool Function(T p, T c) listenWhen;
  final void Function(BuildContext context, T data) listener;
  final Widget child;

  ValueStreamListener({
    Key key,
    T initialValue,
    @required Stream<T> stream,
    this.listenWhen,
    @required this.listener,
    @required this.child,
  }) : super(key: key, initialValue: initialValue, stream: stream);

  @override
  _ValueStreamListenerState<T> createState() => _ValueStreamListenerState();
}

class _ValueStreamListenerState<T> extends __ValueStreamConsumerState<ValueStreamListener<T>, T>
    with RxStreamListenerBaseState<ValueStreamListener<T>, T, T> {
  @override
  Widget build(BuildContext context) => widget.child;
}

class ValueStreamBuilder<T> extends _ValueStreamConsumer<T> with RxStreamBuilderBase<T> {
  final bool Function(T p, T c) buildWhen;
  final Widget Function(BuildContext context, T data) builder;

  ValueStreamBuilder({
    Key key,
    T initialValue,
    @required Stream<T> stream,
    this.buildWhen,
    @required this.builder,
  }) : super(key: key, initialValue: initialValue, stream: stream);

  @override
  _ValueStreamBuilderState<T> createState() => _ValueStreamBuilderState<T>();
}

class _ValueStreamBuilderState<T> extends __ValueStreamConsumerState<ValueStreamBuilder<T>, T>
    with RxStreamBuilderBaseState<ValueStreamBuilder<T>, T, T> {}

abstract class _ValueStreamConsumer<T> extends StatefulWidget {
  final T initialValue;
  final Stream<T> stream;

  const _ValueStreamConsumer({Key key, @required this.initialValue, @required this.stream})
      : super(key: key);

  @override
  __ValueStreamConsumerState<_ValueStreamConsumer<T>, T> createState();
}

abstract class __ValueStreamConsumerState<W extends _ValueStreamConsumer<T>, T>
    extends RxStreamConsumerBaseState<W, T, T> {
  @override
  Stream<T> get stream => widget.stream;

  @override
  T initial() => widget.initialValue;

  @override
  T afterConnected(T current) {
    final stream = this.stream;

    return stream is ValueStream<T> && stream.hasValue ? stream.value : current;
  }

  @override
  T afterData(T current, T data) => data;

  @override
  T afterError(T current, Object error) {
    FlutterError.dumpErrorToConsole(FlutterErrorDetails(
      library: 'Flutter Extensions',
      exception: error,
    ));
    return current;
  }

  @override
  T afterDone(T current) => current;

  @override
  T afterDisconnected(T current) => current;
}
