import 'dart:async';

import 'package:pure_extensions/src/dart/collections/iterators/join_element.dart';
import 'package:pure_extensions/src/dart/collections/iterators/without_null.dart';
import 'package:rational/rational.dart';

extension IterableNullExtensions<T> on Iterable<T?> {
  Iterable<T> withoutNull() => WithoutNullIterable(this);
}

extension IterableExtensions<T> on Iterable<T> {
  /// returns null or if it is empty returns true.
  Iterable<T>? get nullIfEmpty => isEmpty ? null : this;

  /// replace the old elements contained in the map with new ones.
  Iterable<T> replaces(Map<T, T> replacements) {
    return map((item) => replacements[item] ?? item);
  }

  /// Returns a iterable without [badElements]
  Iterable<T> without(Iterable<T> badElements) {
    return where((item) => !badElements.contains(item));
  }

  /// Concatenates the elements given by function.
  Iterable<T> joinBy(T Function(int index) generator) {
    if (length <= 1) {
      return this;
    }
    return JoinElementIterable(this, generator);
  }

  /// Concatenates the elements.
  Iterable<T> joinElement(T element) => joinBy((index) => element);

  T? tryElementAt(int index) {
    try {
      return elementAt(index);
    } on IndexError {
      return null;
    }
  }

  /// Returns the first entry if it exists otherwise null.
  ///
  /// [Iterable.first]
  T? get tryFirst {
    try {
      return first;
    } on StateError {
      return null;
    }
  }

  /// Returns the last entry if it exists otherwise null.
  ///
  /// [Iterable.last]
  T? get tryLast {
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

  Map<int, T> toMap() => toList().asMap();

  Map<int, List<T>> generateBook({int? valuesPerPage, int? numberOfPages}) {
    if (valuesPerPage == null && numberOfPages == null) return {0: this as List<T>};
    valuesPerPage ??= this.length ~/ numberOfPages!;
    var book = <int, List<T>>{};
    int pageCount = 0;
    var list = this;
    while (list.isNotEmpty && (numberOfPages == null || pageCount < numberOfPages)) {
      book[pageCount++] = this.take(valuesPerPage).toList();
      list = list.skip(valuesPerPage);
    }
    return book;
  }

  /// Reduces a collection to a single value by iteratively combining previous and current
  /// element of the collection with an existing value
  V foldWithNext<V>(V initialValue, V Function(V previousValue, T current, T next) combiner) {
    Iterator<T> iterator = this.iterator;
    if (!iterator.moveNext()) {
      throw StateError("No element");
    }
    var value = initialValue;
    T current = iterator.current;
    while (iterator.moveNext()) {
      value = combiner(value, current, iterator.current);
      current = iterator.current;
    }
    return value;
  }
}

extension IterableNumDartExtension<T extends num> on Iterable<T> {
  /// Calculate the sum of all numbers in the collection
  T sumAll() {
    if (isEmpty) return T is double ? 0.0 as T : 0 as T;
    return reduce((previousValue, element) => previousValue + element as T);
  }

  /// Calculate the subtraction of all numbers in the collection
  T subtractAll() {
    if (isEmpty) return T is double ? 0.0 as T : 0 as T;
    return reduce((previousValue, element) => previousValue - element as T);
  }

  /// Calculate the division of all numbers in the collection
  double divideAll() {
    return fold(0.0, (previousValue, element) => previousValue / element);
  }

  /// Calculate the multiplication of all numbers in the collection
  T multiplyAll() {
    if (isEmpty) return T is double ? 0.0 as T : 0 as T;
    return reduce((previousValue, element) => previousValue * element as T);
  }

  /// Sum [number] to all items in the collection
  Iterable<T> sum(T number) {
    return map((element) => element + number as T);
  }

  /// Subtract [number] to all items in the collection
  Iterable<T> subtract(T number) {
    return map((element) => element - number as T);
  }

