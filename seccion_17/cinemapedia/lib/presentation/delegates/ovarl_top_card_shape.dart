import 'package:flutter/widgets.dart';

class OvalTopCardShape extends RoundedRectangleBorder {
  OvalTopCardShape({double borderRadius = 0.0})
      : super(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(borderRadius),
          ),
        );

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
  const double inwardHeight = 20.0; // Ajusta según sea necesario
  final Path path = Path();

  // Dibuja la parte superior del rectángulo del Card
  path.moveTo(rect.left, rect.top + inwardHeight);
  path.lineTo(rect.right, rect.top + inwardHeight);

  // Dibuja el arco superior del círculo (parte transparente)
  path.arcTo(
    Rect.fromCircle(center: Offset(rect.center.dx, rect.top + inwardHeight), radius: 40.0), // Ajusta el radio según sea necesario
    0, // Ángulo de inicio
    3.14, // Ángulo de cierre
    false,
  );

  // Dibuja el resto del rectángulo del Card
  path.lineTo(rect.left, rect.bottom);
  path.lineTo(rect.right, rect.bottom);

  path.close();
  return path;
}

}
