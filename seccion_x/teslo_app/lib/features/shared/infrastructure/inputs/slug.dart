import 'package:formz/formz.dart';

enum SlugError { empty, invalidFormat }

class Slug extends FormzInput<String, SlugError> {
  const Slug.pure() : super.pure('');

  const Slug.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == SlugError.empty) {
      return 'El campo es requerido';
    }

    if (displayError == SlugError.invalidFormat) {
      return 'Los tags deben estar separados por comas y sin espacios ni comillas. ';
    }
    return null;
  }

  @override
  SlugError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return SlugError.empty;
    }

    if (value.contains("'") || value.contains(" ")) {
      return SlugError.invalidFormat;
    }

    return null;
  }
}
