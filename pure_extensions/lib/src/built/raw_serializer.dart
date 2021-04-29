import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/src/bool_serializer.dart';
import 'package:built_value/src/date_time_serializer.dart';
import 'package:built_value/src/double_serializer.dart';
import 'package:built_value/src/duration_serializer.dart';
import 'package:built_value/src/int_serializer.dart';

/// Serializers a single value from string and to string
abstract class RawSerializer {
  RawSerializer._();

  static PrimitiveSerializer<bool> boolean([Serializer<bool>? serializer]) =>
      _StringBoolSerializer(serializer);
  static PrimitiveSerializer<DateTime> dateTime([Serializer<DateTime>? serializer]) =>
      _StringDateTimeSerializer(serializer);
  static PrimitiveSerializer<double> decimal([Serializer<double>? serializer]) =>
      _StringDoubleSerializer(serializer);
  static PrimitiveSerializer<Duration> duration([Serializer<Duration>? serializer]) =>
      _StringDurationSerializer(serializer);
  static PrimitiveSerializer<int> integer([Serializer<int>? serializer]) =>
      _StringIntSerializer(serializer);
  static PrimitiveSerializer<num> number([Serializer<num>? serializer]) =>
      _StringNumSerializer(serializer);

  static BuiltList<Serializer> getAll({
    Serializer<bool>? boolean,
    Serializer<DateTime>? dateTime,
    Serializer<double>? decimal,
    Serializer<Duration>? duration,
    Serializer<int>? integer,
    Serializer<num>? number,
  }) =>
      BuiltList.of([
        _StringBoolSerializer(boolean),
        _StringDateTimeSerializer(dateTime),
        _StringDoubleSerializer(decimal),
        _StringDurationSerializer(duration),
        _StringIntSerializer(integer),
        _StringNumSerializer(number)
      ]);
}

mixin RedirectSerializer<T> {
  Serializer<T> get serializer;

  Iterable<Type> get types => serializer.types;

  String get wireName => serializer.wireName;

  Object? serialize(Serializers serializers, T object,
      {FullType specifiedType = FullType.unspecified}) {
    final Serializer<T> serializer = this.serializer;
    if (serializer is PrimitiveSerializer<T>) {
      return serializer.serialize(serializers, object, specifiedType: specifiedType);
    } else if (serializer is StructuredSerializer<T>) {
      return serializer.serialize(serializers, object, specifiedType: specifiedType);
    } else {
      return object;
    }
  }

  T deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final Serializer<T> serializer = this.serializer;
    if (serializer is PrimitiveSerializer<T>) {
      return serializer.deserialize(serializers, serialized, specifiedType: specifiedType);
    } else if (serializer is StructuredSerializer<T>) {
      return serializer.deserialize(serializers, serialized as Iterable<dynamic>,
          specifiedType: specifiedType);
    } else {
      return serialized as T;
    }
  }
}

abstract class BaseRedirectSerializer<T> with RedirectSerializer<T> {
  final Serializer<T> serializer;

  BaseRedirectSerializer(this.serializer);
}

class _StringBoolSerializer extends BaseRedirectSerializer<bool>
    implements PrimitiveSerializer<bool> {
  _StringBoolSerializer([Serializer<bool>? serializer]) : super(serializer ?? BoolSerializer());
  @override
  Object serialize(Serializers serializers, bool boolean,
      {FullType specifiedType = FullType.unspecified}) {
    return '$boolean';
  }

  @override
  bool deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return bool.fromEnvironment(serialized as String, defaultValue: false);
  }
}

class _StringDateTimeSerializer extends BaseRedirectSerializer<DateTime>
    implements PrimitiveSerializer<DateTime> {
  _StringDateTimeSerializer([Serializer<DateTime>? serializer])
      : super(serializer ?? DateTimeSerializer());

  @override
  Object serialize(
    Serializers serializers,
    DateTime dateTime, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return '${super.serialize(serializers, dateTime, specifiedType: specifiedType)}';
  }

  @override
  DateTime deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return super
        .deserialize(serializers, int.parse(serialized as String), specifiedType: specifiedType);
  }
}

class _StringDoubleSerializer extends BaseRedirectSerializer<double>
    implements PrimitiveSerializer<double> {
  _StringDoubleSerializer([Serializer<double>? serializer])
      : super(serializer ?? DoubleSerializer());

  @override
  Object serialize(
    Serializers serializers,
    double aDouble, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final serialized = super.serialize(serializers, aDouble, specifiedType: specifiedType);
    if (serialized is double) {
      return '$aDouble';
    } else {
      return serialized!;
    }
  }

  @override
  double deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    if (serialized == DoubleSerializer.nan ||
        serialized == DoubleSerializer.negativeInfinity ||
        serialized == DoubleSerializer.infinity) {
      return super.deserialize(serializers, serialized, specifiedType: specifiedType);
    } else {
      return double.parse(serialized as String);
    }
  }
}

class _StringDurationSerializer extends BaseRedirectSerializer<Duration>
    implements PrimitiveSerializer<Duration> {
  _StringDurationSerializer([Serializer<Duration>? serializer])
      : super(serializer ?? DurationSerializer());

  @override
  Object serialize(
    Serializers serializers,
    Duration object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return '${super.serialize(serializers, object, specifiedType: specifiedType)}';
  }

  @override
  Duration deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return super
        .deserialize(serializers, int.parse(serialized as String), specifiedType: specifiedType);
  }
}

class _StringIntSerializer extends BaseRedirectSerializer<int> implements PrimitiveSerializer<int> {
  _StringIntSerializer([Serializer<int>? serializer]) : super(serializer ?? IntSerializer());

  @override
  Object serialize(
    Serializers serializers,
    int object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return '${super.serialize(serializers, object, specifiedType: specifiedType)}';
  }

  @override
  int deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return super
        .deserialize(serializers, int.parse(serialized as String), specifiedType: specifiedType);
  }
}

class _StringNumSerializer extends BaseRedirectSerializer<num> implements PrimitiveSerializer<num> {
  _StringNumSerializer([Serializer<num>? serializer]) : super(serializer ?? DoubleSerializer());

  @override
  Object serialize(
    Serializers serializers,
    num aDouble, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final serialized = super.serialize(serializers, aDouble, specifiedType: specifiedType);
    if (serialized is num) {
      return '$aDouble';
    } else {
      return serialized!;
    }
  }

  @override
  num deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    if (serialized == DoubleSerializer.nan ||
        serialized == DoubleSerializer.negativeInfinity ||
        serialized == DoubleSerializer.infinity) {
      return super.deserialize(serializers, serialized, specifiedType: specifiedType);
    } else {
      return num.parse(serialized as String);
    }
  }
}

class SerializersToSerializer<T> extends PrimitiveSerializer<T> {
  final Serializers serializers;

  SerializersToSerializer(this.serializers);

  @override
  T deserialize(Serializers _, Object serialized, {FullType specifiedType = FullType.unspecified}) {
    return serializers.deserialize(serialized, specifiedType: FullType(T)) as T;
  }

  @override
  Object serialize(Serializers _, T object, {FullType specifiedType = FullType.unspecified}) {
    return serializers.serialize(object!, specifiedType: FullType(T))!;
  }

  @override
  final Iterable<Type> types = BuiltList([T]);

  @override
  final String wireName = '$T';
}
