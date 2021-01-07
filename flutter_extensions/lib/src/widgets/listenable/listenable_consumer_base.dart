import 'package:flutter/widgets.dart';
import 'package:flutter_extensions/src/widgets/listenable/listenable_consumer.dart';

mixin ChangeableValueListenerBase<L extends Listenable, V> on ChangeableValueConsumerBase<L, V> {
  bool Function(V p, V c) get listenWhen;
  void Function(BuildContext context, V value) get listener;
}

mixin ChangeableValueListenerBaseState<W extends ChangeableValueListenerBase<L, V>,
    L extends Listenable, V> on ChangeableValueConsumerBaseState<W, L, V> {
  @override
  bool onUpdateValue(V previous, V current) {
    if (widget.listenWhen == null || widget.listenWhen(previous, current)) {
      widget.listener(context, current);
    }
    return super.onUpdateValue(previous, current);
  }
}

mixin ChangeableValueBuilderBase<L extends Listenable, V> on ChangeableValueConsumerBase<L, V> {
  bool Function(V p, V c) get buildWhen;
  Widget Function(BuildContext context, V value) get builder;
}

mixin ChangeableValueBuilderBaseState<W extends ChangeableValueBuilderBase<L, V>,
    L extends Listenable, V> on ChangeableValueConsumerBaseState<W, L, V> {
  @override
  bool onUpdateValue(V previous, V current) {
    final res = super.onUpdateValue(previous, current);
    if (!res && (widget.buildWhen == null || widget.buildWhen(previous, current))) {
      setState(() {
        value = current;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, value);
}

abstract class ChangeableValueConsumerBase<T extends Listenable, V>
    extends ChangeableConsumerBase<T> {
  final V Function(T listenable) selector;

  ChangeableValueConsumerBase({
    Key key,
    @required this.selector,
    @required T listenable,
  }) : super(key: key, listenable: listenable);
}

abstract class ChangeableValueConsumerBaseState<W extends ChangeableValueConsumerBase<T, V>,
    T extends Listenable, V> extends ChangeableConsumerBaseState<W, T> {
  V value;
  V getCurrentValue() => listenable != null ? widget.selector(listenable) : null;

  @override
  void subscribe() {
    super.subscribe();
    value = getCurrentValue();
  }

  @override
  void unsubscribe() {
    super.unsubscribe();
    value = null;
  }

  @override
  void onUpdate() {
    final currentValue = getCurrentValue();
    if (value != currentValue && onUpdateValue(value, currentValue)) return;
    value = currentValue;
  }

  bool onUpdateValue(V previous, V current) => false;
}

abstract class ChangeableConsumerBase<T extends Listenable> extends StatefulWidget {
  final T listenable;

  const ChangeableConsumerBase({Key key, @required this.listenable}) : super(key: key);
}

abstract class ChangeableConsumerBaseState<W extends ChangeableConsumerBase<T>,
    T extends Listenable> extends State<W> {
  T _listenable;
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
    if (_listenable != null) _listenable.addListener(onUpdate);
  }

  void unsubscribe() {
    if (_listenable != null) _listenable.removeListener(onUpdate);
  }

  void onUpdate();
}
