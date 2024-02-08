import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<void> toogleFavorite({required Movie movie});

  //* Es id porque es menos pesado y el id es único
  Future<bool> isMovieFavorite({required int movieId});

  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0});
}
