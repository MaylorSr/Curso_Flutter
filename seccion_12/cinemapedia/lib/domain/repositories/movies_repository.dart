import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepository {
  
  Future<List<Movie>> getAllMovies({int page = 1});
}