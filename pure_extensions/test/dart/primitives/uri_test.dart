import 'package:built_value/serializer.dart';
import 'package:pure_extensions/src/built/uri.dart';
import 'package:test/test.dart';

import 'my_custom_uri.dart';

void main() {
  group("Uri tests", () {
    final uri = Uri(scheme: 'https', host: 'www.google.com', path: 'search', queryParameters: {
      'string': 'is String',
      'integer': '12',
      'stringList': ['firstString', 'secondString'],
      'intList': ['1', '2'],
    });

    test("Non lo so", () {
      print(uri.queryParameters);
      print(uri.queryParametersAll);
      print(uri.query);
    });

    final jsonSerializers = (serializers.toBuilder()
          ..add(CustomUriSerializer.uri(serializer: MyCustomUri.serializer)))
        .build();

    test('CustomUriSerializerPlugin in Serializers', () {
      print(jsonSerializers.serializerForType(MyCustomUri));

      final res = jsonSerializers.deserialize(uri, specifiedType: const FullType(MyCustomUri));
      print(res);
    });
    test('CustomUriSerializerPlugin in Serializers', () {
      final res = jsonSerializers.deserialize(uri, specifiedType: const FullType(MyCustomUri));
      print(res);
      final serialized = jsonSerializers.serialize(res, specifiedType: const FullType(MyCustomUri));
      print(serialized);
    });
  });
}
