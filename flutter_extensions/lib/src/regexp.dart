extension RegExpFlutterExtensions on RegExpMatch {
  String? namedGroupOrNull(String name) {
    try {
      return namedGroup(name);
    } catch (_) {
      return null;
    }
  }
}
