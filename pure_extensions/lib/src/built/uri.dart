import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pure_extensions/src/built/raw_serializer.dart';
import 'package:pure_extensions/src/dart/primitives/uri.dart';

part 'uri.g.dart';

/// @Example
/// abstract class MyCustomQuery implements Built<MyCustomQuery, MyCustomQueryBuilder> {
///   static Serializer<MyCustomQuery> get serializer => _$myCustomQuerySerializer;
///
///   MyCustomQuery._();
///
///   factory MyCustomQuery([void Function(MyCustomQueryBuilder b) updates]) = _$MyCustomQuery;
///
///   String get string;
///   int get integer;
///   BuiltList<String> get stringList;
///   BuiltList<int> get intList;
/// }
///
/// @BuiltValue()
/// abstract class MyCustomUri implements Built<MyCustomUri, MyCustomUriBuilder>, CustomUriRule {
///   static Serializer<MyCustomUri> get serializer => _$myCustomUriSerializer;
///
///   MyCustomUri._();
///
///   MyCustomQuery get queryParameters;
///
///   factory MyCustomUri([void Function(MyCustomUriBuilder b) updates]) = _$MyCustomUri;
/// }
abstract class CustomUriRule {
  /// [Uri.scheme]
  String? get scheme;

  /// [Uri.userInfo]
  String? get userInfo;

  /// [Uri.host]
  String? get host;

  /// [Uri.port]
  int? get port;

  /// You can call a [pathSegments] attribute to construct your built value for the path
  /// Use the 'wirename' with the index to refer to the segment index
  // MyPathSegment get pathSegments;

  /// You can call a [queryParameters] attribute to construct your built value for the query
  // MyQueryParameters get queryParameters;

  /// [Uri.fragment]
  String? get fragment;
}

@BuiltValue()
abstract class CustomUri<PS extends Object, QP extends Object>
    implements Built<CustomUri<PS, QP>, CustomUriBuilder<PS, QP>>, CustomUriRule {
  static Serializer<CustomUri> get serializer => _$customUriSerializer;

  CustomUri._();

  factory CustomUri([void Function(CustomUriBuilder<PS, QP> b)? updates]) = _$CustomUri<PS, QP>;

  @override
  String? get scheme;

  @override
  String? get userInfo;

  @override
  String? get host;

  @override
  int? get port;

  String? get path;

  /// [CustomUriRule.pathSegments]
  PS? get pathSegments;

  /// [CustomUriRule.queryParameters]
  QP? get queryParameters;

  @override
  String? get fragment;
}

/// It allows you to construct a built value from a Uri.
/// So you can be sure of the types of the values in the path and or in the query.
/// Extend [CustomUriRule] or use [CustomUri] directly.
///
/// @Example
///
/// // and use it with...
///
/// final uri = Uri(scheme: 'https', host: 'www.example.com', queryParameters: {
///   'string': 'is String',
///   'integer': '12',
///   'stringList': ['firstString', 'secondString'],
///   'intList': ['1', '2'],
/// });
/// final jsonSerializers = (serializers.toBuilder()
///  ..add(CustomUriSerializer.uri(serializer: MyCustomUri.serializer)))
/// .build();
/// final myCustomUri = jsonSerializers.deserialize(uri, specifiedType: const FullType(MyCustomUri));
class CustomUriSerializer<T extends CustomUriRule> extends PrimitiveSerializer<T> {
  final _Type _type;
  final StructuredSerializer<CustomUriRule> serializer;
  final Iterable<Serializer> rawSerializers;
  final Iterable<FullType> singleTypes;

  /// Pass the [serializer] of the constructed type, for example [CustomUri.serializer]
  /// Since to construct a uri all values must be strings,
  /// you can overwrite the serializers with [rawSerializers]. Since the query values are lists
  /// you can specify which types do not require a list with [singleTypes]
  CustomUriSerializer._(
    this._type,
    Serializer<CustomUriRule> serializer,
    Iterable<Serializer> rawSerializers,
    Iterable<FullType> singleTypes,
  )   : serializer = serializer as StructuredSerializer<CustomUriRule>,
        rawSerializers = [...RawSerializer.getAll(), ...rawSerializers],
        singleTypes = [
          const FullType(String),
          const FullType(bool),
          const FullType(DateTime),
          const FullType(double),
          const FullType(Duration),
          const FullType(int),
          const FullType(num),
          ...singleTypes,
        ];

