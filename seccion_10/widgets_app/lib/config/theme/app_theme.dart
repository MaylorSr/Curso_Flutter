import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blueAccent,
  Colors.purple,
  Colors.red,
  Colors.orange,
  Colors.pinkAccent,
  Colors.black54,
];

class AppTheme {
  final int selectedColor;

  const AppTheme({
    this.selectedColor = 0,
  }) : assert(selectedColor >= 0, 'Selected color must be greater then 0');

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: false),
        colorSchemeSeed: colorList[selectedColor],
      );
}
