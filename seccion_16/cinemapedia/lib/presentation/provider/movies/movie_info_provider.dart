import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/usecase/cache_movie_params.dart';
import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<CacheMovie, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(
    getMovie: (String id, String lang) async {
      return movieRepository.getMovieById(id: id, language: lang);
    },
  );
});

typedef GetMovieCallBack = Future<Movie> Function(
  String id,
  String lang,
);

class MovieMapNotifier extends StateNotifier<Map<CacheMovie, Movie>> {
  final GetMovieCallBack getMovie;

  //* Lo inicializamos con un json vacío. Es un map String Movie.
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovieId(String movieId, String lang) async {
    //* Pedimos un objeto tipo cacheMovie, quiere decir que le pasaremos
    //* el id de la película y el lenguaje, en caso de que hayamos cargado esa película con el lenguaje seleccionado, return dicha Movie, en caso contrario hacemos la petición para obtener dicha movie.
    CacheMovie cacheMovie = CacheMovie(movieId: movieId, lang: lang);
    //*Debido a que estamos instanciando, tenemos que añadirle que compare por cada campo en la clase.
    if (state[cacheMovie] != null) return;

    final movie = await getMovie(movieId, lang);
    //* clona el state, es como el copyWith
    state = {...state, cacheMovie: movie};
  }
}
