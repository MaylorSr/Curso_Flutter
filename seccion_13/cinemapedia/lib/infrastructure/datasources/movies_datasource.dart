import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasoruces.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

/// URL para la petición
const String path = 'movie/now_playing';

const String pathPopular = 'movie/popular';

const String pathUpComing = 'movie/upcoming';

const String pathTopRated = 'movie/top_rated';

class MoviesDataSource extends MoviesDataSources {
  MoviesDataSource();
  //* Definimos a nivel de clase Dio para sus respectivas configuraciones, el base options url es a nivel global esa url será génerica ya que servirá como base de todas las peticiones.
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {
        'api_key': Environment.apiKey,
      },
    ),
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final moviedbResponse = MovieDbResponse.fromJson(json);

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

  @override
  Future<List<Movie>> getAllMovies(
      {int page = 1, required String language}) async {
    final response = await dio.get(
      path,
      queryParameters: {
        'page': page,
        'language': language,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular(
      {int page = 1, required String language}) async {
    final response = await dio.get(
      pathPopular,
      queryParameters: {
        'page': page,
        'language': language,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpComing(
      {int page = 1, required String language}) async {
    final response = await dio.get(
      pathUpComing,
      queryParameters: {
        'page': page,
        'language': language,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated(
      {int page = 1, required String language}) async {
    final response = await dio.get(
      pathTopRated,
      queryParameters: {
        'page': page,
        'language': language,
      },
    );
    return _jsonToMovies(response.data);
  }
}
