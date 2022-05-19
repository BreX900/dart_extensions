import 'dart:async';

import 'package:pure_extensions/src/dart/collections/iterators/join_element.dart';
import 'package:rational/rational.dart';

extension IterablePureExtensions<E> on Iterable<E> {
  /// returns null or if it is empty returns true.
  Iterable<E>? get nullIfEmpty => isEmpty ? null : this;

  /// replace the old elements contained in the map with new ones.
  Iterable<E> replaces(Map<E, E> replacements) {
    return map((item) => replacements[item] ?? item);
  }

  /// Returns a iterable without [elements]
  Iterable<E> whereNotContains(Iterable<E> elements) {
    return where((item) => !elements.contains(item));
  }

  /// Concatenates the elements given by function.
  Iterable<E> joinBy(E Function(int index) generator) {
    if (length <= 1) {
      return this;
    }
    return JoinElementIterable(this, generator);
  }

  /// Concatenates the elements.
  Iterable<E> joinElement(E element) => joinBy((index) => element);

  /// Returns the [index]th element or null if it not exist.
  E? elementAtOrNull(int index) {
    try {
      return elementAt(index);
    } on RangeError {
      return null;
    }
  }

  /// Returns true if the specified value is equal to at least one element of the given list;
  /// false otherwise
  @Deprecated('In favour of [containsEvery]')
  bool containsAll(Iterable<E> other) => containsEvery(other);

  /// Checks whether any element of this iterable is in [other] iterable.
  bool containsAny(Iterable<E> other) {
    if (identical(other, this)) return true;
    return any(other.contains);
  }

  /// Checks whether every element of this iterable is in [other] iterable.
  bool containsEvery(Iterable<E> other) {
    if (identical(other, this)) return true;
    return every(other.contains);
  }

  /// Generate the map by collection.
  Map<K, V> generateMap<K, V>(MapEntry<K, V> Function(E) generator) {
    return map(generator).toMap();
  }

  Map<int, E> toMap() => toList().asMap();

  Map<int, List<E>> generateBook({int? valuesPerPage, int? numberOfPages}) {
    if (valuesPerPage == null && numberOfPages == null) return {0: this as List<E>};
    valuesPerPage ??= length ~/ numberOfPages!;
    var book = <int, List<E>>{};
    int pageCount = 0;
    var list = this;
    while (list.isNotEmpty && (numberOfPages == null || pageCount < numberOfPages)) {
      book[pageCount++] = take(valuesPerPage).toList();
      list = list.skip(valuesPerPage);
    }
    return book;
  }

  /// Reduces a collection to a single value by iteratively combining previous and current
  /// element of the collection with an existing value
  V foldWithNext<V>(V initialValue, V Function(V previousValue, E current, E next) combiner) {
    Iterator<E> iterator = this.iterator;
    if (!iterator.moveNext()) {
      throw StateError("No element");
    }
    var value = initialValue;
    E current = iterator.current;
    while (iterator.moveNext()) {
      value = combiner(value, current, iterator.current);
      current = iterator.current;
    }
    return value;
  }
}

extension IterableNumPureExtensions<T extends num> on Iterable<T> {
  /// Calculate the subtraction of all numbers in the collection
  T get subtract {
    if (isEmpty) return T is double ? 0.0 as T : 0 as T;
    return reduce((previousValue, element) => previousValue - element as T);
  }

  /// Calculate the division of all numbers in the collection
  double get divide {
    return fold(0.0, (previousValue, element) => previousValue / element);
  }

  /// Calculate the multiplication of all numbers in the collection
  T get multiply {
    if (isEmpty) return T is double ? 0.0 as T : 0 as T;
    return reduce((previousValue, element) => previousValue * element as T);
  }

  /// Sum [number] to all items in the collection
  Iterable<T> sumAllBy(T number) {
    return map((element) => element + number as T);
  }

