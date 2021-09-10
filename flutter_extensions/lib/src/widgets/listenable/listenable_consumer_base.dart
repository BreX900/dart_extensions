import 'package:flutter/widgets.dart';
import 'package:flutter_extensions/src/widgets/listenable/listenable_consumer.dart';

abstract class ChangeableValueConsumerRule<T extends Listenable, V>
    implements ChangeableConsumerRule<T> {
  @override
  T? get listenable;
  V Function(T listeneble) get selector;
}

mixin ChangeableValueConsumerStateMixin<W extends ChangeableValueConsumerRule<T, V>,
    T extends Listenable, V> on ChangeableConsumerStateMixin<W, T> {
  late V _previous;
  V get value => _previous;

  @override
  void initState() {
    super.initState();
    _previous = widget.selector(listenable);
  }

  @override
  void onListenableChanges() {
    final current = widget.selector(listenable);
    onValueChanges(_previous, current);
    _previous = current;
  }

  void onValueChanges(V previous, V current);
}

abstract class ChangeableConsumerRule<T extends Listenable> implements StatefulWidget {
  T? get listenable;
}

mixin ChangeableConsumerStateMixin<W extends ChangeableConsumerRule<T>, T extends Listenable>
    on State<W> {
  late T _listenable;
  T get listenable => _listenable;

  @override
  void initState() {
    super.initState();
    _listenable = widget.listenable ?? ChangeableProvider.of<T>(context);
    subscribe();
  }

  @override
  void didUpdateWidget(W oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldState = oldWidget.listenable ?? ChangeableProvider.of<T>(context);
    final currentState = widget.listenable ?? oldState;
    if (currentState != oldState) {
      unsubscribe();
      _listenable = widget.listenable ?? ChangeableProvider.of<T>(context);
      subscribe();
    }
  }

  @override
  void dispose() {
    unsubscribe();
    super.dispose();
  }

  void subscribe() {
    _listenable.addListener(onListenableChanges);
  }

  void unsubscribe() {
    _listenable.removeListener(onListenableChanges);
  }

  void onListenableChanges();
}
