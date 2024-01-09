// Define los métodos, sólo dice lo que necesita, pero no realiza el método.
import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesDataSources {
  

  Future<List<Movie>> getAllMovies({int page = 1});
}