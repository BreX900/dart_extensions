import 'package:flutter/widgets.dart';

/// Close the keyboard when use press on the screen
///
/// return MaterialApp(
///   builder: (context, child) => KeyboardRemover(child: child),
/// );
///
class KeyboardRemover extends StatefulWidget {
  /// The child
  final Widget child;

  const KeyboardRemover({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  _KeyboardRemoverState createState() => _KeyboardRemoverState();
}

class _KeyboardRemoverState extends State<KeyboardRemover> {
  FocusNode _focusPuller;

  final _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusPuller = Focus.of(context);
  }

  /// This method close the keyboard when the user press on the screen
  void _requestFocus() {
    if (_focusNode.hasFocus) return;
    _focusPuller.requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _requestFocus,
      child: widget.child,
    );
  }
}
