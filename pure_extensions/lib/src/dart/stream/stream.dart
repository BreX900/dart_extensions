import 'dart:async';

import 'package:rxdart/rxdart.dart';

extension StreamPureExtensions<T> on Stream<T> {
  /// [Stream.distinct] by [T.runtimeType]
  Stream<T> distinctRuntimeType() => distinct((bef, aft) => bef.runtimeType == aft.runtimeType);

  /// Allows you to provide a function that will be executed whenever a value changes.

  /// Listen for changes in the stream and call [onStart].
  /// [onData] is called, with the previous value and the current value, after a [debounceTime]
  /// and only if the value has changed does it return a result which is passed to [onFinish].
  ///
  /// More over, it lets you provide a function [equals] to describe when to values can be considered the same
  StreamSubscription<dynamic> listenValueChanges<R>({
    Duration debounceTime = const Duration(),
    bool Function(T previous, T current)? equals,
    void Function(T previous, T current)? onStart,
    required Stream<R> Function(T previous, T current) onData,
    void Function(T previous, T current, R result)? onFinish,
    Function? onError,
    void Function()? onDone,
  }) {
    final _onStart = onStart ?? (T p, T c) {};
    final _onFinish = onFinish ?? ((T p, T c, R r) => r);

    return distinct(equals)
        .pairwise()
        .doOnData((vls) => _onStart(vls.first, vls.last))
        .debounceTime(debounceTime)
        .switchMap<List<dynamic>>((vls) {
      return onData(vls.first, vls.last).map((result) => <dynamic>[vls.first, vls.last, result]);
    }).listen(
      (list) => _onFinish(list[0] as T, list[1] as T, list[2] as R),
      onError: onError,
      onDone: onDone,
    );
  }

  Future<R> firstType<R>({R Function()? orElse}) {
    final completer = Completer<R>();
    firstWhere((v) => v is T).then((v) => completer.complete(v as R),
        onError: (exception, stackTrace) {
      if (exception is StateError && orElse != null) {
        completer.complete(orElse());
      } else {
        completer.completeError(exception, stackTrace);
      }
    });
    return completer.future;
  }

  Future<R> firstRuntimeType<R>({R Function()? orElse}) {
    final completer = Completer<R>();
    firstWhere((v) => v.runtimeType == T).then((v) => completer.complete(v as R),
        onError: (exception, stackTrace) {
      if (exception is StateError && orElse != null) {
        completer.complete(orElse());
      } else {
        completer.completeError(exception, stackTrace);
      }
    });
    return completer.future;
  }

  Stream<T> dumpErrorToConsoleDart() => doOnError((error, stackTrace) {
        print(error);
        print(stackTrace);
      });

  /// Returns itself with the [Stream] type useful when you don't want the [ValueStream] type.
  Stream<T> asStream() => this;

  /// Returns a broadcast stream without wrapping it unnecessarily.
  Stream<T> asBroadcast() => isBroadcast ? this : asBroadcastStream();
}

extension FutureDartExt<T> on Future<T> {
  Future<T> dumpErrorToConsoleDart() => catchError((error, stackTrace) {
        print(error);
        print(stackTrace);
      });
}

/// Acts as a map for multiple subscriptions that can be canceled at once
class CompositeMapSubscription<K> {
  bool _isDisposed = false;

  final _subscriptions = <K, StreamSubscription<dynamic>>{};

  /// Checks if this composite is disposed. If it is, the composite can't be used again
  /// and will throw an error if you try to add more subscriptions to it.
  bool get isDisposed => _isDisposed;

  /// Returns the total amount of currently added [StreamSubscription]s
  int get length => _subscriptions.length;

  /// Checks if there currently are no [StreamSubscription]s added
  bool get isEmpty => _subscriptions.isEmpty;

  /// Checks if there currently are [StreamSubscription]s added
  bool get isNotEmpty => _subscriptions.isNotEmpty;

  /// Whether all managed [StreamSubscription]s are currently paused.
  bool get allPaused =>
      _subscriptions.isNotEmpty ? _subscriptions.values.every((it) => it.isPaused) : false;

  /// Adds new subscription to this composite.
  StreamSubscription<T> add<T>(K key, StreamSubscription<T> subscription) {
    _check();
    _subscriptions[key] = subscription;
    return subscription;
  }

  /// Cancels subscription and removes it from this composite.
  Future<dynamic> remove(K key) => _subscriptions.remove(key)!.cancel();

  /// Cancels all subscriptions added to this composite. Clears subscriptions collection.
  Future<void> clear() {
    final result = Future.wait(_subscriptions.values.map((subscription) => subscription.cancel()));
    _subscriptions.clear();
    return result;
  }

  /// Cancels all subscriptions added to this composite. Disposes this.
  Future<void> dispose() {
    final result = clear();
    _isDisposed = true;
    return result;
  }

  /// Pauses all subscriptions added to this composite.
  void pauseAll([Future? resumeSignal]) {
    for (final it in _subscriptions.values) {
      it.pause(resumeSignal);
    }
  }

  /// Resumes all subscriptions added to this composite.
  void resumeAll() {
    for (final it in _subscriptions.values) {
      it.resume();
    }
  }

  StreamSubscription<T> putIfAbsent<T>(K key, StreamSubscription<T> Function() ifAbsent) {
    _check();
    return _subscriptions.putIfAbsent(key, ifAbsent) as StreamSubscription<T>;
  }

  StreamSubscription<T?>? get<T>(K key) => _subscriptions[key] as StreamSubscription<T?>?;

  bool containsKey(K key) => _subscriptions.containsKey(key);

  bool containsSubscription(StreamSubscription subscription) {
    return _subscriptions.containsValue(subscription);
  }

  void _check() {
    if (isDisposed) {
      throw ('This composite was disposed, try to use new instance instead');
    }
  }
}

extension SubscriptionCompositeExtension on StreamSubscription {
  void addToByKey<K>(CompositeMapSubscription<K> subscriber, K key) {
    subscriber.add(key, this);
  }
}
