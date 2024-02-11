// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/constants/assets.dart';
import 'package:cinemapedia/config/helpers/functions.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/movie_youtube.dart';
import 'package:cinemapedia/domain/usecase/cache_actor_params.dart';
import 'package:cinemapedia/domain/usecase/cache_movie_params.dart';
import 'package:cinemapedia/generated/l10n.dart';
import 'package:cinemapedia/presentation/provider/actors/actor_provider.dart';
import 'package:cinemapedia/presentation/provider/movies/movie_info_provider.dart';
import 'package:cinemapedia/presentation/provider/movies/movie_videos_provider.dart';
import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:cinemapedia/presentation/provider/storage/local_storage_provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../provider/movies/movies_similar_provider.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    final code = ref.read(languageNotifierProvider).code;
    ref.read(movieInfoProvider.notifier).loadMovieId(
          widget.movieId,
          code,
        );

    ref.read(actorInfoProvider.notifier).loadActorById(widget.movieId, code);

    ref
        .read(movieVideosProvider.notifier)
        .loadMovieVideosId(widget.movieId, code);

    ref.read(moviesSimilarProvider.notifier).getSimilarMovies(
          page: 1,
          movieId: widget.movieId,
          language: code,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[CacheMovie(
      movieId: widget.movieId,
      lang: ref.watch(languageNotifierProvider).code,
    )];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    final List<Actor>? actorsByMovieId = ref.watch(actorInfoProvider)[
        CacheActor(
            movieId: movie.id.toString(),
            lang: ref.watch(languageNotifierProvider).code)];

    if (actorsByMovieId == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    final List<MovieYoutube>? movieY =
        ref.watch(movieVideosProvider)[CacheMovie(
      movieId: movie.id.toString(),
      lang: ref.watch(languageNotifierProvider).code,
    )];

    if (movieY == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    final List<Movie>? moviesS = ref.watch(moviesSimilarProvider)[CacheMovie(
      movieId: movie.id.toString(),
      lang: ref.watch(languageNotifierProvider).code,
    )];

    if (moviesS == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          CustomSliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _MovieDetails(
                  movie: movie,
                  actores: actorsByMovieId,
                  movieY: movieY,
                  moviesS: moviesS,
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActorDetails extends ConsumerWidget {
  final List<Actor> actorsByMovieId;

  const _ActorDetails({required this.actorsByMovieId});

  @override
  Widget build(BuildContext context, ref) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.35,
      child: ListView.builder(
        itemCount: actorsByMovieId.length,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final Actor actor = actorsByMovieId[index];

          return _ActorCard(actor: actor);
        },
      ),
    );
  }
}

class _ActorCard extends StatelessWidget {
  const _ActorCard({
    required this.actor,
  });

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final textStyle = Theme.of(context).textTheme;
    return FadeInLeft(
      child: Container(
        width: size.width * 0.35,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage(
                height: 226,
                fit: BoxFit.cover,
                placeholderErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(bottleLoader);
                },
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    height: 226,
                    notFoundImage,
                    fit: BoxFit.cover,
                  );
                },
                placeholder: const AssetImage(bottleLoader),
                image: NetworkImage(actor.profilePath),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    maxLines: 2,
                    style: textStyle.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    actor.name,
                  ),
                ),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: textStyle.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  final List<Actor> actores;
  final List<MovieYoutube> movieY;
  final List<Movie> moviesS;

  const _MovieDetails({
    required this.movie,
    required this.actores,
    required this.movieY,
    required this.moviesS,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final textStyle = Theme.of(context).textTheme;

    final s = S.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Título de la movie.
          Text(
            movie.title,
            style: textStyle.titleLarge?.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          //* Descripción de la movie.
          if (movie.overview.isNotEmpty) ...[
            const SizedBoxHeight(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).review,
                  maxLines: 1,
                  style: textStyle.titleMedium?.copyWith(
                    fontSize: 19,
                  ),
                ),
                const Icon(Icons.book_rounded)
              ],
            ),
            const SizedBoxHeight(),
            Text(
              movie.overview,
              style: textStyle.bodyLarge,
            ),
          ],
          //* Géneros de la movie
          if (movie.genreIds.isNotEmpty) ...[
            const SizedBoxHeight(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Wrap(
                spacing: 10,
                children: movie.genreIds
                    .map(
                      (genre) => Chip(
                        elevation: 2,
                        label: Text(genre),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
          const SizedBoxHeight(),

          //* Actores de la película
          if (actores.isNotEmpty) ...[
            _ActorDetails(actorsByMovieId: actores),
            const SizedBoxHeight(),
          ],

          //* Video de youtube
          if (movieY.isNotEmpty) ...[
            YoutubeVideo(
              size: size,
              movieY: movieY,
            ),
            const SizedBoxHeight(),
          ],
          if (moviesS.isNotEmpty) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.recommends,
                  maxLines: 1,
                  style: textStyle.titleMedium?.copyWith(
                    fontSize: 19,
                  ),
                ),
                const SizedBoxHeight(),
                MoviesHorizontalList(movies: moviesS),
              ],
            ),
          ],

          //* Espacio al final
          SizedBox(
            height: size.height * 0.01,
          )
        ],
      ),
    );
  }
}

