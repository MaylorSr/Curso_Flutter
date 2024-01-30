import 'package:cinemapedia/domain/datasources/actores_datasources.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actores_repository.dart';

class ActoresRepositoryImpl extends ActoresRepository {
  final ActoresDataSources dataSources;

  ActoresRepositoryImpl({required this.dataSources});

  @override
  Future<List<Actor>> getActores(
      {required String movieId, required String language}) {
    return dataSources.getActores(movieId: movieId, language: language);
  }
}
