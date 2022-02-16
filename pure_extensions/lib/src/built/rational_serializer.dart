import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:pure_extensions/src/dart/primitives/string.dart';
import 'package:rational/rational.dart';

abstract class RationalSerializer implements PrimitiveSerializer<Rational> {
  @override
  final Iterable<Type> types = BuiltList([Rational]);

  @override
  final String wireName = '$Rational';

  RationalSerializer();

  factory RationalSerializer.decimal({int? fractionDigits}) = DecimalRationalSerializer;

  factory RationalSerializer.integer({int fractionDigits}) = IntegerRationalSerializer;

  factory RationalSerializer.double() = DoubleRationalSerializer;
}

class DecimalRationalSerializer extends RationalSerializer {
  final int? fractionDigits;

  DecimalRationalSerializer({this.fractionDigits});

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
      return object.toDouble().toStringAsFixed(fractionDigits!);
    } else {
      return object.toDouble();
    }
  }
}

class IntegerRationalSerializer extends RationalSerializer {
  final int fractionDigits;

  IntegerRationalSerializer({this.fractionDigits = 0}) : assert(fractionDigits >= 0);

  @override
  Rational deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final num = serialized as int;
    final rawNum = num.toString();
    final fineNum = rawNum.padRight(fractionDigits + 1, '0');
    final whole = fineNum.advSubString(0, -fractionDigits);
    final decimal = fineNum.advSubString(-fractionDigits, fineNum.length);
    return Rational.parse('$whole.$decimal');
  }

  @override
  Object serialize(Serializers serializers, Rational object,
      {FullType specifiedType = FullType.unspecified}) {
    final str = object.toDouble().toString();
    final splitted = str.split('.');
    final whole = splitted[0];
    final decimal = splitted[1];
    final fineDecimal = decimal.padRight(fractionDigits, '0').substring(0, fractionDigits);
    return '$whole$fineDecimal';
  }
}

class DoubleRationalSerializer extends RationalSerializer {
  @override
  Rational deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final str = (serialized as double).toString();
    return Rational.parse(str);
  }

  @override
  Object serialize(Serializers serializers, Rational object,
      {FullType specifiedType = FullType.unspecified}) {
    return object.toDouble();
  }
}
