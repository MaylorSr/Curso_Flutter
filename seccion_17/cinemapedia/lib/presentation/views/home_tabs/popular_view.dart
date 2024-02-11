import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  ConsumerState<PopularView> createState() => _PopularViewState();
}

class _PopularViewState extends ConsumerState<PopularView>
    with AutomaticKeepAliveClientMixin {
  bool isLastPage = false;

  bool isLoadMovie = false;

  @override
  void initState() {
    //* Iniciamos la película, siempre hay que llamar al que tiene el StateNotifier
    ref.read(getAllPopularMoviesProvider.notifier).loadNextPage();

    super.initState();
  }

  void loadNextPage() async {
    isLoadMovie = true;
    ref.read(getAllPopularMoviesProvider.notifier).loadNextPage();
    isLoadMovie = false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<Movie> movies = ref.watch(getAllPopularMoviesProvider).toList();

    return Scaffold(
      body: SafeArea(
        child: MoviesMasonry(
          movie: movies,
          callback: loadNextPage,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
