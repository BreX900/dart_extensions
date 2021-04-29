import 'package:built_value/serializer.dart';

extension SerializersDartExtensions on Serializers {
  /// Serialize the collection of objects.
  Iterable<Object?> serializeAll(
    Object object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return (object as Iterable<Object>)
        .map((object) => serialize(object, specifiedType: specifiedType));
  }

  /// Serialize the collection of objects using [Serializer].
  Iterable<Object?> serializeAllWith<T>(
    Serializer<T> serializer,
    Object object,
  ) {
    return (object as Iterable<Object>).map((object) => serializeWith<T>(serializer, object as T));
  }

  /// Deserialize the collection of objects.
  Iterable<T?> deserializeAll<T extends Object>(
    Object object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return (object as Iterable<Object?>)
        .map((object) => deserialize(object, specifiedType: specifiedType) as T);
  }

  /// Deserialize the collection of objects using [Serializer].
  Iterable<T?> deserializeAllWith<T extends Object>(
    Serializer<T> serializer,
    Object object,
  ) {
    return (object as Iterable<Object?>).map((object) => deserializeWith<T>(serializer, object));
  }
}
