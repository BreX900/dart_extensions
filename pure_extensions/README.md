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

### num
They are extended with the methods of the 'math' package

### Iterable<T>

| Command | Description |
| ------- | ----------- |
| tryFirstWhereType<T>() | returns a first element where type is T else null |
| separate(int Function(T) separator) | returns a `SeparatedResult` separated by separator |
| separateByContains(Iterable<T> iterable) | returns a `SeparatedResult` separated by an iterable via contains method  |
| List<T> expandByIterable(Iterable<T> another) | returns the two iterable joined | 

##### Iterable<MapEntry<K, V>>
| Command | Result | Description |
| toBuiltMapList() | Map<K, List<V>> | groups values by key |

### Map<K, V> - BuiltMap<K, V>

| Command | Description |
| ------- | ----------- |
| generateIterable<K, V>(T Function(K key, V value) generator) | return List of MapEntry<K, V> |
| every<K, V>(bool test(K key, V value)) |  |
| any<K, V>(bool test(K key, V value)) |  |

### DateTime

| Command | Description |
| ------- | ----------- |
| DateTime.copyWith | |
| DateTime.copyWithPosition |  |

## Built

### BuiltMap<K, V>

| Methods | Docs |
| --- | --- |
| every | Checks whether every entry of this map satisfies [test]. |
| any | Checks whether any entry of this map satisfies [test]. |
| where | Returns a new map with all entries that satisfy the predicate [test]. |
| firstWhere | Returns the first entry that satisfies the given predicate [test]. |
| lastWhere | Returns the last entry that satisfies the given predicate [test]. |