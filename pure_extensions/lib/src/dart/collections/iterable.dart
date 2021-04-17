import 'dart:async';
import 'dart:math';

import 'package:pure_extensions/src/dart/primitives/geo_point.dart';
import 'package:rational/rational.dart';

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

  T tryElementAt(int index) {
    try {
      return elementAt(index);
    } on IndexError {
      return null;
    }
  }

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

  Map<int, T> toMap() => toList().asMap();

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

extension IterableNumDartExtension<T extends num> on Iterable<T> {
  /// Calculate the sum of all numbers in the collection
  T sumAll() {
    if (isEmpty) return T is double ? 0.0 : 0;
    return reduce((previousValue, element) => previousValue + element);
  }

  /// Calculate the subtraction of all numbers in the collection
  T subtractAll() {
    if (isEmpty) return T is double ? 0.0 : 0;
    return reduce((previousValue, element) => previousValue - element);
  }

  /// Calculate the division of all numbers in the collection
  double divideAll() {
    return fold(0.0, (previousValue, element) => previousValue / element);
  }

  /// Calculate the multiplication of all numbers in the collection
  T multiplyAll() {
    if (isEmpty) return T is double ? 0.0 : 0;
    return reduce((previousValue, element) => previousValue * element);
  }

  /// Sum [number] to all items in the collection
  Iterable<T> sum(T number) {
    return map((element) => element + number);
  }

  /// Subtract [number] to all items in the collection
  Iterable<T> subtract(T number) {
    return map((element) => element - number);
  }

  /// Divide [number] to all items in the collection
  Iterable<double> divide(T number) {
    return map((element) => element / number);
  }

  /// Multiply [number] to all items in the collection
  Iterable<T> multiply(T number) {
    return map((element) => element * number);
  }

  /// Calculate the average of all numbers in the collection
  double average() => sumAll() / length;
}

extension IterableBigIntExtension<T extends BigInt> on Iterable<T> {
  /// [IterableNumDartExtension.sumAll]
  BigInt sumAll() {
    if (isEmpty) return BigInt.zero;
    return reduce((previousValue, element) => previousValue + element);
  }

  /// [IterableNumDartExtension.subtractAll]
  BigInt subtractAll() {
    if (isEmpty) return BigInt.zero;
    return reduce((previousValue, element) => previousValue - element);
  }

  /// [IterableNumDartExtension.divideAll]
  Rational divideAll() {
    return fold(Rational.zero, (previousValue, element) => previousValue / Rational(element));
  }

  /// [IterableNumDartExtension.multiplyAll]
  BigInt multiplyAll() {
    if (isEmpty) return BigInt.zero;
    return reduce((previousValue, element) => previousValue * element);
  }

  /// [IterableNumDartExtension.sum]
  Iterable<T> sum(T number) {
    return map((element) => element + number);
  }

  /// [IterableNumDartExtension.subtract]
  Iterable<T> subtract(T number) {
    return map((element) => element - number);
  }

  /// [IterableNumDartExtension.divide]
  Iterable<Rational> divide(T number) {
    final rationalNumber = Rational(number);
    return map((element) => Rational(element) / rationalNumber);
  }

  /// [IterableNumDartExtension.multiply]
  Iterable<T> multiply(T number) {
    return map((element) => element * number);
  }

  /// [IterableNumDartExtension.average]
  Rational average() => Rational(sumAll()) / Rational(BigInt.from(length));
}

extension IterableRationalExtension<T extends Rational> on Iterable<T> {
  /// [IterableNumDartExtension.sumAll]
  Rational sumAll() {
    if (isEmpty) return Rational.zero;
    return reduce((previousValue, element) => previousValue + element);
  }

  /// [IterableNumDartExtension.subtractAll]
  Rational subtractAll() {
    if (isEmpty) return Rational.zero;
    return reduce((previousValue, element) => previousValue - element);
  }

  /// [IterableNumDartExtension.divideAll]
  Rational divideAll() {
    return fold(Rational.zero, (previousValue, element) => previousValue / element);
  }

  /// [IterableNumDartExtension.multiplyAll]
  Rational multiplyAll() {
    if (isEmpty) return Rational.zero;
    return reduce((previousValue, element) => previousValue * element);
  }

  /// [IterableNumDartExtension.sum]
  Iterable<T> sum(T number) {
    return map((element) => element + number);
  }

  /// [IterableNumDartExtension.subtract]
  Iterable<T> subtract(T number) {
    return map((element) => element - number);
  }

  /// [IterableNumDartExtension.divide]
  Iterable<Rational> divide(T number) {
    return map((element) => element / number);
  }

  /// [IterableNumDartExtension.multiply]
  Iterable<T> multiply(T number) {
    return map((element) => element * number);
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

extension IterableGeoPointDartExtension on Iterable<GeoPoint> {
  /// Calculate a center.
  GeoPoint center() {
    final eb = this.externalBounds();
    final p = eb.northeast + eb.southwest;
    return GeoPoint(p.latitude / 2, p.longitude / 2);
  }

  /// Calculate the northeast corner.
  GeoPoint northeast() {
    return reduce((p, c) {
      return GeoPoint(max(p.latitude, c.latitude), max(p.longitude, c.longitude));
    });
  }

  /// Calculate the southwest corner.
  GeoPoint southwest() {
    return reduce((p, c) {
      return GeoPoint(min(p.latitude, c.latitude), min(p.longitude, c.longitude));
    });
  }

  /// Calculate the internal corners.
  GeoBounds internalBounds({GeoPoint center}) {
    center ??= this.center();
    return GeoBounds(
      northeast: where((p) => p >= center).southwest(),
      southwest: where((p) => p <= center).northeast(),
    );
  }

  /// Calculate the external corners.
  GeoBounds externalBounds() {
    return GeoBounds(
      northeast: northeast(),
      southwest: southwest(),
    );
  }
}

extension IterableIterableDartExt<T> on Iterable<Iterable<T>> {
  Iterable<T> flat() => expand((element) => element);
}
