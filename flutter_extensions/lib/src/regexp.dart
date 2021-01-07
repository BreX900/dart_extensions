extension RegExpMatchExt on RegExpMatch {
  String tryNamedGroup(String name) {
    try {
      return namedGroup(name);
    } catch (_) {
      return null;
    }
  }
}
