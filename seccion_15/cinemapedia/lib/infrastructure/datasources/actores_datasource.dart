import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actores_datasources.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/actordb/actor_response.dart';
import 'package:dio/dio.dart';

const String actoresByMovieId = 'movie';

class ActoresDataSource extends ActoresDataSources {
  //* Definimos a nivel de clase Dio para sus respectivas configuraciones, el base options url es a nivel global esa url será génerica ya que servirá como base de todas las peticiones.
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {
        'api_key': Environment.apiKey,
      },
    ),
  );

  List<Actor> _jsonToActores(Map<String, dynamic> json) {
    final actoresdbResponse = ActorResponse.fromJson(json);

    final List<Actor> actores = actoresdbResponse.cast
        //* Si tiene poster pasa, si no; no se muestra
        .where(
          (element) => element.profilePath != 'no-poster',
        )
        .map(
          (e) => ActorMapper.actorDbToEntity(cast: e),
        )
        .toList();

    return actores;
  }

  @override
  Future<List<Actor>> getActores(
      {required String movieId, required String language}) async {
    final response = await dio.get("$actoresByMovieId/$movieId/credits",
        queryParameters: {'language': language});

    if (response.statusCode != 200) throw Exception('Not found movie');

    final List<Actor> actores = _jsonToActores(response.data);
    return actores;
  }
}
