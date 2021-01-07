import 'dart:convert';

import 'package:basic_utils/basic_utils.dart' as bu;
import 'package:rational/rational.dart';

extension StringDartExtensions on String {
  /// helloWordGood => HELLO_WORD_GOOD
  String toUpperUnderscore() => bu.StringUtils.camelCaseToUpperUnderscore(this);

  /// hello_word_good => Hello_word_good
  String toUpperFirstCase() => this[0].toUpperCase() + substring(1);

  /// hello_word_good => helloWordGood
  String toCamelCase() {
    return replaceAllMapped(RegExp(r'([_:].)'), (match) {
      return match.group(0)[1].toUpperCase();
    });
  }

  String ifEmpty(String Function() fn) => isEmpty ? fn() : this;

  bool get isBlank => this.trim().isEmpty;

  String ifBlank(String Function() fn) => isBlank ? fn() : this;

  String nullIfEmpty() => isEmpty ? null : this;

  Map<String, dynamic> decodeToMap() =>
      jsonDecode(this) as Map<String, dynamic>;

  List<Map<String, dynamic>> decodeToList() =>
      jsonDecode(this) as List<Map<String, dynamic>>;

  List<String> divide([int startAt = 0, int divideAt, int endAt]) {
    endAt ??= length;
    divideAt ??= endAt ~/ 2;
    return [
      substring(startAt, divideAt),
      substring(divideAt + 1, endAt),
    ];
  }

  String advSubString(int start, [int end]) {
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

  String joinPath(String path) {
    if (this.endsWith('/')) {
      return '${this}${path.startsWith('/') ? path.substring(1) : path}';
    } else {
      return '${this}${path.startsWith('/') ? path : '/$path'}';
    }
  }

  @deprecated
  String joinPaths(Iterable<String> paths) {
    return '${trimBy('/')}/${paths.map((e) => e.trimBy('/')).join('/')}';
  }

  Rational toRational() => Rational.parse(this);

  Rational tryToRational() {
    try {
      return Rational.parse(this);
    } catch (_) {
      return null;
    }
  }
}
