import 'dart:async';

extension FutureDartExtensions<T> on Future<T> {
  /// [Future.delayed]
  Future<T> delay(Duration duration, [FutureOr<T> Function()? computation]) {
    return whenComplete(() => Future.delayed(duration, computation));
  }

  /// It does not wait for the current future to be concluded
  void unawaited() => this;
}
