import 'package:cinemapedia/config/router/navigation_router.dart';
import 'package:cinemapedia/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomBottonNavigationBar extends StatelessWidget {
  const CustomBottonNavigationBar({super.key, required this.currentIndex});

  final int currentIndex;
  void _onItemTap(context, currentIndex) {
    switch (currentIndex) {
      case 0:
        NavigatorRouter.goToHome(context: context);
        break;

      case 1:
        NavigatorRouter.goToPopular(context: context);
        break;

      case 2:
        NavigatorRouter.goToFavorites(context: context);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    //* final colors = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        _onItemTap(context, value);
      },
      elevation: 0,
      enableFeedback: true,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_max_outlined),
          label: S.of(context).home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.people_outline_sharp),
          label: S.of(context).popular,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_border_outlined),
          label: S.of(context).favorites,
        ),
      ],
    );
  }
}
