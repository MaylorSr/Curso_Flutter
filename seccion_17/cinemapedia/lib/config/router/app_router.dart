import 'package:cinemapedia/presentation/screen/screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: "/home/0",
  routes: [
    /* ShellRoute(
      builder: (context, state, child) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: "/",
          name: HomeScreen.name,
          builder: (context, state) => const HomeView(),
          routes: [
            GoRoute(
              path: "movie/:id",
              name: MovieScreen.name,
              builder: (context, state) => MovieScreen(
                movieId: state.pathParameters['id'] ?? 'no-id',
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesView(),
        ),
      ],
    ), */

    GoRoute(
      path: "/home/:page",
      name: HomeScreen.name,
      builder: (context, state) {
        String pageIndex = state.pathParameters['page'] ?? '0';
        if (int.parse(pageIndex) > 2 || int.parse(pageIndex) < 0) {
          pageIndex = "0";
        }
        return HomeScreen(
          pageIndex: int.parse(pageIndex),
        );
      },
      routes: [
        GoRoute(
          path: "movie/:id",
          name: MovieScreen.name,
          builder: (context, state) => MovieScreen(
            movieId: state.pathParameters['id'] ?? 'no-id',
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    )
  ],
);
