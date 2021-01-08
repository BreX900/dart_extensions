## Dart Extensions

Adds several extensions

### Color

Extensions color code we thank "TinyColor"

### String

| Command | Description |
| ------- | ----------- |
| ifEmpty<T>(() => 'text') | if string is empty returns a 'text' otherwise return string |
| isBlank | if string is empty or contains only space returns true otherwise returns false |
| ifBlank(() => 'text') | if string is empty or contains only space returns 'text' otherwise returns string |
more methods... please complete this list...

### num
They are extended with the methods of the 'math' package

### Iterable<T> (BUILT)

| Command | Description |
| ------- | ----------- |
| nullIfEmpty | returns null or if it is empty returns true. |
| replaces | replace the old elements contained in the map with new ones. |
| without | Returns a iterable without bad elements. |
| joinBy | Concatenates the elements given by function. |
| joinElement |  Concatenates the elements. |
| tryFirst | Returns the first element if it exists otherwise null. |
| tryLast | Returns the last element if it exists otherwise null. |
| containsAll | Returns true if the specified value is equal to at least one element. |
| groupBy | Splits a list into sub-lists stored in an object, based on the result. |
| generateMap | Generate the map by collection. |

##### Iterable<MapEntry<K, V>>
| Command | Description |
| --- | --- |
| toMapList | Grouping the results in list according to key. |
| keys | Returns only the keys. |
| values | Returns only the values. |

##### Iterable<Future<T>
| Command | Description |
| --- | --- |
| waitFutures | same as [Future.wait] method |
| anyFutures | same as [Future.any] method |

### Map<K, V> (BUILT)

| Command | Description |
| ------- | ----------- |
| generateIterable<K, V>(T Function(K key, V value) generator) | returns a List from entries |
| where | Returns a new map with all entries that satisfy the predicate [test]. |
| firstWhere | Returns the first entry that satisfies the given predicate [test]. |
| lastWhere | Returns the last entry that satisfies the given predicate [test]. |
| tryFirst | Returns the first entry if it exists otherwise null. |
| tryLast | Returns the last entry if it exists otherwise null. |
| reduce | Reduces a map to a single value by iteratively combining entries. |
| every | Checks whether every entry of this map satisfies [test]. |
| any | Checks whether any entry of this map satisfies [test]. |
| fold | Reduces a map to a single value by iteratively combining entries. |

### DateTime

See time package

| Command | Description |
| ------- | ----------- |
| DateTime.copyWithPosition |  |

### Stream<T>

| Command | Description |
| ------- | ----------- |
| distinctRuntimeType | Stream.distinct] by [T.runtimeType] |
| listenValueChanges | Hear how the specified value changes over time from its previous value |

### Classes

| class | Description |
| --- | --- |
| GeoPoint | Defines a geographical point |
| CompositeMapSubscription | Acts as a map for multiple subscriptions that can be canceled at once |

## Built

| Class | Description |
| --- | --- |
| GeoPointSerializer | Serializer for [GeoPoint] Type |

