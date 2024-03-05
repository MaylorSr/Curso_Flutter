import 'package:formz/formz.dart';

enum StockError { empty, value }

class Stock extends FormzInput<int, StockError> {
  const Stock.pure() : super.pure(0);

  const Stock.dirty(int value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == StockError.empty) {
      return 'El campo es requerido';
    }

    if (displayError == StockError.value) {
      return 'Tiene que ser numero cero o mayor a este';
    }
    return null;
  }

  @override
  StockError? validator(int value) {
    if (value.toString().isEmpty || value.toString().trim().isEmpty) {
      return StockError.empty;
    }

    if (value <   0) {
      return StockError.value;
    }
    return null;
  }
}
