import 'dart:async';

import 'package:rxdart/rxdart.dart';
// ignore: implementation_imports
import 'package:rxdart/src/utils/forwarding_sink.dart';
// ignore: implementation_imports
import 'package:rxdart/src/utils/forwarding_stream.dart';

class _OnTrackedErrorStreamSink<S> extends ForwardingSink<S, S> {
  final Stream<S> Function(Object error, StackTrace? stackTrace) _recoveryFn;
  var _inRecovery = false;
  final List<StreamSubscription<S>> _recoverySubscriptions = [];

  _OnTrackedErrorStreamSink(this._recoveryFn);

  @override
  void onData(S data) {
    if (!_inRecovery) {
      sink.add(data);
    }
  }

  @override
  void onError(Object e, [StackTrace? st]) {
    _inRecovery = true;

    final recoveryStream = _recoveryFn(e, st);
    late StreamSubscription<S> subscription;

    subscription = recoveryStream.listen(
      sink.add,
      onError: sink.addError,
      onDone: () {
        _recoverySubscriptions.remove(subscription);
        sink.close();
      },
    );
    _recoverySubscriptions.add(subscription);
  }

  @override
  void onDone() {
    if (!_inRecovery) {
      sink.close();
    }
  }

  @override
  void onListen() {}

  @override
  void onPause() {
    for (final subscription in _recoverySubscriptions) {
      subscription.pause();
    }
  }

  @override
  void onResume() {
    for (final subscription in _recoverySubscriptions) {
      subscription.resume();
    }
  }

  @override
  FutureOr onCancel() {
    return _recoverySubscriptions.isEmpty
        ? null
        : Future.wait<dynamic>(_recoverySubscriptions.map((subscription) => subscription.cancel()));
  }
}

/// It is similar to [OnErrorResumeStreamTransformer] but with [StackTrace]
class OnTrackedErrorResumeStreamTransformer<S> extends StreamTransformerBase<S, S> {
  final Stream<S> Function(Object error, StackTrace? stackTrace) recoveryFn;

  OnTrackedErrorResumeStreamTransformer(this.recoveryFn);

  @override
  Stream<S> bind(Stream<S> stream) =>
      forwardStream(stream, () => _OnTrackedErrorStreamSink<S>(recoveryFn));
}

extension OnTrackedErrorExtensions<T> on Stream<T> {
  /// It is similar to [OnErrorExtensions.onErrorResume] but with [StackTrace]
  Stream<T> onTrackedErrorResume(
          Stream<T> Function(Object error, StackTrace? stackTrace) recoveryFn) =>
      transform(OnTrackedErrorResumeStreamTransformer<T>(recoveryFn));

  /// It is similar to [OnErrorExtensions.onErrorReturnWith] but with [StackTrace]
  Stream<T> onTrackedErrorReturnWith(T Function(Object error, StackTrace? stackTrace) returnFn) =>
      transform(OnTrackedErrorResumeStreamTransformer<T>((e, st) => Stream.value(returnFn(e, st))));
}
