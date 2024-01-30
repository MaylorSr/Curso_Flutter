import 'package:cinemapedia/config/helpers/params.dart';

class CacheActor extends Params {
  //*Se pondrá el id de la movie almacenada en cache junto con el lenguaje selccionado.
  final String movieId;
  final String lang;
  
  CacheActor({
    required this.movieId,
    required this.lang,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CacheActor &&
        other.movieId == movieId &&
        other.lang == lang;
  }

  @override
  int get hashCode => movieId.hashCode ^ lang.hashCode;
}
