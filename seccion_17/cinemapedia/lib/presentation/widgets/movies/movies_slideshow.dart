import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/config/router/navigation_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideShow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.25,
      child: Swiper(
        //* Para que sea automático
        autoplay: true,
        //* Es el tamaño que hace que se vea el siguiente junto con el scale.
        viewportFraction: 0.8,
        scale: 0.9,

        //* Para la paginacíon podemos usarla dentro del mísmo swiper.
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(
            top: 0,
          ),
          builder: DotSwiperPaginationBuilder(
            activeColor: colorIconMovie(context: context),
            activeSize: 18,
            color: colors.secondary,
            space: size.width * 0.010,
          ),
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _Slide(movie: movie);
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10),
        ),
      ],
    );
    return GestureDetector(
      onTap: () => NavigatorRouter.goToMovieId(context: context, id: movie.id),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
        ),
        child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              fit: BoxFit.cover,
              movie.backdropPath,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const CircularProgressIndicator();
                }
                return FadeIn(child: child);
              },
            ),
          ),
        ),
      ),
    );
  }
}
