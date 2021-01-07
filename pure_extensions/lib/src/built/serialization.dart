import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

extension ListBuiltExtension<T> on Iterable<T> {
  BuiltList<T> deserialize<T extends Object>(Serializers serializers,
      {FullType specifiedType}) {
    return map((map) {
      return serializers.deserialize(map, specifiedType: specifiedType) as T;
    }).toBuiltList();
  }

  BuiltList<T> deserializeWith<T extends Object>(
      Serializers serializers, Serializer<T> serializer) {
    return map((map) {
      return serializers.deserializeWith(serializer, map);
    }).toBuiltList();
  }
}

extension BuiltListExtension<T> on BuiltList<T> {
  List<Object> serialize(Serializers serializers, {FullType specifiedType}) {
    return map((map) {
      return serializers.serialize(map, specifiedType: specifiedType);
    }).toList();
  }

  BuiltList<T> serializeWith<T extends Object>(
      Serializers serializers, Serializer<T> serializer) {
    return map((map) {
      return serializers.serializeWith(serializer, map);
    }).toBuiltList();
  }
}
