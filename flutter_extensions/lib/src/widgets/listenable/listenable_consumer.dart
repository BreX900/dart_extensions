import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_extensions/src/widgets/listenable/listenable_consumer_base.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ValueListenableListener<T> extends ChangeableValueListener<ValueListenable<T>, T> {
  ValueListenableListener({
    Key key,
    ValueListenable<T> listenable,
    bool Function(T before, T after) listenWhen,
    @required void Function(BuildContext context, T value) listener,
    @required Widget child,
  }) : super(
          key: key,
          listenable: listenable,
          selector: (listenable) => listenable.value,
          listenWhen: listenWhen,
          listener: listener,
          child: child,
        );
}

class ChangeableValueConsumer<T extends Listenable, V> extends ChangeableValueConsumerBase<T, V>
    with ChangeableValueListenerBase<T, V>, ChangeableValueBuilderBase<T, V> {
  final bool Function(V before, V after) listenWhen;
  final void Function(BuildContext context, V value) listener;
  final bool Function(V before, V after) buildWhen;
  final Widget Function(BuildContext context, V value) builder;

  ChangeableValueConsumer({
    Key key,
    T listenable,
    V Function(T listenable) selector,
    this.listenWhen,
    @required this.listener,
    this.buildWhen,
    @required this.builder,
  }) : super(key: key, listenable: listenable, selector: selector);

  @override
  _ChangeableValueConsumerState<T, V> createState() => _ChangeableValueConsumerState<T, V>();
}

class _ChangeableValueConsumerState<T extends Listenable, V>
    extends ChangeableValueConsumerBaseState<ChangeableValueConsumer<T, V>, T, V>
    with
        ChangeableValueListenerBaseState<ChangeableValueConsumer<T, V>, T, V>,
        ChangeableValueBuilderBaseState<ChangeableValueConsumer<T, V>, T, V> {}

class ChangeableValueListener<T extends Listenable, V> extends ChangeableValueConsumerBase<T, V>
    with ChangeableValueListenerBase<T, V> {
  final bool Function(V before, V after) listenWhen;
  final void Function(BuildContext context, V value) listener;
  final Widget child;

  ChangeableValueListener({
    Key key,
    T listenable,
    V Function(T listenable) selector,
    this.listenWhen,
    @required this.listener,
    @required this.child,
  }) : super(key: key, listenable: listenable, selector: selector);

  @override
  _ChangeableValueListenerState<T, V> createState() => _ChangeableValueListenerState<T, V>();
}

class _ChangeableValueListenerState<T extends Listenable, V>
    extends ChangeableValueConsumerBaseState<ChangeableValueListener<T, V>, T, V>
    with ChangeableValueListenerBaseState<ChangeableValueListener<T, V>, T, V> {
  @override
  Widget build(BuildContext context) => widget.child;
}

class ChangeableValueBuilder<T extends Listenable, V> extends ChangeableValueConsumerBase<T, V>
    with ChangeableValueBuilderBase<T, V> {
  final bool Function(V before, V after) buildWhen;
  final Widget Function(BuildContext context, V value) builder;

  ChangeableValueBuilder({
    Key key,
    T listenable,
    V Function(T listenable) selector,
    this.buildWhen,
    @required this.builder,
  }) : super(key: key, listenable: listenable, selector: selector);

  @override
  _ChangeableValueBuilderState<T, V> createState() => _ChangeableValueBuilderState<T, V>();
}

class _ChangeableValueBuilderState<T extends Listenable, V>
    extends ChangeableValueConsumerBaseState<ChangeableValueBuilder<T, V>, T, V>
    with ChangeableValueBuilderBaseState<ChangeableValueBuilder<T, V>, T, V> {}

/// ---------------------------------------------------------------------

class ChangeableListener<T extends Listenable> extends ChangeableConsumerBase<T> {
  final bool Function(T listenable) listenWhen;
  final void Function(BuildContext context, T listenable) listener;
  final Widget child;

  ChangeableListener({
    T listenable,
    this.listenWhen,
    @required this.listener,
    @required this.child,
  }) : super(listenable: listenable);

  @override
  _ChangeableListenerState<T> createState() => _ChangeableListenerState<T>();
}

class _ChangeableListenerState<T extends Listenable>
    extends ChangeableConsumerBaseState<ChangeableListener<T>, T> {
  @override
  void onUpdate() {
    if (widget.listenWhen?.call(listenable) ?? true) widget.listener(context, listenable);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class ChangeableBuilder<T extends Listenable> extends ChangeableConsumerBase<T> {
  final bool Function(T listenable) buildWhen;
  final Widget Function(BuildContext context, T listenable) builder;

  ChangeableBuilder({
    T listenable,
    this.buildWhen,
    @required this.builder,
  }) : super(listenable: listenable);

  @override
  _ChangeableBuilderState<T> createState() => _ChangeableBuilderState<T>();
}

class _ChangeableBuilderState<T extends Listenable>
    extends ChangeableConsumerBaseState<ChangeableBuilder<T>, T> {
  @override
  void onUpdate() {
    if (widget.buildWhen?.call(listenable) ?? true) setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, listenable);
}

class ChangeableProvider<T extends ChangeNotifier> extends SingleChildStatelessWidget {
  final Create<T> create;
  final Dispose<T> dispose;

  ChangeableProvider({
    Key key,
    @required this.create,
    Widget child,
  })  : dispose = ((context, changeNotifier) => changeNotifier.dispose()),
        super(key: key, child: child);

  ChangeableProvider.value({
    Key key,
    @required T listenable,
    Widget child,
  })  : create = ((context) => listenable),
        dispose = null,
        super(key: key, child: child);

  static T of<T>(BuildContext context) => Provider.of<T>(context, listen: false);

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return InheritedProvider(
      create: create,
      dispose: dispose,
      child: child,
    );
  }
}
