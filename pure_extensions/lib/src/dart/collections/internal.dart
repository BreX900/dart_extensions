abstract class MapUtility {
  static Iterable<T> generateIterable<K, V, T>(
      Iterable<MapEntry<K, V>> entries, T Function(K key, V value) generator) {
    return entries.map((entry) => generator(entry.key, entry.value));
  }

  static bool every<K, V>(Iterable<MapEntry<K, V>> entries, bool test(K key, V value)) {
    for (var entry in entries) {
      if (!test(entry.key, entry.value)) return false;
    }
    return true;
  }

  static bool any<K, V>(Iterable<MapEntry<K, V>> entries, bool test(K key, V value)) {
    for (var entry in entries) {
      if (test(entry.key, entry.value)) return true;
    }
    return false;
  }

  static T getElementAfter<T>(Iterable<T> elements, T element, [int after = 1]) {
    final iterator = elements.iterator;
    while (iterator.moveNext() && iterator.current != element) {}
    while (iterator.moveNext()) {
      if (--after <= 0) return iterator.current;
    }
    return null;
  }

  static T getElementBefore<T>(Iterable<T> elements, T element, [int before = 1]) {
    final findIterator = elements.iterator;
    final iterator = elements.iterator;

    while (--before > 0 && findIterator.moveNext()) {}
    while (findIterator.moveNext()) {
      if (findIterator.current == element) return iterator.current;
      iterator.moveNext();
    }
    return null;
  }
}