  /// Subtract [number] to all items in the collection
  Iterable<T> subtractAllBy(T number) {
    return map((element) => element - number as T);
  }

  /// Divide [number] to all items in the collection
  Iterable<double> divideAllBy(T number) {
    return map((element) => element / number);
  }

  /// Multiply [number] to all items in the collection
  Iterable<T> multiplyAllBy(T number) {
    return map((element) => element * number as T);
  }
}

extension IterableBigIntPureExtensions<T extends BigInt> on Iterable<T> {
  /// [IterableNumberExtension.sum]
  BigInt get sum {
    if (isEmpty) return BigInt.zero;
    return reduce((previousValue, element) => previousValue + element as T);
  }

  /// [IterableNumberExtension.average]
  Rational get average => Rational(sum) / Rational(BigInt.from(length));

  /// [IterableNumPureExtensions.subtract]
  BigInt get subtract {
    if (isEmpty) return BigInt.zero;
    return reduce((previousValue, element) => previousValue - element as T);
  }

  /// [IterableNumPureExtensions.divide]
  Rational get divide {
    return map((bigInt) => Rational(bigInt)).divide;
  }

  /// [IterableNumPureExtensions.multiply]
  BigInt get multiply {
    if (isEmpty) return BigInt.zero;
    return reduce((previousValue, element) => previousValue * element as T);
  }

  /// [IterableNumPureExtensions.sumAllBy]
  Iterable<T> sumAllBy(T number) {
    return map((element) => element + number as T);
  }

  /// [IterableNumPureExtensions.subtractAllBy]
  Iterable<T> subtractAllBy(T number) {
    return map((element) => element - number as T);
  }

  /// [IterableNumPureExtensions.divideAllBy]
  Iterable<Rational> divideAllBy(T number) {
    final rationalNumber = Rational(number);
    return map((element) => Rational(element) / rationalNumber);
  }

  /// [IterableNumPureExtensions.multiplyAllBy]
  Iterable<T> multiplyAllBy(T number) {
    return map((element) => element * number as T);
  }
}

extension IterableRationalPureExtensions<T extends Rational> on Iterable<T> {
  /// [IterableNumberExtension.sum]
  Rational get sum {
    if (isEmpty) return Rational.zero;
    return reduce((previousValue, element) => previousValue + element as T);
  }

  /// [IterableNumberExtension.average]
  Rational get average => sum / Rational.fromInt(length);

  /// [IterableNumPureExtensions.subtract]
  Rational get subtract {
    if (isEmpty) return Rational.zero;
    return reduce((previousValue, element) => previousValue - element as T);
  }

  /// [IterableNumPureExtensions.divide]
  Rational get divide {
    return fold(Rational.zero, (previousValue, element) => previousValue / element);
  }

  /// [IterableNumPureExtensions.multiply]
  Rational get multiply {
    if (isEmpty) return Rational.zero;
    return reduce((previousValue, element) => previousValue * element as T);
  }

  /// [IterableNumPureExtensions.sumAllBy]
  Iterable<T> sumAllBy(T number) {
    return map((element) => element + number as T);
  }

  /// [IterableNumPureExtensions.subtractAllBy]
  Iterable<T> subtractAllBy(T number) {
    return map((element) => element - number as T);
  }

  /// [IterableNumPureExtensions.divideAllBy]
  Iterable<Rational> divideAllBy(T number) {
    return map((element) => element / number);
  }

  /// [IterableNumPureExtensions.multiplyAllBy]
  Iterable<T> multiplyAllBy(T number) {
    return map((element) => element * number as T);
  }
}

extension IterableMapEntryPureExtensions<K, V> on Iterable<MapEntry<K, V>> {
  /// Convert the collection of entries into a [Map].
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

extension IterableFuturePureExtensions<T> on Iterable<Future<T>> {
  /// [Future.wait]
  Future<List<T>> waitFutures() => Future.wait(this);

  /// [Future.any]
  Future<T> anyFutures() => Future.any(this);
}
