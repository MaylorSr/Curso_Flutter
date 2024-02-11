import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/movie_youtube.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getAllMovies({int page = 1, required String language});
  Future<List<Movie>> getPopular({int page = 1, required String language});
  Future<List<Movie>> getUpComing({int page = 1, required String language});
  Future<List<Movie>> getTopRated({int page = 1, required String language});
  Future<Movie> getMovieById({required String id, required String language});
  Future<List<Movie>> getMovieBySearch({
    required String query,
    required String language,
  });

  Future<List<MovieYoutube>> getMovieTrailer(
      {required String id, required String language});

  Future<List<Movie>> getSimilar(
      {page = 1, required String idMovie, required String language});
}
