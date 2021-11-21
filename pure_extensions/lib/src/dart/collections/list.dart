import 'dart:convert' show jsonEncode;
import 'dart:math' show Random;

extension ListPureExtensions<T> on List<T> {
  static List<E> nullGenerator<E>(E Function(int) builder, {int? itemCount}) {
    final newList = <E>[];
    E element;
    for (var i = 0; itemCount != null ? i < itemCount : true; i++) {
      element = builder(i);
      if (element == null) break;
      newList.add(element);
    }
    return newList;
  }

  static List<T>? createListIfNotNull<T>(T newValue) {
    if (newValue != null) return [newValue];
    return null;
  }

  // Todo
  void removeAll(Iterable<T> elements) => elements.forEach(remove);

  String serialize() => jsonEncode(this);

  void addOrRemove(bool addOrRemove, T value) {
    if (addOrRemove) {
      add(value);
    } else {
      remove(value);
    }
  }

  List<T> dynamicSublist([int start = 0, int? end]) {
    return sublist(start, end == null ? length : (end < 0 ? length - end : end));
  }

  T random({Random? random}) {
    if (random != null) {
      return this[random.nextInt(length)];
    } else {
      return this[DateTime.now().microsecond % length];
    }
  }

  T circleGet(int index) => this[index % length];
}
