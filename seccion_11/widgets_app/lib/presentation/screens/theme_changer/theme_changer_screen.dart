import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  static const String name = 'theme_changer_screen';

  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Changer Screen'),
        actions: [
          IconButton(
            // onPressed: () => ref.read(isDarkModeProvider.notifier).update(
            //       (state) => !state,
            //     ),
            onPressed: () =>
                ref.read(themeNotifierProvider.notifier).toggleDarkMode(),
            icon: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, ref) {
    final colors = ref.watch(colorListProvider);
    final int selectedIndexColor =
        ref.watch(themeNotifierProvider).selectedColor;

    // methods
    // final selectedIndexColorChange =
    //     ref.read(selectedIndexColorProdiver.notifier);

    final selectedIndexColorChange = ref.read(themeNotifierProvider.notifier);

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final color = colors[index];
        return RadioListTile(
          title: Text(
            'Este color',
            style: TextStyle(
              color: color,
            ),
          ),
          subtitle: Text(
            color.value.toString(),
          ),
          activeColor: color,
          value: index,
          groupValue: selectedIndexColor,
          onChanged: (value) {
            // como no necesito el state anterior no lo uso aqui
            // selectedIndexColorChange.update((_) => value!);
            selectedIndexColorChange.changeColorIndex(value!);
          },
        );
      },
    );
  }
}
