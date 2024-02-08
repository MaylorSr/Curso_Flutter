import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/router/navigation_router.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;
  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      
      child: GestureDetector(
        onTap: () =>
            NavigatorRouter.goToMovieId(context: context, id: movie.id),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            movie.posterPath,
          ),
        ),
      ),
    );
  }
}
