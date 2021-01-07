import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:pure_extensions/src/dart/collections/internal.dart';

extension MapExtensions<K, V> on Map<K, V> {
  Iterable<T> generateIterable<T>(T Function(K key, V value) generator) =>
      MapUtility.generateIterable(entries, generator);

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

  bool every(bool test(K key, V value)) => MapUtility.every(entries, test);

  bool any(bool test(K key, V value)) => MapUtility.any(entries, test);

  K getKeyAfter(K key, [int after = 1]) => MapUtility.getElementAfter(keys, key, after);

  K getKeyBefore(K key, [int before = 1]) => MapUtility.getElementBefore(keys, key, before);

  MapEntry<K, V> firstWhere(
    bool Function(K key, V value) test, {
    MapEntry<K, V> Function() orElse,
  }) {
    return entries.firstWhere((e) => test(e.key, e.value), orElse: orElse);
  }
}

extension OrderMapExt<K extends num, V> on Map<K, V> {
  @visibleForTesting
  Iterable<MapEntry<K, V>> whereKeyIs({K less, K equals, K great}) {
    final newList = <MapEntry<K, V>>[];
    for (var entry in entries) {
      if (less != null && entry.key < less) newList.add(entry);
      if (less != null && entry.key == equals) newList.add(entry);
      if (great != null && entry.key > great) newList.add(entry);
    }
    return newList;
  }
}
