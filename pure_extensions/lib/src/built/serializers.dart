import 'package:built_value/serializer.dart';

extension SerializersDartExtensions on Serializers {
  /// Serialize the collection of objects.
  Iterable<Object> serializeAll(
    Iterable<Object> iterable, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return iterable.map((object) => serialize(object, specifiedType: specifiedType));
  }

  /// Serialize the collection of objects using [Serializer].
  Iterable<Object> serializeAllWith<T>(
    Serializer<T> serializer,
    Iterable<T> iterable,
  ) {
    return iterable.map((object) => serializeWith<T>(serializer, object));
  }

  /// Deserialize the collection of objects.
  Iterable<T> deserializeAll<T extends Object>(
    Iterable<Object> iterable, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return iterable.map((object) => deserialize(object, specifiedType: specifiedType) as T);
  }

  /// Deserialize the collection of objects using [Serializer].
  Iterable<T> deserializeAllWith<T extends Object>(
    Serializer<T> serializer,
    Iterable<Object> iterable,
  ) {
    return iterable.map((object) => deserializeWith<T>(serializer, object));
  }
}
