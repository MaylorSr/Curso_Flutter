import 'package:cinemapedia/generated/l10n.dart';
import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const nameAppBar = "Cinemapedia";

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottonNavigationBar(),
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    //* Se pone en el init State
    ref.read(getAllMoviesProvider.notifier).loadNextPage();
    ref.read(getAllPopularMoviesProvider.notifier).loadNextPage();
    ref.read(getUpComingMoviesProvider.notifier).loadNextPage();
    ref.read(getTopRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    //*final getAllMovies = ref.watch(getAllMoviesProvider);
    final initialLoading = ref.watch(initalLoadingProvider);

    if (initialLoading) return const FullScreenLoader();
    final getMoviesSlideShow = ref.watch(movieSlideShow);

    final getAllMoviesListView = ref.watch(getAllMoviesProvider);

    final getPopularMoviesListView = ref.watch(getAllPopularMoviesProvider);
 
    final getUpComingMoviesListView = ref.watch(getUpComingMoviesProvider);

    final getTopRatedMoviesListView = ref.watch(getTopRatedMoviesProvider);

    final delegate = S.of(context);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: CustomAppBar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlideShow(movies: getMoviesSlideShow),
                  MoviesHorizontalList(
                    movies: getAllMoviesListView,
                    tittle: delegate.cine,
                    subTittle: '20 Julio',
                    loadNextPage: () =>
                        ref.read(getAllMoviesProvider.notifier).loadNextPage(),
                  ),
                  MoviesHorizontalList(
                    movies: getUpComingMoviesListView,
                    tittle: delegate.proxiCine,
                    subTittle: '20 Julio',
                    loadNextPage: () => ref
                        .read(getUpComingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MoviesHorizontalList(
                    movies: getPopularMoviesListView,
                    tittle: delegate.popular,
                    subTittle: '20 Julio',
                    loadNextPage: () => ref
                        .read(getAllPopularMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MoviesHorizontalList(
                    movies: getTopRatedMoviesListView,
                    tittle: delegate.bestRate,
                    subTittle: delegate.bestRate,
                    loadNextPage: () => ref
                        .read(getTopRatedMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
