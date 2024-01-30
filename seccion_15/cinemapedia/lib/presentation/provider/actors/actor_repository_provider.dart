//* Este provider es sólo de lectura, este provider siempre está llamando a la implementación,
//* si el día de mañana cambia, cambiaríamos por ejemplo MoviesDataSource en la Impl.
import 'package:cinemapedia/infrastructure/datasources/actores_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actores_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider(
  (ref) => ActoresRepositoryImpl(dataSources: ActoresDataSource()),
);
