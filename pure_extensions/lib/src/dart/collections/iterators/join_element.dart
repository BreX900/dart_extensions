class JoinElementIterator<T> extends Iterator<T> {
  final Iterator<T> source;
  final T Function(int index) generator;

  var index = -1;
  bool canMove;
  late T previousElement;

  JoinElementIterator(this.source, this.generator) : canMove = source.moveNext();

  @override
  T get current => index.isEven ? previousElement : generator(index);

  @override
  bool moveNext() {
    index += 1;

    if (index.isEven) {
      previousElement = source.current;
      final previousCanMove = canMove;
      canMove = source.moveNext();
      return previousCanMove;
    }

    return canMove;
  }
}

class JoinElementIterable<T> extends Iterable<T> {
  final Iterable<T> source;
  final T Function(int index) generator;

  JoinElementIterable(this.source, this.generator) : assert(source.length > 1);

  @override
  Iterator<T> get iterator => JoinElementIterator(source.iterator, generator);
}
