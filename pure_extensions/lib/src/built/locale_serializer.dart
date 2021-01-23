// import 'dart:ui';
//
// import 'package:built_value/serializer.dart';
//
// /// Serializer for the [Locale] type
// class LocaleSerializer implements PrimitiveSerializer<Locale> {
//   LocaleSerializer();
//
//   @override
//   Locale deserialize(Serializers serializers, Object serialized,
//       {FullType specifiedType = FullType.unspecified}) {
//     final str =
//         serializers.deserialize(serialized, specifiedType: const FullType(String)) as String;
//     final segments = str.split('-');
//     return Locale.fromSubtags(
//       languageCode: segments[0],
//       countryCode: segments.length > 1 ? segments[1] : null,
//     );
//   }
//
//   @override
//   Object serialize(Serializers serializers, Locale object,
//       {FullType specifiedType = FullType.unspecified}) {
//     final str = object.toLanguageTag();
//     return serializers.serialize(str, specifiedType: const FullType(String));
//   }
//
//   @override
//   final Iterable<Type> types = [Locale];
//
//   @override
//   final String wireName = '$Locale';
// }
