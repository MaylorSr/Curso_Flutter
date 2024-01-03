import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';
// Estado => isDarkModeProvider = true o false;

final isDarkModeProvider = StateProvider((ref) => false);

// Listado de colores inmutables que no pueden cambiar realizamos nuevo provider

final colorListProvider = Provider((ref) => colorList);

// manejamos un entero

final selectedIndexColorProdiver = StateProvider(
  (ref) => 0,
);

// Un objeto de tipo AppTheme

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

// Puede ser controller de nombre
class ThemeNotifier extends StateNotifier<AppTheme> {
  // State = Estado = new AppTheme();
  ThemeNotifier() : super(const AppTheme());

  void toggleDarkMode() {
    //! Siempre hay que poner que el state actual es igual a la copia del state que acabo de realizar.
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int index) {
    state = state.copyWith(
      selectedColor: index,
    );
  }
}