  /// Serialize to [String] and deserialize from [String]
  CustomUriSerializer.string({
    required Serializer<CustomUriRule> serializer,
    Iterable<Serializer> rawSerializers = const <Serializer>[],
    Iterable<FullType> singleTypes = const <FullType>[],
  }) : this._(_Type.string, serializer, rawSerializers, singleTypes);

  /// Serialize to [Uri] and deserialize from [Uri]
  CustomUriSerializer.uri({
    required Serializer<CustomUriRule> serializer,
    Iterable<Serializer> rawSerializers = const <Serializer>[],
    Iterable<FullType> singleTypes = const <FullType>[],
  }) : this._(_Type.uri, serializer, rawSerializers, singleTypes);

  static const String scheme = 'scheme';
  static const String userInfo = 'userInfo';
  static const String host = 'host';
  static const String port = 'port';
  // static final String path = 'path';
  static const String pathSegments = 'pathSegments';
  // static final String pathSegmentsAll = 'pathSegmentsAll';
  // static final String query = 'query';
  static const String queryParameters = 'queryParameters';
  // static final String queryParametersAll = 'queryParametersAll';
  static const String fragment = 'fragment';

  Serializers? _serializers;
  late Serializers _customSerializers;

  void updateSerializers(Serializers serializers) {
    if (_serializers != serializers) {
      _customSerializers = (serializers.toBuilder()
            ..addAll(rawSerializers)
            ..addPlugin(_CustomUriSerializerPlugin(singleTypes: singleTypes)))
          .build();
    }
  }

  @override
  T deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    updateSerializers(serializers);

    final uri = serialized is String ? Uri.parse(serialized) : serialized as Uri;

    final customSerialized = [
      scheme,
      uri.scheme,
      userInfo,
      uri.userInfo,
      host,
      uri.host,
      port,
      '${uri.port}',
      pathSegments,
      List.generate(uri.pathSegments.length, (index) {
        return ['$index', uri.pathSegments[index]];
      }).expand((list) => list),
      queryParameters,
      uri.queryParametersAll.entries.map((e) {
        return [e.key, e.value];
      }).expand((list) => list),
      fragment,
      uri.fragment,
    ];

    return serializer.deserialize(
      _customSerializers,
      customSerialized,
      specifiedType: specifiedType,
    ) as T;
  }

  @override
  Object serialize(
    Serializers serializers,
    T object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    updateSerializers(serializers);

    final serialized = serializer.serialize(
      _customSerializers,
      object,
      specifiedType: specifiedType,
    );

    final iterator = serialized.iterator;
    final b = UriBuilder();

    while (iterator.moveNext()) {
      final key = iterator.current as String?;
      final value = (iterator..moveNext()).current;
      switch (key) {
        case scheme:
          b.scheme = value as String?;
          break;
        case userInfo:
          b.scheme = value as String?;
          break;
        case host:
          b.host = value as String?;
          break;
        case port:
          b.port = value != null ? int.parse(value as String) : null;
          break;
        case pathSegments:
          final iterator = (value as Iterable).iterator;
          while (iterator.moveNext() && iterator.moveNext()) {
            b.pathSegments.add(iterator.current);
          }
          break;
        case queryParameters:
          final iterator = (value as Iterable).iterator;
          while (iterator.moveNext()) {
            final key = iterator.current;
            iterator.moveNext();
            final value = iterator.current;
            b.queryParameters[key] = value;
          }
      }
    }

    final uri = b.build();

    return _type == _Type.uri ? uri : uri.toString();
  }

  @override
  Iterable<Type> get types => serializer.types;

  @override
  String get wireName => serializer.wireName;
}

enum _Type { string, uri }

class _CustomUriSerializerPlugin extends SerializerPlugin {
  final Iterable<FullType> singleTypes;

  _CustomUriSerializerPlugin({required this.singleTypes});

  @override
  Object? beforeDeserialize(Object? object, FullType specifiedType) {
    if (singleTypes.contains(specifiedType)) {
      if (object is Iterable) {
        return object.single;
      }
    }
    return object;
  }

  @override
  Object? afterDeserialize(Object? object, FullType specifiedType) => object;

  @override
  Object? beforeSerialize(Object? object, FullType specifiedType) => object;

  @override
  Object? afterSerialize(Object? object, FullType specifiedType) => object;
}
