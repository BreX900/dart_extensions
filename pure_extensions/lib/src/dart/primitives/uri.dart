extension UriPureExtensions on Uri {
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
  String? scheme;
  String? userInfo;
  String? host;
  int? port;
  List<dynamic> _path = [];
  Map<String, dynamic> queryParameters = <String, dynamic>{};
  String? fragment;

  List<dynamic> get pathSegments => _path;
  set pathSegments(Iterable<dynamic> pathSegments) {
    _path = pathSegments.toList();
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

  void addRawQueryParameter(dynamic key, dynamic value) {
    queryParameters['$key'] = value is Iterable ? value.map((v) => '$v') : '$value';
  }

  void addAllRawQueryParameters(Map<dynamic, dynamic> queryParameters) {
    queryParameters.addAll(queryParameters.map((key, value) {
      return MapEntry('$key', value is Iterable ? value.map((v) => '$v') : '$value');
    }));
  }

  void update(void Function(UriBuilder b)? updates) {
    if (updates != null) updates(this);
  }

  UriBuilder([void Function(UriBuilder b)? updates]) {
    update(updates);
  }

  factory UriBuilder.of(Uri uri) => UriBuilder()..replace(uri);

  void replace(Uri uri) {
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
