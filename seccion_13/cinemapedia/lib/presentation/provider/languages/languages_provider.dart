import 'package:cinemapedia/config/lang/app_lang.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Lista de lenguajes
final languageListProvider = Provider<List<AppLanguage>>((ref) => langList);

//* Sirve para saber cual es el lenguaje seleccionado actualmente.
final languageNotifierProvider =
    StateNotifierProvider<LanguageNotifier, AppLanguage>((ref) {
  return LanguageNotifier();
});

// Puede ser controller de nombre
class LanguageNotifier extends StateNotifier<AppLanguage> {
  // State = Estado = new AppLanguage();
  LanguageNotifier() : super(AppLanguage());

  void changeLanguage(AppLanguage language) {
    state = state.copyWith(
      code: language.code,
      flagSvg: language.flagSvg,
    );
  }
}
