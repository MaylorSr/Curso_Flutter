import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/actordb/actor_actordb.dart';

const String urlBaseImagen = "https://image.tmdb.org/t/p/w500";

class ActorMapper {
  static Actor actorDbToEntity({required Cast cast}) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? "$urlBaseImagen/${cast.profilePath}"
          : 'no-path',
    );
  }
}
