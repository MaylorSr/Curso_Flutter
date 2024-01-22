import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Le estoy diciendo que voy a enviar una lista de películas de tanto a tanto que yo quiero,
//* como tengo la ref que puedo entrarle a todos los providers, puedo acceder a la lista.
final movieSlideShow = Provider<List<Movie>>((ref) {
  final moviesProvider = ref.watch(getAllMoviesProvider);

  if (moviesProvider.isEmpty) return [];

//* Le digo que mande ahora sólo del primer elemento al 6
  return moviesProvider.sublist(0, 6);
});
