# **Dart Extensions**

Adds several extensions

| class | Description |
| ----- | ----------- |
| GeoPoint | Defines a geographical point. |
| GeoBounds | A latitude/longitude aligned rectangle. |
| CompositeMapSubscription | Acts as a map for multiple subscriptions that can be canceled at once. |
| ReadableFile | Implement a multi platform interface to be able to read a file. |
| DurationBuilder | Builder for [Duration] |
| DateTimeBuilder | Builder for [DateTime] |
| UriBuilder | Builder for [Uri] |


### - **Color**

Extensions color code we thank "TinyColor"


### - **String**
See [recase](https://pub.dev/packages/recase) for many other extensions

| Command | Description |
| ------- | ----------- |
| ifEmpty<T>(() => 'text') | if string is empty returns a 'text' otherwise return string |
| isBlank | if string is empty or contains only space returns true otherwise returns false |
| ifBlank(() => 'text') | if string is empty or contains only space returns 'text' otherwise returns string |
more methods... please complete this list...


### - **num**
They are extended with the methods of the 'math' package


### - **Iterable< T > (BUILT)**
See [collection](https://pub.dev/packages/collection) for many others extensions

| Command | Description |
| ------- | ----------- |
| nullIfEmpty | returns null or if it is empty returns true. |
| replaces | replace the old elements contained in the map with new ones. |
| whereNotContains | Returns a iterable without bad elements. |
| joinBy  | Concatenates the elements given by function. |
| joinElement |  Concatenates the elements. |
| containsAll | Returns true if the specified value is equal to at least one element. |
| groupBy | Splits a list into sub-lists stored in an object, based on the result. |
| generateMap | Generate the map by collection. |


##### - **Iterable< num/int/double/BigInt/Rational >**
See [collection](https://pub.dev/packages/collection) for many others extensions

| Command | Description |
| ------- | ----------- |
| sum  | Calculate the sum of all numbers in the collection |
| average | Calculate the average of all numbers in the collection |
| subtract | Calculate the subtraction of all numbers in the collection |
| divide | Calculate the division of all numbers in the collection |
| multiply | Calculate the multiplication of all numbers in the collection |
| sumAllBy     | Sum [number] to all items in the collection |
| subtractAllBy | Subtract [number] to all items in the collection |
| divideAllBy  | Divide [number] to all items in the collection |
| multiplyAllBy | Multiply [number] to all items in the collection |


##### - **Iterable< MapEntry< K, V > > (BUILT)**

| Command | Description |
| ------- | ----------- |
| toMap   | Convert the collection of entries into a [Map]. |
| toMapList | Grouping the results in list according to key. |
| keys    | Returns only the keys. |
| values  | Returns only the values. |


##### - **Iterable< Future< T > >**
  
| Command | Description |
| ------- | ----------- |
| waitFutures | same as [Future.wait] method |
| anyFutures | same as [Future.any] method |


##### - **Iterable< GeoPoint >**
  
| Command | Description |
| ------- | ----------- |
| center  | Calculate a center. |
| northeast | Calculate the northeast corner. |
| southwest | Calculate the southwest corner. |
| internalBounds | Calculate the internal corners. |
| externalBounds | Calculate the external corners. |


### - **Map< K, V > (BUILT)**

| Command | Description |
| ------- | ----------- |
| whereNotNull | Returns [Map] without null keys and values. |
| generateIterable<K, V>(T Function(K key, V value) generator) | returns a List from entries |
| where   | Returns a new map with all entries that satisfy [test]. |
| firstWhere | Returns the first entry that satisfies [test]. |
| lastWhere | Returns the last entry that satisfies [test]. |
| singleWhere | Returns the single element that satisfies [test]. |
| firstOrNull | Returns the first entry if it exists otherwise null. |
| lastOrNull | Returns the last entry if it exists otherwise null. |
| singleOrNull | Returns the single entry if it exists otherwise null. |
| reduce  | Reduces a map to a single value by iteratively combining entries. |
| every   | Checks whether every entry of this map satisfies [test]. |
| any     | Checks whether any entry of this map satisfies [test]. |
| fold    | Reduces a map to a single value by iteratively combining entries. |


### - **DateTime** (DateTimeBuilder)
See [time](https://pub.dev/packages/time) for many others extensions

| Command | Description
| ------- | -----------
| DateTime.copyWithPosition | 


### - **Duration** (DurationBuilder)
See [time](https://pub.dev/packages/time) for many others extensions

| Command | Description
| ------- | -----------
| days    | Human days representation (0 -> ...)
| hours   | Human hours representation (0 -> 24)
| minutes | Human minutes representation (0 -> 59)
| seconds | Human seconds representation (0 -> 59)
| milliseconds | Human milliseconds representation (0 -> 999)
| microseconds | Human microseconds representation (0 -> 999)
| copyWith | Copy this with new values
| toBuilder | Converts this in builder
| rebuild | Update this by [DurationBuilder]


### - **Stream< T >**

| Command | Description |
| ------- | ----------- |
| asStream | returns itself with the [Stream] type. |
| asBroadcast | returns a broadcast stream without wrapping it unnecessarily. |
| onTrackedErrorResume | It is similar to [Rx.OnErrorExtensions.onErrorResume] but with [StackTrace]. |
| onTrackedErrorReturnWith | It is similar to [Rx.OnErrorExtensions.onErrorReturnWith] but with [StackTrace]. |
| distinctRuntimeType | Stream.distinct] by [T.runtimeType]. |
| distinctRuntimeType | Stream.distinct] by [T.runtimeType]. |
| listenValueChanges | Hear how the specified value changes over time from its previous value. |


## **Built**

| Class | Description |
| ----- | ----------- |
| GeoPointSerializer | Serializer for [GeoPoint] Type |
| RationalSerializer | Serializer for the [Rational] type |
| ByPassSerializer | Serializer that does not serialize and deserialize the specified type [T] |

#### - Serializers

| Command | Description |
| ------- | ----------- |
| serializeAll | Serialize the collection of objects |
| serializeAllWith | Serialize the collection of objects using [Serializer]. |
| deserializeAll | Deserialize the collection of objects. |
| deserializeAllWith | Deserialize the collection of objects using [Serializer]. |
