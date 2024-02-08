import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActoresRepository {
  Future<List<Actor>> getActores({required String movieId, required String language});
}
