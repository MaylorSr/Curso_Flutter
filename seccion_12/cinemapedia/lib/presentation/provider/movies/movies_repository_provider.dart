import 'package:cinemapedia/infrastructure/datasources/movies_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Este provider es sólo de lectura, este provider siempre está llamando a la implementación, 
//* si el día de mañana cambia, cambiaríamos por ejemplo MoviesDataSource en la Impl.
final movieRepositoryProvider = Provider(
  (ref) => MoviesRepositoryImpl(
    MoviesDataSource(),
  ),
);