  /// Divide [number] to all items in the collection
  Iterable<double> divide(T number) {
    return map((element) => element / number);
  }

  /// Multiply [number] to all items in the collection
  Iterable<T> multiply(T number) {
    return map((element) => element * number as T);
  }

  /// Calculate the average of all numbers in the collection
  double average() => sumAll() / length;
}

extension IterableBigIntExtension<T extends BigInt> on Iterable<T> {
  /// [IterableNumDartExtension.sumAll]
  BigInt sumAll() {
    if (isEmpty) return BigInt.zero;
    return reduce((previousValue, element) => previousValue + element as T);
  }

  /// [IterableNumDartExtension.subtractAll]
  BigInt subtractAll() {
    if (isEmpty) return BigInt.zero;
    return reduce((previousValue, element) => previousValue - element as T);
  }

  /// [IterableNumDartExtension.divideAll]
  Rational divideAll() {
    return fold(Rational.zero, (previousValue, element) => previousValue / Rational(element));
  }

  /// [IterableNumDartExtension.multiplyAll]
  BigInt multiplyAll() {
    if (isEmpty) return BigInt.zero;
    return reduce((previousValue, element) => previousValue * element as T);
  }

  /// [IterableNumDartExtension.sum]
  Iterable<T> sum(T number) {
    return map((element) => element + number as T);
  }

  /// [IterableNumDartExtension.subtract]
  Iterable<T> subtract(T number) {
    return map((element) => element - number as T);
  }

  /// [IterableNumDartExtension.divide]
  Iterable<Rational> divide(T number) {
    final rationalNumber = Rational(number);
    return map((element) => Rational(element) / rationalNumber);
  }

  /// [IterableNumDartExtension.multiply]
  Iterable<T> multiply(T number) {
    return map((element) => element * number as T);
  }

  /// [IterableNumDartExtension.average]
  Rational average() => Rational(sumAll()) / Rational(BigInt.from(length));
}

extension IterableRationalExtension<T extends Rational> on Iterable<T> {
  /// [IterableNumDartExtension.sumAll]
  Rational sumAll() {
    if (isEmpty) return Rational.zero;
    return reduce((previousValue, element) => previousValue + element as T);
  }

  /// [IterableNumDartExtension.subtractAll]
  Rational subtractAll() {
    if (isEmpty) return Rational.zero;
    return reduce((previousValue, element) => previousValue - element as T);
  }

  /// [IterableNumDartExtension.divideAll]
  Rational divideAll() {
    return fold(Rational.zero, (previousValue, element) => previousValue / element);
  }

  /// [IterableNumDartExtension.multiplyAll]
  Rational multiplyAll() {
    if (isEmpty) return Rational.zero;
    return reduce((previousValue, element) => previousValue * element as T);
  }

  /// [IterableNumDartExtension.sum]
  Iterable<T> sum(T number) {
    return map((element) => element + number as T);
  }

  /// [IterableNumDartExtension.subtract]
  Iterable<T> subtract(T number) {
    return map((element) => element - number as T);
  }

  /// [IterableNumDartExtension.divide]
  Iterable<Rational> divide(T number) {
    return map((element) => element / number);
  }

  /// [IterableNumDartExtension.multiply]
  Iterable<T> multiply(T number) {
    return map((element) => element * number as T);
  }

  /// [IterableNumDartExtension.average]
  Rational average() => sumAll() / Rational.fromInt(length);
}

extension IterableMapEntryExt<K, V> on Iterable<MapEntry<K, V>> {
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

extension IterableExtFuture<T> on Iterable<Future<T>> {
  /// [Future.wait]
  Future<List<T>> waitFutures() => Future.wait(this);

  /// [Future.any]
  Future<T> anyFutures() => Future.any(this);
}

extension IterableIterableDartExt<T> on Iterable<Iterable<T>> {
  Iterable<T> flat() => expand((element) => element);
}
