import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';

extension BuiltListExt<T> on BuiltList<T> {
  T random({Random? random}) {
    if (random != null) {
      return this[random.nextInt(length)];
    } else {
      return this[DateTime.now().microsecond % length];
    }
  }

  T circleGet(int index) => this[index % length];
}

extension ListBuilderExt<T> on ListBuilder<T> {
  void removeAll(Iterable<T> elements) => elements.forEach(remove);

  void removeWhereNull() => removeWhere((value) => value == null);

  void addOrRemove(bool addOrRemove, T value) {
    if (addOrRemove) {
      add(value);
    } else {
      remove(value!);
    }
  }

  T random(Random random) => this[random.nextInt(length)];

  T circleGet(int index) => this[index % length];
}

extension SetBuilderExt<T> on SetBuilder<T> {
  void removeAll(Iterable<T> elements) => elements.forEach(remove);

  void removeWhereNull() => removeWhere((value) => value == null);

  void addOrRemove(bool addOrRemove, T value) {
    if (addOrRemove) {
      add(value);
    } else {
      remove(value!);
    }
  }
}

extension BuiltMapExt<K, V> on BuiltMap<K, V> {
  /// Returns a value
  V get(K key) => this[key]!;

  /// Returns a value or null if it not exist
  V? getOrNull(K key) => this[key];

  /// returns a List from entries
  Iterable<T> generateIterable<T>(T Function(K key, V value) generator) {
    return entries.map((entry) => generator(entry.key, entry.value));
  }

  /// Returns a new map with all entries that satisfy the predicate [test].
  ///
  /// [Iterable.where]
  BuiltMap<K, V> where(bool Function(K key, V value) predicate) {
    return rebuild((b) => b.removeWhere((key, value) => !predicate(key, value)));
  }

  /// Returns the first entry that satisfies the given predicate [test].
  /// [Iterable.firstWhere]
  MapEntry<K, V> firstWhere(
    bool Function(K key, V value) test, {
    MapEntry<K, V> Function()? orElse,
  }) {
    return entries.firstWhere((entry) => test(entry.key, entry.value), orElse: orElse);
  }

  /// Returns the last entry that satisfies the given predicate [test].
  /// [Iterable.lastWhere]
  MapEntry<K, V> lastWhere(
    bool Function(K key, V value) test, {
    MapEntry<K, V> Function()? orElse,
  }) {
    return entries.lastWhere((entry) => test(entry.key, entry.value), orElse: orElse);
  }

  /// Returns the single element that satisfies [test].
  /// [Iterable.lastWhere]
  MapEntry<K, V> singleWhere(
    bool Function(K key, V value) test, {
    MapEntry<K, V> Function()? orElse,
  }) {
    return entries.singleWhere((entry) => test(entry.key, entry.value), orElse: orElse);
  }

  /// Returns the first entry that satisfies [test] otherwise null.
  /// [Iterable.firstWhere]
  MapEntry<K, V>? firstWhereOrNull(bool Function(K key, V value) test) {
    return entries.firstWhereOrNull((entry) => test(entry.key, entry.value));
  }

  /// Returns the last entry that satisfies [test] otherwise null.
  /// [Iterable.lastWhere]
  MapEntry<K, V>? lastWhereOrNull(bool Function(K key, V value) test) {
    return entries.lastWhereOrNull((entry) => test(entry.key, entry.value));
  }

  /// Returns the single element that satisfies [test].
  /// [Iterable.singleWhere]
  MapEntry<K, V>? singleWhereOrNull(bool Function(K key, V value) test) {
    return entries.singleWhereOrNull((entry) => test(entry.key, entry.value));
  }

  /// Returns the first entry if it exists otherwise null.
  ///
  /// [Iterable.first]
  MapEntry<K, V>? get firstOrNull => entries.firstOrNull;

  /// Returns the last entry if it exists otherwise null.
  ///
  /// [Iterable.last]
  MapEntry<K, V>? get lastOrNull => entries.lastOrNull;

  /// Reduces a map to a single value by iteratively combining entries
  /// of the collection using the provided function.
  ///
  /// [Iterable.reduce]
  MapEntry<K, V> reduce(
    MapEntry<K, V> Function(MapEntry<K, V> value, MapEntry<K, V> entry) combine,
  ) {
    return entries.reduce(combine);
  }

  /// Checks whether every entry of this map satisfies [test].
  ///
  /// [Iterable.every]
  bool every(bool Function(K key, V value) test) {
    return entries.every((entry) => test(entry.key, entry.value));
  }

  /// Checks whether any entry of this map satisfies [test].
  ///
  /// [Iterable.any]
  bool any(bool Function(K key, V value) test) {
    return entries.any((entry) => test(entry.key, entry.value));
  }

  /// Reduces a map to a single value by iteratively combining elements
  /// of the map using the provided function.
  ///
  /// [Iterable.fold]
  T fold<T>(T initialValue, T Function(T previousValue, MapEntry<K, V> entry) combine) {
    return entries.fold(initialValue, combine);
  }
}

extension BuiltMapNullExtensions<K, V> on BuiltMap<K?, V?> {
  /// Returns [BuiltMap] without null keys and values.
  BuiltMap<K, V> whereNotNull() {
    return BuiltMap<K, V>((b) {
      forEach((key, value) {
        if (key != null && value != null) {
          b[key] = value;
        }
      });
    });
  }
}
