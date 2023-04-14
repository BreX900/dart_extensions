import 'package:flutter/widgets.dart';

/// Close the keyboard when use press on the screen
///
/// return MaterialApp(
///   builder: (context, child) => KeyboardRemover(child: child),
/// );
///
class KeyboardRemover extends StatelessWidget {
  final Widget child;

  const KeyboardRemover({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
