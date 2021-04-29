import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pure_extensions/src/built/uri.dart';

part 'my_custom_uri.g.dart';

@BuiltValue()
abstract class MyCustomQuery implements Built<MyCustomQuery, MyCustomQueryBuilder> {
  static Serializer<MyCustomQuery> get serializer => _$myCustomQuerySerializer;

  MyCustomQuery._();

  factory MyCustomQuery([void Function(MyCustomQueryBuilder b)? updates]) = _$MyCustomQuery;

  String? get string;
  int? get integer;
  BuiltList<String>? get stringList;
  BuiltList<int>? get intList;
}

@BuiltValue()
abstract class MyCustomUri implements Built<MyCustomUri, MyCustomUriBuilder>, CustomUriRule {
  static Serializer<MyCustomUri> get serializer => _$myCustomUriSerializer;

  MyCustomUri._();

  MyCustomQuery? get queryParameters;

  factory MyCustomUri([void Function(MyCustomUriBuilder b)? updates]) = _$MyCustomUri;
}

@SerializersFor([
  MyCustomUri,
])
final Serializers serializers = _$serializers;
