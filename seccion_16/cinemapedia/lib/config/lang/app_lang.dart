//* Es para mostrar los lenguajes disponibles de la app, para que pueda cambiar los idiomas desde dentro.

import 'dart:ui';


const spainFlagSvg = 'assets/images/lang/spain_lang.svg';
const engFlagSvg = 'assets/images/lang/eng_lang.svg';
const frFlagSvg = 'assets/images/lang/fr_lang.svg';

final langList = <AppLanguage>[
  AppLanguage(
    code: 'es',
    flagSvg: spainFlagSvg,
  ),
  AppLanguage(
    code: 'en',
    flagSvg: engFlagSvg,
  ),
  AppLanguage(
    code: 'fr',
    flagSvg: frFlagSvg,
  ),
];

class AppLanguage {
  //*Código del lenguaje
  final String code;
  //* Bandera del lenguaje
  final String flagSvg;

  AppLanguage({
    this.code = 'es',
    this.flagSvg = spainFlagSvg,
  });

  Locale getLanguage() => Locale(code);

  AppLanguage copyWith({String? code, String? flagSvg}) => AppLanguage(
        code: code ?? this.code,
        flagSvg: flagSvg ?? this.flagSvg,
      );
}
