import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActoresDataSources {
  ActoresDataSources();

  Future<List<Actor>> getActores({required String movieId, required String language});
}
