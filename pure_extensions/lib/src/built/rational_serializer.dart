import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:rational/rational.dart';

class RationalSerializer implements PrimitiveSerializer<Rational> {
  ///
  final int? fractionDigits;

  RationalSerializer({this.fractionDigits});

  @override
  Rational deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return Rational.parse(serialized as String);
  }

  @override
  Object serialize(
    Serializers serializers,
    Rational object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    if (fractionDigits != null) {
      return object.toStringAsFixed(fractionDigits!);
    } else {
      return object.toDecimalString();
    }
  }

  @override
  final Iterable<Type> types = BuiltList([Rational]);

  @override
  final String wireName = '$Rational';
}
