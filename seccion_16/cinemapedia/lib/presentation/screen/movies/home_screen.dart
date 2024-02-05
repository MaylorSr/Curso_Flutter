import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

const nameAppBar = "Cinemapedia";

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  final List<Widget> views = [
    const HomeView(),
    const SizedBox(),
    const FavoritesView()
  ];

  final int pageIndex;
  HomeScreen({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: views,
      ),
      bottomNavigationBar: CustomBottonNavigationBar(currentIndex : pageIndex),
    );
  }
}
