// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uri.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CustomUri<Object, Object>> _$customUriSerializer =
    new _$CustomUriSerializer();

class _$CustomUriSerializer
    implements StructuredSerializer<CustomUri<Object, Object>> {
  @override
  final Iterable<Type> types = const [CustomUri, _$CustomUri];
  @override
  final String wireName = 'CustomUri';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, CustomUri<Object, Object> object,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterPS =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];
    final parameterQP =
        isUnderspecified ? FullType.object : specifiedType.parameters[1];

    final result = <Object?>[];
    Object? value;
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
    value = object.path;
    if (value != null) {
      result
        ..add('path')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pathSegments;
    if (value != null) {
      result
        ..add('pathSegments')
        ..add(serializers.serialize(value, specifiedType: parameterPS));
    }
    value = object.queryParameters;
    if (value != null) {
      result
        ..add('queryParameters')
        ..add(serializers.serialize(value, specifiedType: parameterQP));
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
  CustomUri<Object, Object> deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final isUnderspecified =
        specifiedType.isUnspecified || specifiedType.parameters.isEmpty;
    if (!isUnderspecified) serializers.expectBuilder(specifiedType);
    final parameterPS =
        isUnderspecified ? FullType.object : specifiedType.parameters[0];
    final parameterQP =
        isUnderspecified ? FullType.object : specifiedType.parameters[1];

    final result = isUnderspecified
        ? new CustomUriBuilder<Object, Object>()
        : serializers.newBuilder(specifiedType)
            as CustomUriBuilder<Object, Object>;

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
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
        case 'path':
          result.path = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pathSegments':
          result.pathSegments =
              serializers.deserialize(value, specifiedType: parameterPS);
          break;
        case 'queryParameters':
          result.queryParameters =
              serializers.deserialize(value, specifiedType: parameterQP);
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

class _$CustomUri<PS extends Object, QP extends Object>
    extends CustomUri<PS, QP> {
  @override
  final String? scheme;
  @override
  final String? userInfo;
  @override
  final String? host;
  @override
  final int? port;
  @override
  final String? path;
  @override
  final PS? pathSegments;
  @override
  final QP? queryParameters;
  @override
  final String? fragment;

  factory _$CustomUri([void Function(CustomUriBuilder<PS, QP>)? updates]) =>
      (new CustomUriBuilder<PS, QP>()..update(updates)).build();

  _$CustomUri._(
      {this.scheme,
      this.userInfo,
      this.host,
      this.port,
      this.path,
      this.pathSegments,
      this.queryParameters,
      this.fragment})
      : super._() {
    if (PS == dynamic) {
      throw new BuiltValueMissingGenericsError('CustomUri', 'PS');
    }
    if (QP == dynamic) {
      throw new BuiltValueMissingGenericsError('CustomUri', 'QP');
    }
  }

  @override
  CustomUri<PS, QP> rebuild(void Function(CustomUriBuilder<PS, QP>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CustomUriBuilder<PS, QP> toBuilder() =>
      new CustomUriBuilder<PS, QP>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CustomUri &&
        scheme == other.scheme &&
        userInfo == other.userInfo &&
        host == other.host &&
        port == other.port &&
        path == other.path &&
        pathSegments == other.pathSegments &&
        queryParameters == other.queryParameters &&
        fragment == other.fragment;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, scheme.hashCode), userInfo.hashCode),
                            host.hashCode),
                        port.hashCode),
                    path.hashCode),
                pathSegments.hashCode),
            queryParameters.hashCode),
        fragment.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CustomUri')
          ..add('scheme', scheme)
          ..add('userInfo', userInfo)
          ..add('host', host)
          ..add('port', port)
          ..add('path', path)
          ..add('pathSegments', pathSegments)
          ..add('queryParameters', queryParameters)
          ..add('fragment', fragment))
        .toString();
  }
}

class CustomUriBuilder<PS extends Object, QP extends Object>
    implements Builder<CustomUri<PS, QP>, CustomUriBuilder<PS, QP>> {
  _$CustomUri<PS, QP>? _$v;

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

  String? _path;
  String? get path => _$this._path;
  set path(String? path) => _$this._path = path;

  PS? _pathSegments;
  PS? get pathSegments => _$this._pathSegments;
  set pathSegments(PS? pathSegments) => _$this._pathSegments = pathSegments;

  QP? _queryParameters;
  QP? get queryParameters => _$this._queryParameters;
  set queryParameters(QP? queryParameters) =>
      _$this._queryParameters = queryParameters;

  String? _fragment;
  String? get fragment => _$this._fragment;
  set fragment(String? fragment) => _$this._fragment = fragment;

  CustomUriBuilder();

  CustomUriBuilder<PS, QP> get _$this {
    final $v = _$v;
    if ($v != null) {
      _scheme = $v.scheme;
      _userInfo = $v.userInfo;
      _host = $v.host;
      _port = $v.port;
      _path = $v.path;
      _pathSegments = $v.pathSegments;
      _queryParameters = $v.queryParameters;
      _fragment = $v.fragment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CustomUri<PS, QP> other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CustomUri<PS, QP>;
  }

  @override
  void update(void Function(CustomUriBuilder<PS, QP>)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CustomUri<PS, QP> build() {
    final _$result = _$v ??
        new _$CustomUri<PS, QP>._(
            scheme: scheme,
            userInfo: userInfo,
            host: host,
            port: port,
            path: path,
            pathSegments: pathSegments,
            queryParameters: queryParameters,
            fragment: fragment);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
