import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_extensions/src/utility/typedef.dart';
import 'package:flutter_extensions/src/widgets/stream/value_stream_listener.dart';

class ValueStreamConsumer<TValue> extends StatefulWidget {
  final TValue initialValue;
  final Stream<TValue>? stream;
  final ValueCondition<TValue>? listenWhen;
  final ValueListener<TValue> listener;
  final ValueCondition<TValue>? buildWhen;
  final ValueBuilder<TValue> builder;

  const ValueStreamConsumer({
    Key? key,
    required this.initialValue,
    this.stream,
    this.listenWhen,
    required this.listener,
    this.buildWhen,
    required this.builder,
  }) : super(key: key);

  @override
  State<ValueStreamConsumer<TValue>> createState() => _ValueStreamConsumerState();
}

class _ValueStreamConsumerState<TValue> extends State<ValueStreamConsumer<TValue>> {
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
      listenWhen: (previous, current) {
        if (widget.listenWhen?.call(previous, current) ?? true) {
          widget.listener(context, current);
        }
        return widget.buildWhen?.call(previous, current) ?? true;
      },
      listener: (context, value) {
        setState(() {
          _value = value;
        });
      },
      child: widget.builder(context, _value),
    );
  }
}
