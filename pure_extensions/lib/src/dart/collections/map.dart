import 'dart:convert';

extension MapExtensions<K, V> on Map<K, V> {
  void removeNullValues() => removeWhere((key, value) => value == null);

  String encodeToString() => jsonEncode(this);

  Iterable<dynamic> serialize() {
    final list = <dynamic>[]..length = length * 2;
    var i = 0;
    for (var entry in entries) {
      list[i++] = entry.value;
      list[i++] = entry.key;
    }
    return list;
  }

  /// returns a List from entries
  Iterable<T> generateIterable<T>(T Function(K key, V value) generator) {
    return entries.map((entry) => generator(entry.key, entry.value));
  }

  /// Returns a new map with all entries that satisfy the predicate [test].
  ///
  /// [Iterable.where]
  Map<K, V> where(bool Function(K key, V value) predicate) {
    return Map.fromEntries(entries.where((entry) => predicate(entry.key, entry.value)));
  }

  /// Returns the first entry that satisfies the given predicate [test].
  ///
  /// [Iterable.firstWhere]
  MapEntry<K, V> firstWhere(
    bool Function(K key, V value) test, {
    MapEntry<K, V> Function()? orElse,
  }) {
    return entries.firstWhere((entry) => test(entry.key, entry.value), orElse: orElse);
  }

  /// Returns the last entry that satisfies the given predicate [test].
  ///
  /// [Iterable.lastWhere]
  MapEntry<K, V> lastWhere(
    bool Function(K key, V value) test, {
    MapEntry<K, V> Function()? orElse,
  }) {
    return entries.lastWhere((entry) => test(entry.key, entry.value), orElse: orElse);
  }

  /// Returns the first entry if it exists otherwise null.
  ///
  /// [Iterable.first]
  MapEntry<K, V>? get tryFirst {
    Iterator<MapEntry<K, V>> it = entries.iterator;
    if (!it.moveNext()) {
      return null;
    }
    return it.current;
  }

  /// Returns the last entry if it exists otherwise null.
  ///
  /// [Iterable.last]
  MapEntry<K, V>? get tryLast {
    MapEntry<K, V>? result;
    for (final entry in entries) {
      result = entry;
    }
    return result;
  }

  /// Reduces a map to a single value by iteratively combining entries
  /// of the collection using the provided function.
  ///
  /// [Iterable.reduce]
  MapEntry<K, V> reduce(MapEntry<K, V> combine(MapEntry<K, V> value, MapEntry<K, V> entry)) {
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
  T fold<T>(T initialValue, T combine(T previousValue, MapEntry<K, V> entry)) {
    return entries.fold(initialValue, combine);
  }
}
