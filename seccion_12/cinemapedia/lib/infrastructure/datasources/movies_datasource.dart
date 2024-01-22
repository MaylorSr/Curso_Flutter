import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasoruces.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

/// URL para la petición
String path = 'movie/now_playing';

class MoviesDataSource extends MoviesDataSources {
  //* Definimos a nivel de clase Dio para sus respectivas configuraciones, el base options url es a nivel global esa url será génerica ya que servirá como base de todas las peticiones.
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3/', queryParameters: {
      'api_key': Environment.apiKey,
      'language': Environment.language
    }),
  );

  @override
  Future<List<Movie>> getAllMovies({int page = 1}) async {
    final response = await dio.get(path);

    final moviedbResponse = MovieDbResponse.fromJson(
      response.data,
    );

    // De moviedbResponse paso a MovieMapper y este es el que me pasa a mi entidad.

    final List<Movie> movies = moviedbResponse.results
        //* Si tiene poster pasa, si no; no se muestra
        .where(
          (element) => element.posterPath != 'no-poster',
        )
        .map(
          (e) => MovieMapper.movieDbToEntity(e),
        )
        .toList();

    return movies;
  }
}
