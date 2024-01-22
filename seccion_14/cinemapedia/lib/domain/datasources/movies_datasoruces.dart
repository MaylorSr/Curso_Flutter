// Define los métodos, sólo dice lo que necesita, pero no realiza el método.
import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesDataSources {
  MoviesDataSources();

  Future<List<Movie>> getAllMovies({int page = 1, required String language});

  Future<List<Movie>> getPopular({int page = 1, required String language});

  Future<List<Movie>> getUpComing({int page = 1, required String language});

  Future<List<Movie>> getTopRated({int page = 1, required String language});
}
