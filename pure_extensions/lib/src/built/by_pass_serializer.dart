import 'package:built_value/serializer.dart';

/// Serializer that does not serialize and deserialize the specified type [T]
class ByPassSerializer<T> extends PrimitiveSerializer<T> {
  @override
  final Iterable<Type> types = [T];

  @override
  final String wireName = '$T';

  @override
  Object serialize(
    Serializers serializers,
    T object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return object!;
  }

  @override
  T deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serialized as T;
  }
}
