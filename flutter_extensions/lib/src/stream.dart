import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

extension StreamFlutterExt<T> on Stream<T> {
  Stream<T> dumpErrorToConsoleFlutter() => doOnError((error, stackTrace) {
        FlutterError.dumpErrorToConsole(FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
        ));
      });
}

extension FutureFlutterExt<T> on Future<T> {
  Future<T> dumpErrorToConsoleFlutter() => catchError((error, stackTrace) {
        FlutterError.dumpErrorToConsole(FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
        ));
      });
}
