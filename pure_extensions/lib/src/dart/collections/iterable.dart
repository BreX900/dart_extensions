import 'dart:async';

extension IterableExtensions<T> on Iterable<T> {
  Iterable<T> get nullIfEmpty => isEmpty ? null : this;

  Map<int, T> judgeElements(int Function(T) judges) {
    final res = <int, T>{};
    for (var element in this) {
      res[judges(element)] = element;
    }
    return res;
  }

  SeparatedResult<T> separate(int Function(T) separator) {
    final less = <T>[];
    final equals = <T>[];
    final great = <T>[];
    for (var value in this) {
      final res = separator(value);
      if (res == 0) {
        equals.add(value);
      } else if (res < 0) {
        less.add(value);
      } else {
        great.add(value);
      }
    }
    return SeparatedResult._(less, equals, great);
  }

  SeparatedResult<T> separateByContains(Iterable<T> iterable) {
    final great = <T>[];
    final equals = <T>[];
    for (var value in this) {
      (iterable.contains(value) ? equals.add : great.add)(value);
    }
    return SeparatedResult._(iterable.where((value) => !contains(value)).toList(), equals, great);
  }

  Iterable<T> whereNotContains(Iterable<T> badElements) {
    return where((item) => !badElements.contains(item));
  }

  Iterable<T> whereNotNull() => where((value) => value != null);

  Iterable<T> replaces(Map<T, T> replacements) {
    return map((item) => replacements[item] ?? item);
  }

  T get tryFirst {
    try {
      return first;
    } on StateError {
      return null;
    }
  }

  T get tryLast {
    try {
      return last;
    } on StateError {
      return null;
    }
  }

  V tryFirstWhereType<V>() => firstWhere((element) => element is V, orElse: () => null) as V;

  Iterable<N> doubleMap<N>(N Function(T, T) converter) {
    final it = iterator;
    final list = <N>[];
    while (it.moveNext()) {
      final key = it.current;
      if (!it.moveNext()) return list;
      final value = it.current;
      list.add(converter(key, value));
    }
    return list;
  }

  Iterable<T> joinBuilder(T Function(int) builder) {
    if (isEmpty) return [];

    final iterator = this.iterator;
    iterator.moveNext();
    final newList = <T>[]
      ..length = (length * 2) - 1
      ..[0] = iterator.current;

    var i = 1;
    while (iterator.moveNext()) {
      newList[i] = builder(i);
      i += 1;
      newList[i] = iterator.current;
      i += 1;
    }

    return newList;
  }

  Iterable<T> joinElement(T element) => joinBuilder((index) => element);

  bool containsAll(Iterable<T> other) {
    if (identical(other, this)) return true;
    if (other.length != length) return false;
    return other.every(contains);
  }

  // Map<String, dynamic> deserialize() {
  //   final iterator = this.iterator;
  //   final map = <String, dynamic>{};
  //   while (iterator.moveNext()) {
  //     final key = iterator.current as String;
  //     map[key] = iterator.moveNext() ? iterator.current : null;
  //   }
  //   return map;
  // }

  Map<K, V> generateMap<K, V>(MapEntry<K, V> Function(T) generator) {
    return map(generator).toMap();
  }

  /// In favour of [IterableMapEntryExt.toMapList]
  @deprecated
  Map<K, List<V>> generateMapList<K, V>(MapEntry<K, V> Function(T element) generator) {
    final map = <K, List<V>>{};
    for (var element in this) {
      final entry = generator(element);
      var list = map[entry.key];
      if (list == null) {
        map[entry.key] = list = <V>[];
      }
      list.add(entry.value);
    }
    return map;
  }

  Map<int, List<T>> generateBook({int valuesPerPage, int numberOfPages}) {
    if (valuesPerPage == null && numberOfPages == null) return {0: this};
    valuesPerPage ??= this.length ~/ numberOfPages;
    var book = <int, List<T>>{};
    int pageCount = 0;
    var list = this;
    while (list.isNotEmpty && (numberOfPages == null || pageCount < numberOfPages)) {
      book[pageCount++] = this.take(valuesPerPage).toList();
      list = list.skip(valuesPerPage);
    }
    return book;
  }
}

class SeparatedResult<T> {
  final List<T> less;
  final List<T> equals;
  final List<T> great;

  SeparatedResult._(this.less, this.equals, this.great);

  List<T> get lessAndEquals => [...less, ...equals];
  List<T> get equalsAndGreat => [...equals, ...great];
  List<T> get greatAndLess => [...great, ...less];
}

extension IterableMapEntryExt<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() => Map.fromEntries(this);

  Map<K, List<V>> toMapList() {
    final map = <K, List<V>>{};
    for (var entry in this) {
      map.putIfAbsent(entry.key, () => []).add(entry.value);
    }
    return map;
  }

  Iterable<V> get values => map((entry) => entry.value);
  Iterable<K> get keys => map((entry) => entry.key);
}

extension IterableExtFuture<T> on Iterable<Future<T>> {
  Future<List<T>> waitFutures() => Future.wait(this);

  Future<T> anyFutures() => Future.any(this);
}
