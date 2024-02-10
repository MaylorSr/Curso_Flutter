import 'package:cinemapedia/config/helpers/functions.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:cinemapedia/generated/l10n.dart';
import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:cinemapedia/presentation/widgets/shared/shimmer/full_screen_loader.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
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

    /* final size = MediaQuery.of(context).size;

    final data = {
      'Popular': getPopularMoviesListView.toList(),
      'UpComing': getUpComingMoviesListView.toList(),
      'TopRated': getTopRatedMoviesListView.toList(),
      'AllMovies': getAllMoviesListView.toList(),
    }; */

    /* return CustomScrollView(
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
                  SizedBox(
                    height: size.height,
                    width: double.infinity,
                    child: ScrollableListTabScroller(
                      itemCount: data.length,
                      tabBuilder:
                          (BuildContext context, int index, bool active) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            data.keys.elementAt(index),
                            style: !active
                                ? null
                                : const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                          ),
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              color: Colors.red,
                              width: double.infinity,
                              child: Text(
                                data.keys.elementAt(index),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            ...data.values
                                .elementAt(index)
                                .asMap()
                                .map(
                                  (index, value) => MapEntry(
                                    index,
                                    ListTile(
                                      leading: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey),
                                        alignment: Alignment.center,
                                        child: Text(index.toString()),
                                      ),
                                      title: Text(value.title),
                                    ),
                                  ),
                                )
                                .values
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    ); */
    /*  return ScrollableListTabScroller(
        itemCount: data.length,
        tabBuilder: (BuildContext context, int index, bool active) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              data.keys.elementAt(index),
              style: !active
                  ? null
                  : const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
            ),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Text(
                data.keys.elementAt(index),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              ...data.values
                  .elementAt(index)
                  .asMap()
                  .map(
                    (index, value) => MapEntry(
                      index,
                      ListTile(
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          alignment: Alignment.center,
                          child: Text(index.toString()),
                        ),
                        title: Text(value.title),
                      ),
                    ),
                  )
                  .values
            ],
          );
        },
      );
 */
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
                    subTittle: getMonth(
                      month: DateTime.now().month,
                      context: context,
                    ),
                    loadNextPage: () =>
                        ref.read(getAllMoviesProvider.notifier).loadNextPage(),
                  ),
                  MoviesHorizontalList(
                    movies: getUpComingMoviesListView,
                    tittle: delegate.proxiCine,
                    subTittle: getMonth(
                      month: DateTime.now().month,
                      context: context,
                    ),
                    loadNextPage: () => ref
                        .read(getUpComingMoviesProvider.notifier)
                        .loadNextPage(),
                  ),
                  MoviesHorizontalList(
                    movies: getPopularMoviesListView,
                    tittle: delegate.popular,
                    subTittle: getMonth(
                      month: DateTime.now().month,
                      context: context,
                    ),
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
