import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

extension StreamExtSerializer<T> on Stream<T> {
  Stream<Object> serialize(
    Serializers serializers, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return map((item) => serializers.serialize(item, specifiedType: specifiedType));
  }

  Stream<Object> serializeWith(Serializers serializers, Serializer<T> serializer) {
    return map((item) => serializers.serializeWith(serializer, item));
  }

  Stream<T> deserialize(Serializers serializers, {FullType specifiedType = FullType.unspecified}) {
    return map((item) => serializers.deserialize(item, specifiedType: specifiedType));
  }

  Stream<T> deserializeWith(Serializers serializers, Serializer<T> serializer) {
    return map((item) => serializers.deserializeWith(serializer, item));
  }
}

extension StreamBuiltExtension<T extends Built<T, dynamic>> on Stream<T> {
  Stream<Object> serialize(
    Serializers serializers, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return map((item) => serializers.serialize(item, specifiedType: specifiedType));
  }

  Stream<Object> serializeWith(Serializers serializers, Serializer<T> serializer) {
    return map((item) => serializers.serializeWith(serializer, item));
  }

  Stream<T> deserialize(Serializers serializers, {FullType specifiedType = FullType.unspecified}) {
    return map((item) {
      return serializers.deserialize(item, specifiedType: specifiedType);
    });
  }

  Stream<T> deserializeWith(Serializers serializers, Serializer<T> serializer) {
    return map((item) => serializers.deserializeWith(serializer, item));
  }
}

extension StreamExtSerializersList<T> on Stream<Iterable<T>> {
  Stream<BuiltList<T>> toBuiltList() => map((items) => BuiltList.of(items));

  Stream<Iterable<T>> deserializeIterable(
    Serializers serializers, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return map((items) {
      return items.map((item) {
        return serializers.deserialize(item, specifiedType: specifiedType) as T;
      });
    });
  }

  Stream<Iterable<T>> deserializeIterableWith(Serializers serializers, Serializer<T> serializer) {
    return map((items) {
      return items.map((item) => serializers.deserializeWith(serializer, item));
    });
  }
}
