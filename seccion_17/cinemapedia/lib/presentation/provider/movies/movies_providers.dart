//* Servirá para todos los providers. Get Movie, Get Movie id, Get Movies Popular, etc.

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

//* El StateNotifierProvider llama al MoviesNotifier y le dice la data que regresará
final getAllMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getAllMovies;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
    language: 'es'
  );
});

final getAllPopularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
    language: 'es',
  );
});

final getUpComingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpComing;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
    language: 'es',
  );
});

final getTopRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
    language: 'es',
  );
});

//* Le estoy diciendo que estoy esperando una lista de películas.
typedef MovieCallBack = Future<List<Movie>> Function({
  int page,
  required String language,
});

//* Es un Notifier porque me permite notificar cuando cambie el State, eso es el StateNotifierProvider
class MoviesNotifier extends StateNotifier<List<Movie>> {
  MovieCallBack fetchMoreMovies;

  // ignore: non_constant_identifier_names
  int current_page = 0;

  String language;

  bool isLoading = false;

  //* Siempre se le indica en el StateNotifier de que tipo es el objeto que enviarémos.
  MoviesNotifier({required this.fetchMoreMovies, required this.language})
      : super([]);

  //* Sirve para cargar las páginas de manera seguida
  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    current_page++;

    final List<Movie> movies = await fetchMoreMovies(
      page: current_page,
      language: language,
    );

    //* El state es un array actualmente, por ello lo vacío.
    state = [...state, ...movies];
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => isLoading = false,
    );

    //* Cuando el state cambia, notificará.
  }
}
