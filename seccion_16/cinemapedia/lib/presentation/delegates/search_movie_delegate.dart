import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/generated/l10n.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallBack = Future<List<Movie>> Function({
  required String query,
  required String language,
});

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallBack moviescallBack;

  final List<Movie> initMovies;

  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();

  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTime;
  SearchMovieDelegate({
    required this.moviescallBack,
    required this.initMovies,
  });

  void _onQueryChange(String query) {
    if (query.isNotEmpty) isLoadingStream.add(true);
    //Sirve para cancelar el time.
    if (_debounceTime?.isActive ?? false) _debounceTime!.cancel();

    //Despues de que deje de escribir unos 500 mils despues hará la petición.
    _debounceTime = Timer(const Duration(milliseconds: 500), () async {
      /* if (query.isEmpty) {
        debounceMovies.add([]);
      } */

      final movies = await moviescallBack(
        query: query,
        language: "",
      );
      debounceMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  void clearStreams() {
    debounceMovies.close();
    isLoadingStream.close();
  }

  @override
  String get searchFieldLabel => "Buscar película";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //*Tarea, cuando empiece a escribir debe girar, si obtengo resultados debe parar
      //* de girar y mostrar la X

      StreamBuilder(
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              animate: snapshot.data!,
              infinite: snapshot.data!,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.replay_outlined),
              ),
            );
          }
          return FadeIn(
            duration: const Duration(milliseconds: 100),
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.clear),
            ),
          );
        },
      ),

      /* FadeIn(
        duration: const Duration(milliseconds: 100),
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ) */
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () {
        clearStreams();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium;

    _onQueryChange(query);

    if (query.isEmpty) {
      return const SizedBox();
    }
    return StreamBuilder<List<Movie>>(
      initialData: initMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final List<Movie> movies = snapshot.data ?? [];
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
              ),
            );

          case ConnectionState.active:
            if (movies.isEmpty) {
              return Center(
                child: Text(
                  S.of(context).notFoundMovies,
                  style: style?.copyWith(
                    fontSize: 25,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final Movie movie = snapshot.data![index];

                return _MovieSearch(
                  movie: movie,
                  onMovieSelected: (context, movie) {
                    clearStreams();
                    close(context, movie);
                  },
                );
              },
            );

          default:
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final Movie movie = snapshot.data![index];

                return _MovieSearch(
                  movie: movie,
                  onMovieSelected: close,
                );
              },
            );
        }
        /* if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de progreso circular durante el primer segundo.
          return const CircularProgressIndicator.adaptive(
            strokeWidth: 2,
          );
        } */
      },
      /*  builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        if (movies.isEmpty) {
          final style = Theme.of(context).textTheme.titleMedium;
          return Center(
            child: FutureBuilder(
              future: moviescallBack(query: query, language: ""),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Muestra un indicador de progreso circular durante el primer segundo.
                  return const CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                  );
                } else {
                  // Después del primer segundo, si la lista de películas está vacía, muestra el texto.
                  return Text(
                    S.of(context).notFoundMovies,
                    style: style?.copyWith(
                      fontSize: 25,
                    ),
                  );
                }
              },
            ),
          );
        }

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final Movie movie = snapshot.data![index];

            return _MovieSearch(
              movie: movie,
              onMovieSelected: close,
            );
          },
        );
      }, */
    );
  }
}

class _MovieSearch extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieSearch({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final style = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        /* NavigatorRouter.goToMovieId(
          context: context,
          id: movie.id,
        ); */
        onMovieSelected(context, movie);
      },
      child: FadeInRight(
        child: Card(
          elevation: 5,
          shadowColor: Colors.black87,
          color: Theme.of(context).colorScheme.onPrimary,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: movie.posterPath,
                    fit: BoxFit.contain,
                    width: size.width * 0.35,
                    errorWidget: (context, url, error) {
                      //TODO: mostrar not found movie. Image assets.
                      return const SizedBox();
                    },
                  ),
                ),
                //* Para decirle que ocupe el resto que queda
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          movie.title,
                          style: style.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        movie.overview.length > 100
                            //*El substring lo que hace es pillar de que caracter a que carter se mostrará.
                            ? Text(
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                "${movie.overview.substring(0, 100)} ...",
                                style: style.bodyMedium,
                              )
                            : Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                movie.overview,
                                style: style.bodyMedium),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_half_outlined,
                              color: Colors.yellow.shade800,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              HumanFormat.number(movie.voteAverage,
                                  decimals: 1),
                              style: style.bodyMedium
                                  ?.copyWith(color: Colors.yellow.shade800),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
