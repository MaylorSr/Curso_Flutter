import 'package:cinemapedia/config/helpers/params.dart';

class CacheMovie extends Params {
  //*Se pondrá el id de la movie almacenada en cache junto con el lenguaje selccionado.
  final String movieId;
  final String lang;
  CacheMovie({
    required this.movieId,
    required this.lang,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CacheMovie &&
        other.movieId == movieId &&
        other.lang == lang;
  }

  @override
  int get hashCode => movieId.hashCode ^ lang.hashCode;
}
