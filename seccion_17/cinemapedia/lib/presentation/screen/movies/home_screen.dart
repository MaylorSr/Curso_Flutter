import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

const nameAppBar = "Cinemapedia";

class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';

  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<Widget> views = [
    const HomeView(),
    const PopularView(),
    const FavoritesView()
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: views,
      ),
      /* body: IndexedStack(
        index: pageIndex,
        children: views,
      ), */
      bottomNavigationBar:
          CustomBottonNavigationBar(currentIndex: widget.pageIndex),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
