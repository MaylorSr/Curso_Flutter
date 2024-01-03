import 'package:flutter/material.dart';

const Color customColor = Color(0xFF5C11D4);

List<Color> colorsTheme = [
  customColor,
  Colors.tealAccent,
  Colors.blueAccent,
  Colors.blue,
  Colors.white70,
  Colors.black54,
  Colors.red,
  Colors.transparent,
  Colors.blueGrey
];

class AppTheme {
  // desde fuera se manda para que sepamos que color usaremos
  final int selectedColor;

  AppTheme({required this.selectedColor})
      : assert((selectedColor < colorsTheme.length && selectedColor >= 0),
            ("Select a correct position color"));
  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorsTheme[selectedColor],
    );
  }
}
