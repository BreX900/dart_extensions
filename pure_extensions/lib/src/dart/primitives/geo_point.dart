import 'dart:math';

import 'package:pure_extensions/src/dart/primitives/numbers.dart';

/// Defines a geographical point
class GeoPoint {
  final double latitude;
  final double longitude;

  const GeoPoint(this.latitude, this.longitude);

  static const double earthRadius = 6371000.0;

  double distance(GeoPoint other, {double radius = GeoPoint.earthRadius}) {
    final sDLat = sin((other.latitude.toRad() - latitude.toRad()) / 2);
    final sDLng = sin((other.longitude.toRad() - longitude.toRad()) / 2);
    final a = sDLat * sDLat + sDLng * sDLng * cos(latitude.toRad()) * cos(other.latitude.toRad());
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return radius * c;
  }

  bool operator >(GeoPoint other) {
    if (latitude > other.latitude && longitude > other.longitude) return true;
    return latitude - other.latitude + longitude - other.longitude > 0;
  }

  bool operator <(GeoPoint other) {
    if (latitude < other.latitude && longitude < other.longitude) return true;
    return latitude - other.latitude + longitude - other.longitude < 0;
  }

  bool operator >=(GeoPoint other) {
    if (latitude >= other.latitude && longitude >= other.longitude) return true;
    return latitude - other.latitude + longitude - other.longitude >= 0;
  }

  bool operator <=(GeoPoint other) {
    if (latitude <= other.latitude && longitude <= other.longitude) return true;
    return latitude - other.latitude + longitude - other.longitude <= 0;
  }

  GeoPoint operator +(GeoPoint other) {
    return GeoPoint(latitude + other.latitude, longitude + other.longitude);
  }

  GeoPoint operator -(GeoPoint other) {
    return GeoPoint(latitude - other.latitude, longitude - other.longitude);
  }

  GeoPoint copyWith({double? latitude, double? longitude}) {
    return GeoPoint(latitude ?? this.latitude, longitude ?? this.longitude);
  }

  factory GeoPoint.fromMap(Map<String, dynamic> map) {
    return GeoPoint(map['latitude'] as double, map['longitude'] as double);
  }

  Map<String, double> toMap() {
    return {'latitude': this.latitude, 'longitude': this.longitude};
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GeoPoint &&
            runtimeType == other.runtimeType &&
            latitude == other.latitude &&
            longitude == other.longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() {
    return 'GeoPoint{latitude: $latitude, longitude: $longitude}';
  }
}

/// A latitude/longitude aligned rectangle.
class GeoBounds {
  final GeoPoint northeast;
  final GeoPoint southwest;

  const GeoBounds({required this.northeast, required this.southwest});

  /// Returns whether this rectangle contains the given [LatLng].
  bool contains(GeoPoint point) {
    return _containsLatitude(point.latitude) && _containsLongitude(point.longitude);
  }

  bool _containsLatitude(double lat) {
    return (southwest.latitude <= lat) && (lat <= northeast.latitude);
  }

  bool _containsLongitude(double lng) {
    if (southwest.longitude <= northeast.longitude) {
      return southwest.longitude <= lng && lng <= northeast.longitude;
    } else {
      return southwest.longitude <= lng || lng <= northeast.longitude;
    }
  }

  List<GeoPoint> toList() => [northeast, southwest];

  GeoBounds copyWith({GeoPoint? northeast, GeoPoint? southwest}) {
    return GeoBounds(
      northeast: northeast ?? this.northeast,
      southwest: southwest ?? this.southwest,
    );
  }

  factory GeoBounds.fromMap(Map<String, dynamic> map) {
    return GeoBounds(
      northeast: GeoPoint.fromMap(map['northeast']),
      southwest: GeoPoint.fromMap(map['southwest']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'northeast': this.northeast.toMap(),
      'southwest': this.southwest.toMap(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeoBounds &&
          runtimeType == other.runtimeType &&
          northeast == other.northeast &&
          southwest == other.southwest;

  @override
  int get hashCode => northeast.hashCode ^ southwest.hashCode;

  @override
  String toString() {
    return 'GeoBounds{northeast: $northeast, southwest: $southwest}';
  }
}
