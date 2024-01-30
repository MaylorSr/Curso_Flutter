import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getAllMovies({int page = 1, required String language});
  Future<List<Movie>> getPopular({int page = 1, required String language});
  Future<List<Movie>> getUpComing({int page = 1, required String language});
  Future<List<Movie>> getTopRated({int page = 1, required String language});
  Future<Movie> getMovieById({required String id, required String language});
}
