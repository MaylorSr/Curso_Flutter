import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Estado => isDarkModeProvider = true o false;

final isDarkModeProvider = StateProvider((ref) => false);

// Un objeto de tipo AppTheme

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

// Puede ser controller de nombre
class ThemeNotifier extends StateNotifier<AppTheme> {
  // State = Estado = new AppTheme();
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    //! Siempre hay que poner que el state actual es igual a la copia del state que acabo de realizar.
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }
}
