import 'package:cinemapedia/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomBottonNavigationBar extends StatelessWidget {
  const CustomBottonNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BottomNavigationBar(currentIndex: 0, items: [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_max_outlined),
        label: S.of(context).home,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.category_outlined),
        label: S.of(context).categories,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.favorite_border_outlined),
        label: S.of(context).favorites,
      ),
    ]);
  }
}
