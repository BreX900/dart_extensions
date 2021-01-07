import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:pure_extensions/src/dart/collections/internal.dart';

extension BuiltListExt<T> on BuiltList<T> {
  T random({Random random}) {
    if (random != null) {
      return this[random.nextInt(length)];
    } else {
      return this[DateTime.now().microsecond % length];
    }
  }

  T circleGet(int index) => this[index % length];
}

extension ListBuilderExt<T> on ListBuilder<T> {
  void removeWhereNull() => removeWhere((value) => value == null);

  void addOrRemove(bool addOrRemove, T value) {
    if (addOrRemove) {
      add(value);
    } else {
      remove(value);
    }
  }

  T random(Random random) => this[random.nextInt(length)];

  T circleGet(int index) => this[index % length];
}

extension SetBuilderExt<T> on SetBuilder<T> {
  void removeWhereNull() => removeWhere((value) => value == null);

  void addOrRemove(bool addOrRemove, T value) {
    if (addOrRemove) {
      add(value);
    } else {
      remove(value);
    }
  }
}

extension BuiltMapExt<K, V> on BuiltMap<K, V> {
  Iterable<T> generateIterable<T>(T Function(K key, V value) generator) =>
      MapUtility.generateIterable(entries, generator);

  /// Checks whether every entry of this map satisfies [test].
  ///
  /// [Iterable.every]
  bool every(bool Function(K key, V value) test) => MapUtility.every(entries, test);

  /// Checks whether any entry of this map satisfies [test].
  ///
  /// [Iterable.any]
  bool any(bool Function(K key, V value) test) => MapUtility.any(entries, test);

  /// Returns a new map with all entries that satisfy the predicate [test].
  ///
  /// [Iterable.where]
  BuiltMap<K, V> where(bool Function(K, V) predicate) {
    return (toBuilder()..removeWhere(predicate)).build();
  }

  /// Returns the first entry that satisfies the given predicate [test].
  ///
  /// [Iterable.firstWhere]
  MapEntry<K, V> firstWhere(
    bool Function(K key, V value) test, {
    MapEntry<K, V> Function() orElse,
  }) {
    return entries.firstWhere((entry) => test(entry.key, entry.value), orElse: orElse);
  }

  /// Returns the last entry that satisfies the given predicate [test].
  ///
  /// [Iterable.lastWhere]
  MapEntry<K, V> lastWhere(
    bool Function(K key, V value) test, {
    MapEntry<K, V> Function() orElse,
  }) {
    return entries.lastWhere((entry) => test(entry.key, entry.value), orElse: orElse);
  }
}

extension MapBuilderExt<K, V> on MapBuilder<K, V> {
  void removeNullValues() => removeWhere((key, value) => value == null);
}
