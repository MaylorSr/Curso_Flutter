import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDataSource localStorageDataSource;

  LocalStorageRepositoryImpl({required this.localStorageDataSource});

  @override
  Future<bool> isMovieFavorite({required int movieId}) {
    return localStorageDataSource.isMovieFavorite(movieId: movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    return localStorageDataSource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toogleFavorite({required Movie movie}) {
    return localStorageDataSource.toogleFavorite(movie: movie);
  }
}
