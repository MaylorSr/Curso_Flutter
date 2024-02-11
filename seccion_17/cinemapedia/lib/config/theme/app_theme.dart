import 'package:flutter/material.dart';

Color colorIconMovie({required BuildContext context}) {
  return Theme.of(context).brightness == Brightness.dark
      ? colorSecondary
      : colorPrimaryLight;
}

Color colorDesplegableLang({required BuildContext context}) {
  return Theme.of(context).brightness == Brightness.dark
      ? colorSchemeSeedDark
      : colorSchemeSeedLight;
}

//* SchemeSeed
const colorSchemeSeedDark = Color(0xFF141a26);
const colorPrimary = Color(0xFF7E7E7E);
const colorSecondary = Color(0xFF40C4FF);
const colorDisabled = Color(0xFF9E9E9E);

const colorSchemeSeedLight = Color(0xFFF8F8F8);
const colorPrimaryLight = Color(0xFF28303D);

//* BottomNavigationBarTheme

const bottomNavigationBarTheme = BottomNavigationBarThemeData(
  elevation: 0,
  enableFeedback: true,
  showSelectedLabels: true,
  showUnselectedLabels: true,
  mouseCursor: MaterialStateMouseCursor.clickable,
  type: BottomNavigationBarType.fixed,
  backgroundColor: colorSchemeSeedDark,
  selectedItemColor: colorSecondary,
  unselectedItemColor: colorDisabled,
  selectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  selectedIconTheme: IconThemeData(
    size: 28,
  ),
  unselectedIconTheme: IconThemeData(size: 24),
  unselectedLabelStyle: TextStyle(
    fontSize: 13,
  ),
);

final filledButton = FilledButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(
      colorSecondary.withOpacity(0.4),
    ),
  ),
);

class AppTheme {
  final bool isDarkMode;

  //* Tamaño de los lang

  static const double withSize = 16;
  static const double heigthSize = 16;

  AppTheme({this.isDarkMode = true});

  AppTheme copyWith({bool? isDarkMode}) => AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );

  ThemeData getThemeData() => isDarkMode
      ? ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: colorSchemeSeedDark,
          bottomNavigationBarTheme: bottomNavigationBarTheme,
          filledButtonTheme: filledButton,
        )
      : ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: colorSchemeSeedLight,
          bottomNavigationBarTheme: bottomNavigationBarTheme.copyWith(
            backgroundColor: colorSchemeSeedLight,
            selectedItemColor: colorPrimaryLight,
            unselectedItemColor: colorPrimary,
          ),
          filledButtonTheme: filledButton,
        );
}
