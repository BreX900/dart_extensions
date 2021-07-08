import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_extensions/src/widgets/listenable/listenable_consumer_base.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ValueListenableListener<T> extends ChangeableValueListener<ValueListenable<T>, T> {
  ValueListenableListener({
    Key? key,
    ValueListenable<T>? listenable,
    bool Function(T before, T after)? listenWhen,
    required void Function(BuildContext context, T value) listener,
    required Widget child,
  }) : super(
          key: key,
          listenable: listenable,
          selector: (listenable) => listenable.value,
          listenWhen: listenWhen,
          listener: listener,
          child: child,
        );
}

class ChangeableValueListener<T extends Listenable, V> extends SingleChildStatefulWidget
    implements ChangeableConsumerRule<T> {
  final T? listenable;
  final V Function(T listeneble) selector;
  final bool Function(V previous, V current)? listenWhen;
  final void Function(BuildContext context, V value) listener;

  ChangeableValueListener({
    Key? key,
    this.listenable,
    required this.selector,
    this.listenWhen,
    required this.listener,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  _ChangeableValueListenerState<T, V> createState() => _ChangeableValueListenerState<T, V>();
}

class _ChangeableValueListenerState<T extends Listenable, V>
    extends SingleChildState<ChangeableValueListener<T, V>>
    with ChangeableConsumerStateMixin<ChangeableValueListener<T, V>, T> {
  late V _value;

  @override
  void initState() {
    super.initState();
    _value = widget.selector(listenable);
  }

  @override
  void onListenableChanges() {
    final nextValue = widget.selector(listenable);
    if (widget.listenWhen?.call(_value, nextValue) ?? true) widget.listener(context, _value);
    _value = nextValue;
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => child!;
}

class ChangeableValueBuilder<T extends Listenable, V> extends StatefulWidget
    implements ChangeableValueConsumerRule<T, V> {
  final T? listenable;
  final V Function(T listeneble) selector;
  final bool Function(V previous, V current)? buildWhen;
  final Widget Function(BuildContext context, V value) builder;

  ChangeableValueBuilder({
    Key? key,
    this.listenable,
    required this.selector,
    this.buildWhen,
    required this.builder,
  }) : super(key: key);

  @override
  _ChangeableValueBuilderState<T, V> createState() => _ChangeableValueBuilderState<T, V>();
}

class _ChangeableValueBuilderState<T extends Listenable, V>
    extends State<ChangeableValueBuilder<T, V>>
    with
        ChangeableConsumerStateMixin<ChangeableValueBuilder<T, V>, T>,
        ChangeableValueConsumerStateMixin<ChangeableValueBuilder<T, V>, T, V> {
  @override
  void onValueChanges(V previous, V current) {
    if (widget.buildWhen?.call(previous, current) ?? true) setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, value);
}

class ChangeableValueConsumer<T extends Listenable, V> extends StatefulWidget
    implements ChangeableValueConsumerRule<T, V> {
  final T? listenable;
  final V Function(T listenable) selector;
  final bool Function(V before, V after)? listenWhen;
  final void Function(BuildContext context, V value) listener;
  final bool Function(V before, V after)? buildWhen;
  final Widget Function(BuildContext context, V value) builder;

  ChangeableValueConsumer({
    Key? key,
    this.listenable,
    required this.selector,
    this.listenWhen,
    required this.listener,
    this.buildWhen,
    required this.builder,
  }) : super(key: key);

  @override
  _ChangeableValueConsumerState<T, V> createState() => _ChangeableValueConsumerState<T, V>();
}

class _ChangeableValueConsumerState<T extends Listenable, V>
    extends State<ChangeableValueConsumer<T, V>>
    with
        ChangeableConsumerStateMixin<ChangeableValueConsumer<T, V>, T>,
        ChangeableValueConsumerStateMixin<ChangeableValueConsumer<T, V>, T, V> {
  @override
  void onValueChanges(V previous, V current) {
    if (widget.listenWhen?.call(previous, current) ?? true) widget.listener(context, current);
    if (widget.buildWhen?.call(previous, current) ?? true) setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, value);
}

/// ---------------------------------------------------------------------

class ChangeableListener<T extends Listenable> extends SingleChildStatefulWidget
    with ChangeableConsumerRule<T> {
  final T? listenable;
  final bool Function(T listenable)? listenWhen;
  final void Function(BuildContext context, T listenable) listener;

  ChangeableListener({
    this.listenable,
    this.listenWhen,
    required this.listener,
    Widget? child,
  }) : super(child: child);

  @override
  _ChangeableListenerState<T> createState() => _ChangeableListenerState<T>();
}

class _ChangeableListenerState<T extends Listenable> extends SingleChildState<ChangeableListener<T>>
    with ChangeableConsumerStateMixin<ChangeableListener<T>, T> {
  @override
  void onListenableChanges() {
    if (widget.listenWhen?.call(listenable) ?? true) widget.listener(context, listenable);
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => child!;
}

class ChangeableBuilder<T extends Listenable> extends StatefulWidget
    implements ChangeableConsumerRule<T> {
  final T? listenable;
  final bool Function(T listenable)? buildWhen;
  final Widget Function(BuildContext context, T listenable) builder;

  ChangeableBuilder({
    this.listenable,
    this.buildWhen,
    required this.builder,
  }) : super();

  @override
  _ChangeableBuilderState<T> createState() => _ChangeableBuilderState<T>();
}

class _ChangeableBuilderState<T extends Listenable> extends State<ChangeableBuilder<T>>
    with ChangeableConsumerStateMixin<ChangeableBuilder<T>, T> {
  @override
  void onListenableChanges() {
    if (widget.buildWhen?.call(listenable) ?? true) setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, listenable);
}

class ChangeableConsumer<T extends Listenable> extends StatefulWidget
    implements ChangeableConsumerRule<T> {
  final T? listenable;
  final bool Function(T listenable)? listenWhen;
  final bool Function(T listenable)? buildWhen;
  final Widget Function(BuildContext context, T listenable) listener;
  final Widget Function(BuildContext context, T listenable) builder;

  ChangeableConsumer({
    this.listenable,
    this.listenWhen,
    this.buildWhen,
    required this.listener,
    required this.builder,
  }) : super();

  @override
  _ChangeableBuilderState<T> createState() => _ChangeableBuilderState<T>();
}

class ChangeableConsumerState<T extends Listenable> extends State<ChangeableConsumer<T>>
    with ChangeableConsumerStateMixin<ChangeableConsumer<T>, T> {
  @override
  void onListenableChanges() {
    if (widget.listenWhen?.call(listenable) ?? true) widget.listener(context, listenable);
    if (widget.buildWhen?.call(listenable) ?? true) setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, listenable);
}

class ChangeableProvider<T extends ChangeNotifier> extends SingleChildStatelessWidget {
  final Create<T> create;
  final Dispose<T>? dispose;

  ChangeableProvider({
    required Key key,
    required this.create,
    required Widget child,
  })  : dispose = ((context, changeNotifier) => changeNotifier.dispose()),
        super(key: key, child: child);

  ChangeableProvider.value({
    required Key key,
    required T listenable,
    required Widget child,
  })  : create = ((context) => listenable),
        dispose = null,
        super(key: key, child: child);

  static T of<T>(BuildContext context) => Provider.of<T>(context, listen: false);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return InheritedProvider(
      create: create,
      dispose: dispose!,
      child: child,
    );
  }
}
