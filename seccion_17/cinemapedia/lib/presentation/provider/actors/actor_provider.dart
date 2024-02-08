import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/usecase/cache_actor_params.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'actor_repository_provider.dart';

final actorInfoProvider =
    StateNotifierProvider<ActorMapNotifier, Map<CacheActor, List<Actor>>>(
        (ref) {
  final actorRepository = ref.watch(actorRepositoryProvider);

  return ActorMapNotifier(
    getActor: (String id, String lang) async {
      return actorRepository.getActores(
        movieId: id,
        language: lang,
      );
    },
  );
});

typedef GetActorCallBack = Future<List<Actor>> Function(
  String id,
  String lang,
);

class ActorMapNotifier extends StateNotifier<Map<CacheActor, List<Actor>>> {
  final GetActorCallBack getActor;

  //* Lo inicializamos con un json vacío. Es un map String Movie.
  ActorMapNotifier({required this.getActor}) : super({});

  Future<void> loadActorById(String movieId, String lang) async {
    CacheActor cacheActor = CacheActor(movieId: movieId, lang: lang);

    if (state[cacheActor] != null) return;

    final List<Actor> actors = await getActor(movieId, lang);

    state = {...state, cacheActor: actors};

  }
}
