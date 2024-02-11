import 'package:cinemapedia/generated/l10n.dart';
import 'package:flutter/material.dart';

String getMonth({required int month, required BuildContext context}) {
  final s = S.of(context);
  switch (month) {
    case 1:
      return s.january;
    case 2:
      return s.february;
    case 3:
      return s.march;
    case 4:
      return s.april;
    case 5:
      return s.may;
    case 6:
      return s.june;
    case 7:
      return s.july;
    case 8:
      return s.august;
    case 9:
      return s.september;
    case 10:
      return s.october;
    case 11:
      return s.november;
    case 12:
      return s.december;
    default:
      return ''; // Devuelve cadena vacía para valores de mes no válidos
  }
}
