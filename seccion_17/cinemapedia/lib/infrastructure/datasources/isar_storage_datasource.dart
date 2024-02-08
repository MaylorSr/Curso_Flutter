import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarStorageDataSource extends LocalStorageDataSource {
  late Future<Isar> db;
  IsarStorageDataSource() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();

      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(
      Isar.getInstance(),
    );
  }

  @override
  Future<bool> isMovieFavorite({required int movieId}) async {
    final isar = await db;

    final Movie? isMovieFavorite =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    //* Si es distinto de null, es que la ha encontrado, existe.
    if (isMovieFavorite != null) {
      return true;
    }

    return false;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await db;

    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toogleFavorite({required Movie movie}) async {
    final isar = await db;

    final isMovieInFavorite =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (isMovieInFavorite != null) {
      //* Tocará borrar.
      isar.writeTxnSync(
        () => isar.movies.deleteSync(isMovieInFavorite.isarId!),
      );
      return;
    }

    //* Tocará insertarlo.

    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
