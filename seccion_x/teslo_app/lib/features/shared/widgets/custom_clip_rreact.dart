import 'package:flutter/widgets.dart';

class CustomClipRReact extends StatelessWidget {
  final Widget child;
  const CustomClipRReact({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: child,
    );
  }
}