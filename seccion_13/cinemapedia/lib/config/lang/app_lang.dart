//* Es para mostrar los lenguajes disponibles de la app, para que pueda cambiar los idiomas desde dentro.

import 'dart:ui';

final langList = <AppLanguage>[
  AppLanguage(
    code: 'es',
    flagSvg: '',
  ),
  AppLanguage(
    code: 'en',
    flagSvg: '',
  ),
  AppLanguage(
    code: 'fr',
    flagSvg: '',
  ),
];

class AppLanguage {
  //*Código del lenguaje
  final String code;
  //* Bandera del lenguaje
  final String flagSvg;

  AppLanguage({
    this.code = 'es',
    this.flagSvg = '',
  });

  Locale getLanguage() => Locale(code);

  AppLanguage copyWith({String? code, String? flagSvg}) => AppLanguage(
        code: code ?? this.code,
        flagSvg: flagSvg ?? this.flagSvg,
      );
}
