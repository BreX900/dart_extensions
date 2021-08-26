class JoinElementIterator<T> extends Iterator<T> {
  final Iterator<T> source;
  final T Function(int index) generator;

  var _index = -1;
  bool _canMove;
  late T _previous;

  JoinElementIterator(this.source, this.generator) : _canMove = source.moveNext();

  @override
  T get current => _index.isEven ? _previous : generator(_index);

  @override
  bool moveNext() {
    _index += 1;

    if (_index.isEven) {
      _previous = source.current;
      final previousCanMove = _canMove;
      _canMove = source.moveNext();
      return previousCanMove;
    }

    return _canMove;
  }
}

class JoinElementIterable<T> extends Iterable<T> {
  final Iterable<T> source;
  final T Function(int index) generator;

  JoinElementIterable(this.source, this.generator) : assert(source.length > 1);

  @override
  Iterator<T> get iterator => JoinElementIterator(source.iterator, generator);
}
