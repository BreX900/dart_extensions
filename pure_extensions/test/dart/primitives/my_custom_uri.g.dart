// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_custom_uri.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(MyCustomQuery.serializer)
      ..add(MyCustomUri.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(int)]),
          () => new ListBuilder<int>()))
    .build();
Serializer<MyCustomQuery> _$myCustomQuerySerializer =
    new _$MyCustomQuerySerializer();
Serializer<MyCustomUri> _$myCustomUriSerializer = new _$MyCustomUriSerializer();

class _$MyCustomQuerySerializer implements StructuredSerializer<MyCustomQuery> {
  @override
  final Iterable<Type> types = const [MyCustomQuery, _$MyCustomQuery];
  @override
  final String wireName = 'MyCustomQuery';

  @override
  Iterable<Object?> serialize(Serializers serializers, MyCustomQuery object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.string;
    if (value != null) {
      result
        ..add('string')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.integer;
    if (value != null) {
      result
        ..add('integer')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.stringList;
    if (value != null) {
      result
        ..add('stringList')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.intList;
    if (value != null) {
      result
        ..add('intList')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    return result;
  }

  @override
  MyCustomQuery deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MyCustomQueryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'string':
          result.string = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'integer':
          result.integer = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'stringList':
          result.stringList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object>);
          break;
        case 'intList':
          result.intList.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$MyCustomUriSerializer implements StructuredSerializer<MyCustomUri> {
  @override
  final Iterable<Type> types = const [MyCustomUri, _$MyCustomUri];
  @override
  final String wireName = 'MyCustomUri';

  @override
  Iterable<Object?> serialize(Serializers serializers, MyCustomUri object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.queryParameters;
    if (value != null) {
      result
        ..add('queryParameters')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(MyCustomQuery)));
    }
    value = object.scheme;
    if (value != null) {
      result
        ..add('scheme')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userInfo;
    if (value != null) {
      result
        ..add('userInfo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.host;
    if (value != null) {
      result
        ..add('host')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.port;
    if (value != null) {
      result
        ..add('port')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.fragment;
    if (value != null) {
      result
        ..add('fragment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  MyCustomUri deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MyCustomUriBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'queryParameters':
          result.queryParameters.replace(serializers.deserialize(value,
              specifiedType: const FullType(MyCustomQuery))! as MyCustomQuery);
          break;
        case 'scheme':
          result.scheme = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userInfo':
          result.userInfo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'host':
          result.host = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'port':
          result.port = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'fragment':
          result.fragment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$MyCustomQuery extends MyCustomQuery {
  @override
  final String? string;
  @override
  final int? integer;
  @override
  final BuiltList<String>? stringList;
  @override
  final BuiltList<int>? intList;

  factory _$MyCustomQuery([void Function(MyCustomQueryBuilder)? updates]) =>
      (new MyCustomQueryBuilder()..update(updates)).build();

  _$MyCustomQuery._({this.string, this.integer, this.stringList, this.intList})
      : super._();

  @override
  MyCustomQuery rebuild(void Function(MyCustomQueryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MyCustomQueryBuilder toBuilder() => new MyCustomQueryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyCustomQuery &&
        string == other.string &&
        integer == other.integer &&
        stringList == other.stringList &&
        intList == other.intList;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, string.hashCode), integer.hashCode),
            stringList.hashCode),
        intList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MyCustomQuery')
          ..add('string', string)
          ..add('integer', integer)
          ..add('stringList', stringList)
          ..add('intList', intList))
        .toString();
  }
}

class MyCustomQueryBuilder
    implements Builder<MyCustomQuery, MyCustomQueryBuilder> {
  _$MyCustomQuery? _$v;

  String? _string;
  String? get string => _$this._string;
  set string(String? string) => _$this._string = string;

  int? _integer;
  int? get integer => _$this._integer;
  set integer(int? integer) => _$this._integer = integer;

  ListBuilder<String>? _stringList;
  ListBuilder<String> get stringList =>
      _$this._stringList ??= new ListBuilder<String>();
  set stringList(ListBuilder<String>? stringList) =>
      _$this._stringList = stringList;

  ListBuilder<int>? _intList;
  ListBuilder<int> get intList => _$this._intList ??= new ListBuilder<int>();
  set intList(ListBuilder<int>? intList) => _$this._intList = intList;

  MyCustomQueryBuilder();

  MyCustomQueryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _string = $v.string;
      _integer = $v.integer;
      _stringList = $v.stringList?.toBuilder();
      _intList = $v.intList?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MyCustomQuery other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MyCustomQuery;
  }

  @override
  void update(void Function(MyCustomQueryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MyCustomQuery build() {
    _$MyCustomQuery _$result;
    try {
      _$result = _$v ??
          new _$MyCustomQuery._(
              string: string,
              integer: integer,
              stringList: _stringList?.build(),
              intList: _intList?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'stringList';
        _stringList?.build();
        _$failedField = 'intList';
        _intList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MyCustomQuery', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$MyCustomUri extends MyCustomUri {
  @override
  final MyCustomQuery? queryParameters;
  @override
  final String? scheme;
  @override
  final String? userInfo;
  @override
  final String? host;
  @override
  final int? port;
  @override
  final String? fragment;

  factory _$MyCustomUri([void Function(MyCustomUriBuilder)? updates]) =>
      (new MyCustomUriBuilder()..update(updates)).build();

  _$MyCustomUri._(
      {this.queryParameters,
      this.scheme,
      this.userInfo,
      this.host,
      this.port,
      this.fragment})
      : super._();

  @override
  MyCustomUri rebuild(void Function(MyCustomUriBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MyCustomUriBuilder toBuilder() => new MyCustomUriBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyCustomUri &&
        queryParameters == other.queryParameters &&
        scheme == other.scheme &&
        userInfo == other.userInfo &&
        host == other.host &&
        port == other.port &&
        fragment == other.fragment;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, queryParameters.hashCode), scheme.hashCode),
                    userInfo.hashCode),
                host.hashCode),
            port.hashCode),
        fragment.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MyCustomUri')
          ..add('queryParameters', queryParameters)
          ..add('scheme', scheme)
          ..add('userInfo', userInfo)
          ..add('host', host)
          ..add('port', port)
          ..add('fragment', fragment))
        .toString();
  }
}

class MyCustomUriBuilder implements Builder<MyCustomUri, MyCustomUriBuilder> {
  _$MyCustomUri? _$v;

  MyCustomQueryBuilder? _queryParameters;
  MyCustomQueryBuilder get queryParameters =>
      _$this._queryParameters ??= new MyCustomQueryBuilder();
  set queryParameters(MyCustomQueryBuilder? queryParameters) =>
      _$this._queryParameters = queryParameters;

  String? _scheme;
  String? get scheme => _$this._scheme;
  set scheme(String? scheme) => _$this._scheme = scheme;

  String? _userInfo;
  String? get userInfo => _$this._userInfo;
  set userInfo(String? userInfo) => _$this._userInfo = userInfo;

  String? _host;
  String? get host => _$this._host;
  set host(String? host) => _$this._host = host;

  int? _port;
  int? get port => _$this._port;
  set port(int? port) => _$this._port = port;

  String? _fragment;
  String? get fragment => _$this._fragment;
  set fragment(String? fragment) => _$this._fragment = fragment;

  MyCustomUriBuilder();

  MyCustomUriBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _queryParameters = $v.queryParameters?.toBuilder();
      _scheme = $v.scheme;
      _userInfo = $v.userInfo;
      _host = $v.host;
      _port = $v.port;
      _fragment = $v.fragment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MyCustomUri other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MyCustomUri;
  }

  @override
  void update(void Function(MyCustomUriBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MyCustomUri build() {
    _$MyCustomUri _$result;
    try {
      _$result = _$v ??
          new _$MyCustomUri._(
              queryParameters: _queryParameters?.build(),
              scheme: scheme,
              userInfo: userInfo,
              host: host,
              port: port,
              fragment: fragment);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'queryParameters';
        _queryParameters?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MyCustomUri', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
