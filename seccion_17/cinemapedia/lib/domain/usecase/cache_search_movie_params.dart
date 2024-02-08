import 'package:cinemapedia/config/helpers/params.dart';

class CacheSearchMovie extends Params {
  //*Se pondrá el id de la movie almacenada en cache junto con el lenguaje selccionado.
  final String movieId;
  final String lang;
  final String query;

  CacheSearchMovie({
    required this.movieId,
    required this.lang,
    required this.query,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CacheSearchMovie &&
        other.movieId == movieId &&
        other.lang == lang && 
        other.query == query;
  }

  @override
  int get hashCode => movieId.hashCode ^ lang.hashCode;
}
