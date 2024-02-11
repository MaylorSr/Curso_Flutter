import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/usecase/cache_movie_params.dart';
import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSimilarProvider = StateNotifierProvider<MoviesSimilarStateNotifier,
    Map<CacheMovie, List<Movie>>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);

  return MoviesSimilarStateNotifier(
    callBack: (
        {required String movieId,
        required String language,
        required int page}) async {
      return movieRepository.getSimilar(
        idMovie: movieId,
        language: language,
        page: page,
      );
    },
  );
});

typedef MoviesSimilarCallBack = Future<List<Movie>> Function({
  required int page,
  required String movieId,
  required String language,
});

class MoviesSimilarStateNotifier
    extends StateNotifier<Map<CacheMovie, List<Movie>>> {
  MoviesSimilarStateNotifier({required this.callBack}) : super({});

  final MoviesSimilarCallBack callBack;

  Future<void> getSimilarMovies(
      {required int page,
      required String movieId,
      required String language}) async {
    CacheMovie cacheMovie = CacheMovie(
      movieId: movieId,
      lang: language,
    );

    if (state[cacheMovie] != null) return;

    final List<Movie> movies = await callBack(
      language: language,
      movieId: movieId,
      page: page,
    );

    state = {...state, cacheMovie: movies};
  }
}
