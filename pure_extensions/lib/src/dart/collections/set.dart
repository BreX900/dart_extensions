extension SetPureExtensions<T> on Set<T> {
  void addOrRemove(bool isAdd, T value) {
    if (isAdd) {
      add(value);
    } else {
      remove(value);
    }
  }

  void removeAll(Iterable<T> elements) => elements.forEach(remove);
}
