import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/provider/storage/local_storage_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;

  bool isLoadMovie = false;

  @override
  void initState() {
    //* Iniciamos la película, siempre hay que llamar al que tiene el StateNotifier
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    super.initState();
  }

  void loadNextPage() async {
    if (isLastPage || isLoadMovie) return;
    isLoadMovie = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoadMovie = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies =
        ref.watch(favoriteMoviesProvider).values.toList();

    return Scaffold(
      body: SafeArea(
        child: MoviesMasonry(
          movie: movies,
          callback: loadNextPage ,
        ),
      ),
    );
  }
}
