import 'package:built_value/serializer.dart';
import 'package:pure_extensions/src/dart/primitives/geo_point.dart';

/// Serializer for [GeoPoint] Type
class GeoPointSerializer implements StructuredSerializer<GeoPoint> {
  @override
  final Iterable<Type> types = const [GeoPoint];
  @override
  final String wireName = 'GeoPoint';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GeoPoint object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'latitude',
      serializers.serialize(object.latitude, specifiedType: const FullType(double)),
      'longitude',
      serializers.serialize(object.longitude, specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  GeoPoint deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    late double latitude;
    late double longitude;

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String?;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'latitude':
          latitude =
              serializers.deserialize(value, specifiedType: const FullType(double)) as double;
          break;
        case 'longitude':
          longitude =
              serializers.deserialize(value, specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return GeoPoint(latitude, longitude);
  }
}
