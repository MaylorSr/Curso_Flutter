import 'package:flutter/material.dart';

/* General Colors */
const Color transparent = Colors.transparent;
const Color white = Colors.white;

/* General letter size */
const double min = 13;
const double medium = 16;
const double maxMedium = 20;
const double max = 24;

class AppTheme {
  final AppBarTheme _appBarTheme = const AppBarTheme(
    centerTitle: true,
    elevation: 5,
    titleTextStyle: TextStyle(
      fontSize: maxMedium,
      fontWeight: FontWeight.w600,
      color: white,
    ),
  );

  final IconButtonThemeData _iconButtonThemeData = const IconButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStatePropertyAll(1),
      alignment: Alignment.center,
      backgroundColor: MaterialStatePropertyAll(transparent),
      padding: MaterialStatePropertyAll(
        EdgeInsets.all(5),
      ),
    ),
  );

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: _appBarTheme,
        iconButtonTheme: _iconButtonThemeData,
      );
}
