import 'package:flutter/cupertino.dart';

typedef ValueBuilder<TValue> = Widget Function(BuildContext context, TValue value);

typedef ValueListener<TValue> = void Function(BuildContext context, TValue value);

typedef ValueCondition<TValue> = bool Function(TValue previous, TValue current);
