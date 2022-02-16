class KeyError extends ArgumentError {
  final dynamic accessible;

  KeyError(dynamic invalidKey, this.accessible, [String? name, String? message])
      : super.value(invalidKey, name, message ?? "Key not exist");
}
