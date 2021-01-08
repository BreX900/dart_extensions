import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

extension StreamExtDart<T> on Stream<T> {
  /// [Stream.distinct] by [T.runtimeType]
  Stream<T> distinctRuntimeType() => distinct((bef, aft) => bef.runtimeType == aft.runtimeType);

  /// Listen for changes in the value specified by [lens] and call [onStart].
  /// [onData] is called, with the previous value and the current value, after a [debounceTime]
  /// and only if the value has changed does it return a result which is passed to [onFinish].
  StreamSubscription<dynamic> listenValueChanges<V, R>({
    Duration debounceTime = const Duration(),
    @required V Function(T event) lens,
    bool Function(V previous, V current) equals,
    void Function(V previous, V current) onStart,
    @required Stream<R> Function(V previous, V current) onData,
    void Function(V previous, V current, R result) onFinish,
  }) {
    assert(lens != null, 'lens function is required');
    assert(debounceTime != null, 'debounceTime can\'t be null');
    assert(onData != null, 'onData function is required');

    final _onStart = onStart ?? (V p, V c) {};
    final _onFinish = onFinish ?? (V p, V c, R r) => r;

    return map(lens)
        .distinct(equals)
        .pairwise()
        .doOnData((vls) => _onStart(vls.first, vls.last))
        .debounceTime(debounceTime)
        .switchMap<List<dynamic>>((vls) {
      return onData(vls.first, vls.last).map((result) => <dynamic>[vls.first, vls.last, result]);
    }).listen((list) => _onFinish(list[0] as V, list[1] as V, list[2] as R));
  }

  Future<R> firstType<R>({R orElse()}) {
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

  Future<R> firstRuntimeType<R>({R orElse()}) {
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
  Future<dynamic> remove(K key) => _subscriptions.remove(key).cancel();

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
  void pauseAll([Future resumeSignal]) =>
      _subscriptions.values.forEach((it) => it.pause(resumeSignal));

  /// Resumes all subscriptions added to this composite.
  void resumeAll() => _subscriptions.values.forEach((it) => it.resume());

  StreamSubscription<T> putIfAbsent<T>(K key, StreamSubscription<T> Function() ifAbsent) {
    _check();
    return _subscriptions.putIfAbsent(key, ifAbsent);
  }

  StreamSubscription<T> get<T>(K key) => _subscriptions[key];

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
