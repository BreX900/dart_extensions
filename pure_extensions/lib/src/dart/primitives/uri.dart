extension UriDartExtension on Uri {
  Map<String, dynamic /*String|Iterable<String>*/ > get queryParametersNormalized {
    return queryParameters.map((key, value) {
      return MapEntry(key, value.startsWith("["));
    });
  }

  /// Converts this in builder
  Uri rebuild(void Function(UriBuilder b) updates) => (toBuilder()..update(updates)).build();

  /// Update this by [UriBuilder]
  UriBuilder toBuilder() => UriBuilder.of(this);
}

class UriBuilder {
  String scheme;
  String userInfo;
  String host;
  int port;
  List<dynamic> _path = [];
  Map<String, dynamic> _query = <String, dynamic>{};
  String fragment;

  List<dynamic> get pathSegments => this._path;
  set pathSegments(Iterable<dynamic> pathSegments) {
    this._path = pathSegments?.toList() ?? <dynamic>[];
  }

  set path(String path) {
    _path = path.split('/');
  }

  void addPath(String path) {
    _path.addAll(path.split('/'));
  }

  void addRawPathSegment(dynamic pathSegment) {
    _path.add('$pathSegment');
  }

  void addAllRawPathSegments(Iterable<dynamic> rawPathSegments) {
    _path.addAll(rawPathSegments.map((ps) => '$ps'));
  }

  Map<String, dynamic /*dynamic|Iterable<dynamic>*/ > get queryParameters => this._query;
  set queryParameters(Map<String, dynamic /*dynamic|Iterable<dynamic>*/ > queryParameters) {
    this._query = queryParameters ?? <dynamic, dynamic>{};
  }

  void addRawQueryParameter(dynamic key, dynamic value) {
    _query['$key'] = value is Iterable ? value.map((v) => '$v') : '$value';
  }

  void addAllRawQueryParameters(Map<dynamic, dynamic> queryParameters) {
    _query.addAll(queryParameters.map((key, value) {
      return MapEntry('$key', value is Iterable ? value.map((v) => '$v') : '$value');
    }));
  }

  void update(void Function(UriBuilder b) updates) {
    if (updates != null) updates(this);
  }

  UriBuilder([void Function(UriBuilder b) updates]) {
    update(updates);
  }

  factory UriBuilder.of(Uri uri) => UriBuilder()..replace(uri);

  void replace(Uri uri) {
    assert(uri != null);
    scheme = uri.scheme;
    userInfo = uri.userInfo;
    host = uri.host;
    port = uri.port;
    pathSegments = uri.pathSegments;
    queryParameters = uri.queryParameters;
    fragment = uri.fragment;
  }

  Uri build() {
    return Uri(
      scheme: scheme,
      userInfo: userInfo,
      host: host,
      port: port,
      pathSegments: pathSegments.map<String>((s) => '$s'),
      queryParameters: queryParameters,
      fragment: fragment,
    );
  }
}
