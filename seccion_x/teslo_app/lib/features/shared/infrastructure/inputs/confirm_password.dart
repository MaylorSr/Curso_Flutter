import 'package:formz/formz.dart';

enum ConfirmPasswordError { empty, notSimilar }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordError> {
  final String password;

  const ConfirmPassword.dirty(super.value, this.password) : super.dirty();
  const ConfirmPassword.pure(super.value, this.password) : super.pure();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ConfirmPasswordError.empty) {
      return 'El campo es requerido';
    }
    if (displayError == ConfirmPasswordError.notSimilar) {
      return 'Las constraseñas deben ser iguales';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ConfirmPasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return ConfirmPasswordError.empty;
    }

    if (value != password) {
      return ConfirmPasswordError.notSimilar;
    }

    return null;
  }
}
