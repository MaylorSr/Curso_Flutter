//final localStorageProvider = StateNotifierProvider((ref) => null,);

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/provider/storage/local_storage_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<LocalStorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return LocalStorageMoviesNotifier(
    localStorageRepository: localStorageRepository,
  );
});

class LocalStorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  /*
  Lo que manejara el mapa
  {
    1234 : Movie,
    12345: Movie
  }

  */

  LocalStorageMoviesNotifier({required this.localStorageRepository})
      : super({});

  //* Para saber la pagina actual.
  int page = 0;

  final LocalStorageRepository localStorageRepository;

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
      offset: page * 10,
      limit: 20,
    );

    page++;

    final Map<int, Movie> tempMoviesMap = <int, Movie>{};
    for (var movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite({required Movie movie}) async {
    await localStorageRepository.toogleFavorite(movie: movie);

    final bool isMovieInFavorite = state[movie.id] != null;

    if(isMovieInFavorite){
      state.remove(movie.id);
      state = {... state, movie.id : movie};
    }
  }
}
