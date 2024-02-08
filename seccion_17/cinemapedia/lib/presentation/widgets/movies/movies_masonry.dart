import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MoviesMasonry extends StatefulWidget {
  final List<Movie> movie;

  final VoidCallback? callback;
  const MoviesMasonry({super.key, required this.movie, this.callback});

  @override
  State<MoviesMasonry> createState() => _MoviesMasonryState();
}

class _MoviesMasonryState extends State<MoviesMasonry> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() async {
      if (widget.callback == null) return;

      await Future.delayed(const Duration(microseconds: 500));

      //* Ha llegado al final, tiene que cargar más películas
      if ((_controller.position.pixels + 100) >=
          _controller.position.maxScrollExtent) {
        widget.callback!();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: MasonryGridView.count(
        controller: _controller,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.movie.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                MoviePosterLink(movie: widget.movie[index])
              ],
            );
          }
          return MoviePosterLink(movie: widget.movie[index]);
        },
      ),
    );
  }
}
