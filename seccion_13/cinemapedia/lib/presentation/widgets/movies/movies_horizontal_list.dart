import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesHorizontalList extends StatefulWidget {
  const MoviesHorizontalList({
    super.key,
    required this.movies,
    this.tittle,
    this.subTittle,
    this.loadNextPage,
  });

  final List<Movie> movies;

  final String? tittle;

  final String? subTittle;

  final VoidCallback? loadNextPage;

  @override
  State<MoviesHorizontalList> createState() => _MoviesHorizontalListState();
}

class _MoviesHorizontalListState extends State<MoviesHorizontalList> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      //* Ha llegado al final, tiene que cargar más películas
      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.tittle != null || widget.subTittle != null)
            _TittleWidget(tittle: widget.tittle, subTittle: widget.subTittle),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                final movie = widget.movies[index];
                return FadeInRight(
                  child: _SlideMovie(
                    movie: movie,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideMovie extends StatelessWidget {
  final Movie movie;
  const _SlideMovie({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                //* Para que todas tengan el mismo espacio
                fit: BoxFit.cover,
                movie.posterPath,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          //* Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: titleStyle.titleSmall,
            ),
          ),
          //*Rate
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(
                  Icons.star_half_outlined,
                  color: Colors.yellow.shade800,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  HumanFormat.number(movie.voteAverage),
                  style: titleStyle.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800),
                ),
                const Spacer(),
                Text(
                  HumanFormat.number(movie.popularity),
                  style: titleStyle.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TittleWidget extends StatelessWidget {
  const _TittleWidget({
    required this.tittle,
    required this.subTittle,
  });

  final String? tittle;
  final String? subTittle;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (tittle != null)
            Text(
              tittle!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTittle != null)
            FilledButton.tonal(
              //* Hace más pequeño el botón
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(
                subTittle!,
                // style: titleStyle,
              ),
            )
        ],
      ),
    );
  }
}
