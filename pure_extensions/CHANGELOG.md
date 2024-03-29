# CHANGELOG

## 5.0.0
- Removed export of packages: time, recase, collection
- Removed export of extensions: path, built_value, built_collection

## 4.2.0
- Update dart to ´2.17.0´ and fix lints
- Update dependencies

## 4.1.1
- Fixed `whereNotNull` extension in Stream

## 4.1.0
- Added `containsAny`, `containsEvery` on Iterable
- Added `get`, `getOrNull` on Map/BuiltMap
- Upgrade `Rational` dependency to `^2.0.0`

## 4.0.2
- Rename extensions
- More improvements

## 4.0.0
- Removed deprecated methods
- Now the collection library for iterable extensions is exported

## 3.4.1
- Update rxdart dependency

## 3.4.0
- Added `mapWithIndex` on Iterable

## 3.3.0
- Added `trySingleWhere` on Iterable
- Added `singleWhere`, `tryFirstWhere`, `tryLastWhere`, `trySingleWhere` on Map/BuiltMap
- Added `whereNotNull` on Map/BuiltMap

## 3.2.0
- Added `Future.delayed` and `Future.unawaited`
- Update dependencies
- Added `Iterable.foldWithNext`

## 3.1.0
- Update dependencies
- Added `RationalSerializer` for decimal, int, double

## 3.0.0
- Migrate to null-safety
- added `withoutNull` in nullable iterable

## 2.1.2
- Added `asStream` and `asBroadcast`
- Added `onTrackedErrorResume` and `onTrackedErrorReturnWith`

## 2.1.1
- Added `CustomUriBuilder` for parsing uri in built value
- Added on `Iterable` methods: `toMap`, `tryElementAt`
- Added `List.removeAll`
- Removed `ReadableFile` in favour of `XFile` in `cross_file` package

## 2.1.0
- Added on `String` methods: `toNum`, `toInt`, `toDouble`, `toUri` with try and without
- Added `Uri` extensions and `UriBuilder`
- Added `DateTime` extensions and `DateTimeBuilder`
- Removed `tinyColor` dependency and extension
- Removed all `dart:ui` import

## 2.0.3
- Added more extension for `Duration` (human extensions, copyWith, built)
- Added `DurationBuilder` for build `Duration`

## 2.0.2
- Export `GeoPoint`

## 2.0.1
- Added `ByPassSerializer` and `LocaleSerializer`

## 2.0.0
- Separate the dart language extensions from the flutter_extensions package