class YoutubeVideo extends StatefulWidget {
  final List<MovieYoutube> movieY;
  const YoutubeVideo({
    super.key,
    required this.size,
    required this.movieY,
  });

  final Size size;

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.movieY.first.key,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
        mute: false,
        controlsVisibleAtStart: true,
        showLiveFullscreenButton: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Videos',
          maxLines: 1,
          style: textStyle.titleMedium?.copyWith(
            fontSize: 19,
          ),
        ),
        Text(
          '${'Trailer'} ${[
            "${getMonth(
              context: context,
              month: widget.movieY.first.publishedAt.month,
            )} ${widget.movieY.first.publishedAt.year}"
          ]}',
          maxLines: 1,
          style: textStyle.bodyMedium?.copyWith(
            fontSize: 19,
          ),
        ),
        const SizedBoxHeight(),
        YoutubePlayer(
          width: double.infinity,
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ],
    );
  }
}

final isFavoriteProvider = FutureProvider.family.autoDispose(
  (ref, int movieId) {
    //* Para saber si la película está en favorito.
    return ref
        .watch(localStorageRepositoryProvider)
        .isMovieFavorite(movieId: movieId);
  },
);

class CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const CustomSliverAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localStorage = ref.read(localStorageRepositoryProvider);
    final Size size = MediaQuery.of(context).size;

    final isFavoriteMovie = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      centerTitle: true,
      backgroundColor: Colors.black87,
      expandedHeight: size.height * 0.6,
      actions: [
        IconButton(
          onPressed: () async {
            //* Mandamos a llamar al método
            //localStorage.toogleFavorite(movie: movie);
            await ref
                .read(favoriteMoviesProvider.notifier)
                .toggleFavorite(movie: movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          enableFeedback: true,
          iconSize: 30,
          highlightColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          icon: const Icon(
            (Icons.favorite_border_outlined),
          ),
          selectedIcon: const Icon(
            Icons.favorite_rounded,
            color: Colors.red,
          ),
          isSelected: isFavoriteMovie.when(
            data: (isFavoriteMovie) => isFavoriteMovie,
            error: (error, stackTrace) => throw UnimplementedError(),
            loading: () => false,
          ),
          /*  icon: isFavoriteMovie.when(
            data: (isFavorite) => isFavorite
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border_outlined),
            error: (_, __) => throw UnimplementedError(),
            loading: () => const CircularProgressIndicator.adaptive(),
          ), */
        ),
      ],
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: _BackgroundMovie(movie: movie),
        titlePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadiusDirectional.vertical(
              top: Radius.elliptical(40, 20),
            ),
            color: colorDesplegableLang(context: context),
          ),
          width: double.infinity,
          height: 20,
        ),
      ),
    );
  }
}

class _BackgroundMovie extends StatelessWidget {
  final Movie movie;
  const _BackgroundMovie({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.network(
            movie.posterPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[600]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.grey[300],
                  ),
                );
              }
              return FadeIn(child: child);
            },
          ),
        ),
        //* Para el título
        const _GradientShared(
          stops: [0.7, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black45,
          ],
        ),
        //* Para la flecha hacia atrás

        const _GradientShared(
          stops: [0.0, 0.4],
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            Colors.black87,
            Colors.transparent,
          ],
        ),

        //* Para el corazón

        const _GradientShared(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          stops: [0.0, 0.2],
          colors: [
            Colors.black26,
            Colors.transparent,
          ],
        ),

        /* SizedBox(
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.red,
              borderRadius: BorderRadius.vertical(top: Radius.elliptical(100, 90)),
            ),
          ),
        ), */
      ],
    );
  }
}

class _GradientShared extends StatelessWidget {
  final List<double> stops;
  final AlignmentGeometry begin;

  final List<Color> colors;

  final AlignmentGeometry end;

  const _GradientShared({
    required this.stops,
    required this.begin,
    required this.end,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: begin, end: end, stops: stops, colors: colors),
        ),
      ),
    );
  }
}
