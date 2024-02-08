import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/usecase/cache_search_movie_params.dart';
import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMovieProvider = StateProvider(
  (ref) => CacheSearchMovie(
    movieId: '',
    lang: '',
    query: '',
  ),
);

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>(
  (ref) {
    final searchMovieNotifierCallBack = ref.read(movieRepositoryProvider);

    return SearchedMoviesNotifier(
        searchedMoviesCallBack: searchMovieNotifierCallBack.getMovieBySearch,
        ref: ref);
  },
);

typedef SearchedMoviesCallBack = Future<List<Movie>> Function(
    {required String query, required String language});

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchedMoviesCallBack searchedMoviesCallBack;

  final Ref ref;
  SearchedMoviesNotifier(
      {required this.searchedMoviesCallBack, required this.ref})
      : super([]);

  Future<List<Movie>> searchedMoviesByQuery(
      {required String query, required String language}) async {
    if (language != ref.watch(languageNotifierProvider).code) {
      final List<Movie> movies =
          await searchedMoviesCallBack(query: query, language: language);

      state = movies;

      ref.read(searchMovieProvider.notifier).update(
            (state) => CacheSearchMovie(
              movieId: '',
              lang: ref.watch(languageNotifierProvider).code,
              query: query,
            ),
          );
    }

    return state;
  }
}
