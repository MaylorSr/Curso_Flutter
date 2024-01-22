import 'package:intl/intl.dart';

//* Clase que implementa para regresar el format number
class HumanFormat {
  static String number(double number) {
    final formatNumber =
        NumberFormat.compactCurrency(decimalDigits: 0, locale: 'en', symbol: '')
            .format(number);
    return formatNumber;
  }
}
