import 'package:cinemapedia/domain/entities/movie_youtube.dart';
import 'package:cinemapedia/domain/usecase/cache_movie_params.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_repository_provider.dart';

final movieVideosProvider = StateNotifierProvider<MovieVideoMapNotifier,
    Map<CacheMovie, List<MovieYoutube>>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);

  return MovieVideoMapNotifier(
    getMovieVideos: (String id, String lang) async {
      return movieRepository.getMovieTrailer(id: id, language: lang);
    },
  );
});

typedef GetMovieCallBack = Future<List<MovieYoutube>> Function(
  String id,
  String lang,
);

class MovieVideoMapNotifier
    extends StateNotifier<Map<CacheMovie, List<MovieYoutube>>> {
  final GetMovieCallBack getMovieVideos;

  //* Lo inicializamos con un json vacío. Es un map String MovieYoutube.
  MovieVideoMapNotifier({required this.getMovieVideos}) : super({});

  Future<void> loadMovieVideosId(String movieId, String lang) async {
    CacheMovie cacheMovie = CacheMovie(movieId: movieId, lang: lang);
    //*Debido a que estamos instanciando, tenemos que añadirle que compare por cada campo en la clase.
    if (state[cacheMovie] != null) return;

    final movie = await getMovieVideos(movieId, lang);
    //* clona el state, es como el copyWith
    state = {...state, cacheMovie: movie};
  }
}
