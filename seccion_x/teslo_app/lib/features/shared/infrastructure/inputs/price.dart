import 'package:formz/formz.dart';

enum PriceError { empty, value }

class Price extends FormzInput<double, PriceError> {
  const Price.pure() : super.pure(0.0);

  const Price.dirty(double value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PriceError.empty) {
      return 'El campo es requerido';
    }

    if (displayError == PriceError.value) {
      return 'Tiene que ser numero cero o mayor a este';
    }
    return null;
  }

  @override
  PriceError? validator(double value) {
    if (value.toString().isEmpty || value.toString().trim().isEmpty) {
      return PriceError.empty;
    }

    if (value < 0) {
      return PriceError.value;
    }
    return null;
  }
}
