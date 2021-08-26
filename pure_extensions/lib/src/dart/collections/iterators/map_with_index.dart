class MapWithIndexIterator<E, T> extends Iterator<T> {
  final Iterator<E> source;
  final T Function(E e, int i) generator;

  var _index = -1;
  late T _current;

  MapWithIndexIterator(this.source, this.generator);

  @override
  T get current => _current;

  @override
  bool moveNext() {
    if (!source.moveNext()) return false;

    _index += 1;
    _current = generator(source.current, _index);
    return true;
  }
}

class MapWithIndexIterable<E, T> extends Iterable<T> {
  final Iterable<E> source;
  final T Function(E e, int i) generator;

  MapWithIndexIterable(this.source, this.generator);

  @override
  Iterator<T> get iterator => MapWithIndexIterator(source.iterator, generator);
}
