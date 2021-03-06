import 'package:built_collection/built_collection.dart';

extension IterableBuiltExtensions<T> on Iterable<T> {
  /// Splits a list into sub-lists stored in an object, based on the result of calling a
  /// function on each element, and grouping the results according to values returned.
  BuiltMap<K, BuiltList<T>> builtGroupBy<K>(K Function(T element) fn) {
    return map((e) => MapEntry(fn(e), e)).toBuiltMapList();
  }

  BuiltMap<int, BuiltList<T>> generateBuiltBook({int? valuesPerPage, int? numberOfPages}) {
    if (valuesPerPage == null && numberOfPages == null) return BuiltMap.of({0: this as BuiltList<T>});
    valuesPerPage ??= this.length ~/ numberOfPages!;
    var book = MapBuilder<int, BuiltList<T>>();
    int pageCount = 0;
    var list = this;
    while (list.isNotEmpty && (numberOfPages == null || pageCount < numberOfPages)) {
      book[pageCount++] = BuiltList.of(list.take(valuesPerPage));
      list = list.skip(valuesPerPage);
    }
    return book.build();
  }
}

extension MapEntriesBuiltExtensions<K, V> on Iterable<MapEntry<K, V>> {
  /// Convert the collection of entries into a [BuiltMap]
  BuiltMap<K, V> toBuiltMap() => Map.fromEntries(this).build();

  /// Grouping the results in list according to key.
  BuiltMap<K, BuiltList<V>> toBuiltMapList() {
    final map = <K, ListBuilder<V>>{};
    for (var entry in this) {
      map.putIfAbsent(entry.key, () => ListBuilder<V>()).add(entry.value);
    }
    return map.map((key, value) => MapEntry(key, value.build())).build();
  }
}
