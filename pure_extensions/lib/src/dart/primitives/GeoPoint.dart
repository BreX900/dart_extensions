/// Defines a geographical point
class GeoPoint {
  final double latitude;
  final double longitude;

  const GeoPoint(this.latitude, this.longitude)
      : assert(latitude != null),
        assert(longitude != null);

  GeoPoint copyWith({double latitude, double longitude}) {
    return GeoPoint(
      latitude ?? this.latitude,
      longitude ?? this.longitude,
    );
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
  String toString() => 'GeoPoint(latitude:$latitude,longitude:$longitude)';
}
