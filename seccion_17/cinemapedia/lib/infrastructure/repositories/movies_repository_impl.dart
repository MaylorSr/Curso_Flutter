//* Se puede poner también como movies_datasource_impl ya que es una implementación de la capa domain -> repositories -> repository.

import 'package:cinemapedia/domain/datasources/movies_datasoruces.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/movie_youtube.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  //* Implementamos el datasource por si queremos llamar a más de algún método aquí mísmo
  final MoviesDataSources dataSource;

  MoviesRepositoryImpl(this.dataSource);

  @override
  Future<List<Movie>> getAllMovies({
    int page = 1,
    required String language,
  }) {
    return dataSource.getAllMovies(page: page, language: language);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1, required String language}) {
    return dataSource.getPopular(page: page, language: language);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1, required String language}) {
    return dataSource.getTopRated(page: page, language: language);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1, required String language}) {
    return dataSource.getUpComing(page: page, language: language);
  }

  @override
  Future<Movie> getMovieById({required String id, required String language}) {
    return dataSource.getMovieById(id: id, language: language);
  }

  @override
  Future<List<Movie>> getMovieBySearch(
      {required String query, required String language}) {
    return dataSource.getMovieBySearch(query: query, language: language);
  }

  @override
  Future<List<MovieYoutube>> getMovieTrailer(
      {required String id, required String language}) {
    return dataSource.getMovieTrailer(id: id, language: language);
  }

  @override
  Future<List<Movie>> getSimilar(
      {page = 1, required String idMovie, required String language}) {
    return dataSource.getSimilar(
        page: page, idMovie: idMovie, language: language);
  }
}
