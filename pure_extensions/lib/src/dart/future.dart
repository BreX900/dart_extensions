import 'dart:async';

extension FuturePureExtensions<T> on Future<T> {
  /// [Future.delayed]
  Future<T> delay(Duration duration, [FutureOr<T> Function()? computation]) {
    return whenComplete(() => Future.delayed(duration, computation));
  }

  /// It does not wait for the current future to be concluded
  void unawaited() => this;

  Future<T> onDone(void Function(T value) onDone) async {
    final value = await this;
    onDone(value);
    return value;
  }
}
