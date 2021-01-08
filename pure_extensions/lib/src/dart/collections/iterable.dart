import 'dart:async';

extension IterableExtensions<T> on Iterable<T> {
  /// returns null or if it is empty returns true.
  Iterable<T> get nullIfEmpty => isEmpty ? null : this;

  Iterable<T> whereNotNull() => where((value) => value != null);

  /// replace the old elements contained in the map with new ones.
  Iterable<T> replaces(Map<T, T> replacements) {
    return map((item) => replacements[item] ?? item);
  }

  /// Returns a iterable without [badElements]
  Iterable<T> without(Iterable<T> badElements) {
    return where((item) => !badElements.contains(item));
  }

  /// Concatenates the elements given by function.
  Iterable<T> joinBy(T Function(int) builder) {
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

  /// Concatenates the elements.
  Iterable<T> joinElement(T element) => joinBy((index) => element);

  /// Returns the first entry if it exists otherwise null.
  ///
  /// [Iterable.first]
  T get tryFirst {
    try {
      return first;
    } on StateError {
      return null;
    }
  }

  /// Returns the last entry if it exists otherwise null.
  ///
  /// [Iterable.last]
  T get tryLast {
    try {
      return last;
    } on StateError {
      return null;
    }
  }

  /// Returns true if the specified value is equal to at least one element of the given list;
  /// false otherwise
  bool containsAll(Iterable<T> other) {
    if (identical(other, this)) return true;
    if (other.length != length) return false;
    return other.every(contains);
  }

  /// Splits a list into sub-lists stored in an object, based on the result of calling a
  /// function on each element, and grouping the results according to values returned.
  Map<K, List<T>> groupBy<K>(K Function(T element) fn) {
    return map((e) => MapEntry(fn(e), e)).toMapList();
  }

  /// Generate the map by collection.
  Map<K, V> generateMap<K, V>(MapEntry<K, V> Function(T) generator) {
    return map(generator).toMap();
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

extension IterableMapEntryExt<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() => Map.fromEntries(this);

  /// Grouping the results in list according to key.
  Map<K, List<V>> toMapList() {
    final map = <K, List<V>>{};
    for (var entry in this) {
      map.putIfAbsent(entry.key, () => []).add(entry.value);
    }
    return map;
  }

  /// Returns only the keys.
  ///
  /// [Map.keys]
  Iterable<K> get keys => map((entry) => entry.key);

  /// Returns only the values.
  ///
  /// [Map.values]
  Iterable<V> get values => map((entry) => entry.value);
}

extension IterableExtFuture<T> on Iterable<Future<T>> {
  /// [Future.wait]
  Future<List<T>> waitFutures() => Future.wait(this);

  /// [Future.any]
  Future<T> anyFutures() => Future.any(this);
}
