extension SetExt<T> on Set<T> {
  void removeWhereNull() => removeWhere((value) => value == null);

  void addOrRemove(bool isAdd, T value) {
    if (isAdd) {
      add(value);
    } else {
      remove(value);
    }
  }
}
