import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasoruces.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/movie_youtube.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import '../models/moviedb/movie_youtube_response.dart';

/// URL para la petición
const String path = 'movie/now_playing';

const String pathPopular = 'movie/popular';

const String pathUpComing = 'movie/upcoming';

const String pathTopRated = 'movie/top_rated';

const String movieId = 'movie';

const String movieSearch = 'search/movie';

const String movieVideos = 'movie';

const String movieSimilar = 'movie';

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

  @override
  Future<Movie> getMovieById(
      {required String id, required String language}) async {
    final response =
        await dio.get("$movieId/$id", queryParameters: {'language': language});

    if (response.statusCode != 200) throw Exception('Movie id not found');

    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  @override
  Future<List<Movie>> getMovieBySearch(
      {required String query, required String language}) async {
    if (query.isEmpty) return [];
    final response = await dio.get(
      movieSearch,
      queryParameters: {
        'query': query,
        'language': language,
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<MovieYoutube>> getMovieTrailer(
      {required String id, required String language}) async {
    final response = await dio.get(
      "$movieVideos/$id/videos",
      queryParameters: {
        'language': language,
      },
    );

    final movieVideoResponse = MovieVideoResponse.fromJson(response.data);

    final List<MovieYoutube> movieVideosR = movieVideoResponse.results
        .map((e) => MovieMapper.movieYoutubeDbToEntity(e))
        .toList();

    return movieVideosR;
  }

  @override
  Future<List<Movie>> getSimilar(
      {page = 1, required String idMovie, required String language}) async {
    
      
    final movie = await dio.get('movie/$idMovie/similar', queryParameters: {
      'language' : language,
    });
    return _jsonToMovies(movie.data);
    /* final response = await dio.get(
      "movie/$movieId/similar"
    ); */

    /* print(response);
    return _jsonToMovies(response.data); */
  }
}
