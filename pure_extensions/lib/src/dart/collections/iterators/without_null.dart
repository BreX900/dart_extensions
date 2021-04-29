class WithoutNullIterator<T> extends Iterator<T> {
  final Iterator<T?> source;

  WithoutNullIterator(this.source);

  @override
  T get current => source.current!;

  @override
  bool moveNext() {
    while (source.moveNext()) {
      if (source.current != null) return true;
    }
    return false;
  }
}

class WithoutNullIterable<T> extends Iterable<T> {
  final Iterable<T?> source;

  WithoutNullIterable(this.source);

  @override
  Iterator<T> get iterator => WithoutNullIterator(source.iterator);
}
