import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const nameAppBar = "Cinemapedia";

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    //* Se pone en el init State
    ref.read(getAllMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final getAllMovies = ref.watch(getAllMoviesProvider);
    return getAllMovies.isEmpty
        ? const CircularProgressIndicator()
        : ListView.builder(
            itemCount: getAllMovies.length,
            itemBuilder: (context, index) {
              final movie = getAllMovies[index];
              return ListTile(
                title: Text(movie.title),
              );
            },
          );
  }
}
