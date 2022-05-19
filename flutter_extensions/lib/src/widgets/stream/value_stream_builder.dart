import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_extensions/src/utility/typedef.dart';
import 'package:flutter_extensions/src/widgets/stream/value_stream_listener.dart';

class ValueStreamBuilder<TValue> extends StatefulWidget {
  final TValue initialValue;
  final Stream<TValue>? stream;
  final ValueCondition<TValue>? buildWhen;
  final ValueBuilder<TValue> builder;

  const ValueStreamBuilder({
    Key? key,
    required this.initialValue,
    this.stream,
    this.buildWhen,
    required this.builder,
  }) : super(key: key);

  @override
  State<ValueStreamBuilder<TValue>> createState() => _ValueStreamBuilderState();
}

class _ValueStreamBuilderState<TValue> extends State<ValueStreamBuilder<TValue>> {
  late TValue _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ValueStreamListener<TValue>(
      stream: widget.stream,
      listenWhen: widget.buildWhen,
      listener: (context, value) {
        setState(() {
          _value = value;
        });
      },
      child: widget.builder(context, _value),
    );
  }
}
