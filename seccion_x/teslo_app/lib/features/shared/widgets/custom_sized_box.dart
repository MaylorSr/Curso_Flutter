import 'package:flutter/widgets.dart';

class CustomSizedBox extends StatelessWidget {
  final double? heigth;
  final double? width;
  final Widget? child;

  const CustomSizedBox({super.key, this.heigth, this.width, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: heigth,
      child: child ?? const SizedBox(),
    );
  }
}
