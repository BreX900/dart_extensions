import 'dart:convert';

import 'package:rational/rational.dart';

extension StringPureExtensions on String {
  /// hello_word_good => Hello_word_good
  String toUpperFirstCase() {
    if (isEmpty) return this;
    if (length == 1) return toUpperCase();
    return this[0].toUpperCase() + substring(1);
  }

  String ifEmpty(String Function() fn) => isEmpty ? fn() : this;

  bool get isBlank => trim().isEmpty;

  String ifBlank(String Function() fn) => isBlank ? fn() : this;

  String? nullIfEmpty() => isEmpty ? null : this;

  Map<String, dynamic>? decodeToMap() => jsonDecode(this) as Map<String, dynamic>?;

  List<Map<String, dynamic>>? decodeToList() => jsonDecode(this) as List<Map<String, dynamic>>?;

  List<String> divide([int startAt = 0, int? divideAt, int? endAt]) {
    endAt ??= length;
    divideAt ??= endAt ~/ 2;
    return [
      substring(startAt, divideAt),
      substring(divideAt + 1, endAt),
    ];
  }

  String advSubString(int start, [int? end]) {
    return substring(
      start < 0 ? start + length : start,
      end != null && end < 0 ? length + end : end,
    );
  }

  String trimBy(String trimmer) {
    var string = this;
    while (string.startsWith(trimmer)) {
      string = string.substring(trimmer.length);
    }
    while (string.endsWith(trimmer)) {
      string = string.advSubString(0, -trimmer.length);
    }
    return string;
  }

  num toNum() => num.parse(this);
  num? toTryNum() => num.tryParse(this);

  int toInt({int? radix}) => int.parse(this, radix: radix);
  int? toTryInt({int? radix}) => int.tryParse(this, radix: radix);

  double toDouble() => double.parse(this);
  double? toTryDouble() => double.tryParse(this);

  Rational toRational() => Rational.parse(this);
  Rational? tryToRational() {
    try {
      return Rational.parse(this);
    } catch (_) {
      return null;
    }
  }

  Uri toUri([int start = 0, int? end]) => Uri.parse(this, start, end);
  Uri? toTryUri([int start = 0, int? end]) => Uri.tryParse(this, start, end);

  DateTime toDateTime() => DateTime.parse(this);
  DateTime? toTryDateTime() => DateTime.tryParse(this);
}
