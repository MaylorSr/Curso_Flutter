import 'package:intl/intl.dart';

//* Clase que implementa para regresar el format number
class HumanFormat {
  static String number(double number, {int decimals = 0}) {
    final formatNumber = NumberFormat.compactCurrency(
            decimalDigits: decimals, locale: 'en', symbol: '')
        .format(number);
    return formatNumber;
  }
}
