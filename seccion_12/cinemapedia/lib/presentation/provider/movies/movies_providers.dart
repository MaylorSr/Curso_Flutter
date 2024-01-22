//* Servirá para todos los providers. Get Movie, Get Movie id, Get Movies Popular, etc.

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_repository_provider.dart';

//* El StateNotifierProvider llama al MoviesNotifier y le dice la data que regresará
final getAllMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getAllMovies;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//* Le estoy diciendo que estoy esperando una lista de películas.
typedef MovieCallBack = Future<List<Movie>> Function({int page});

//* Es un Notifier porque me permite notificar cuando cambie el State, eso es el StateNotifierProvider
class MoviesNotifier extends StateNotifier<List<Movie>> {
  MovieCallBack fetchMoreMovies;

  // ignore: non_constant_identifier_names
  int current_page = 0;

  //* Siempre se le indica en el StateNotifier de que tipo es el objeto que enviarémos.
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  //* Sirve para cargar las páginas de manera seguida
  Future<void> loadNextPage() async {
    current_page++;

    final List<Movie> movies = await fetchMoreMovies(page: current_page);

    //* El state es un array actualmente, por ello lo vacío.
    state = [...state, ...movies];

    //* Cuando el state cambia, notificará.
  }
}
