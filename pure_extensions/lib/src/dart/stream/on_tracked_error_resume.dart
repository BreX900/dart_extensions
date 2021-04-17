import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/src/utils/forwarding_sink.dart';
import 'package:rxdart/src/utils/forwarding_stream.dart';

class _OnTrackedErrorStreamSink<S> implements ForwardingSink<S, S> {
  final Stream<S> Function(Object error, StackTrace stackTrace) _recoveryFn;
  var _inRecovery = false;
  final List<StreamSubscription<S>> _recoverySubscriptions = [];

  _OnTrackedErrorStreamSink(this._recoveryFn);

  @override
  void add(EventSink<S> sink, S data) {
    if (!_inRecovery) {
      sink.add(data);
    }
  }

  @override
  void addError(EventSink<S> sink, dynamic e, [StackTrace st]) {
    _inRecovery = true;

    final recoveryStream = _recoveryFn(e, st);

    StreamSubscription<S> subscription;
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
  void close(EventSink<S> sink) {
    if (!_inRecovery) {
      sink.close();
    }
  }

  @override
  FutureOr onCancel(EventSink<S> sink) {
    return _recoverySubscriptions.isEmpty
        ? null
        : Future.wait<dynamic>(
            _recoverySubscriptions
                .map((subscription) => subscription?.cancel())
                .where((future) => future != null),
          );
  }

  @override
  void onListen(EventSink<S> sink) {}

  @override
  void onPause(EventSink<S> sink, [Future resumeSignal]) =>
      _recoverySubscriptions.forEach((subscription) => subscription.pause(resumeSignal));

  @override
  void onResume(EventSink<S> sink) =>
      _recoverySubscriptions.forEach((subscription) => subscription.resume());
}

/// It is similar to [OnErrorResumeStreamTransformer] but with [StackTrace]
class OnTrackedErrorResumeStreamTransformer<S> extends StreamTransformerBase<S, S> {
  final Stream<S> Function(Object error, StackTrace stackTrace) recoveryFn;

  OnTrackedErrorResumeStreamTransformer(this.recoveryFn);

  @override
  Stream<S> bind(Stream<S> stream) =>
      forwardStream(stream, _OnTrackedErrorStreamSink<S>(recoveryFn));
}

extension OnTrackedErrorExtensions<T> on Stream<T> {
  /// It is similar to [OnErrorExtensions.onErrorResume] but with [StackTrace]
  Stream<T> onTrackedErrorResume(
          Stream<T> Function(Object error, StackTrace stackTrace) recoveryFn) =>
      transform(OnTrackedErrorResumeStreamTransformer<T>(recoveryFn));

  /// It is similar to [OnErrorExtensions.onErrorReturnWith] but with [StackTrace]
  Stream<T> onTrackedErrorReturnWith(T Function(Object error, StackTrace stackTrace) returnFn) =>
      transform(OnTrackedErrorResumeStreamTransformer<T>(
          (Object e, StackTrace st) => Stream.value(returnFn(e, st))));
}
