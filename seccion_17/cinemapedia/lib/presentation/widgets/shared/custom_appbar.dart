import 'package:cinemapedia/config/lang/app_lang.dart';
import 'package:cinemapedia/config/router/navigation_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/generated/l10n.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/provider/providers.dart';
import 'package:cinemapedia/presentation/provider/search/search_movie_provider.dart';
import 'package:cinemapedia/presentation/provider/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textAppBarStyle = Theme.of(context).textTheme.titleMedium;

    final changeLanguage = ref.read(languageNotifierProvider.notifier);

    final AppLanguage activeLang = ref.watch(languageNotifierProvider);

    final List<AppLanguage> listLanguage = ref.watch(languageListProvider);

    final MoviesNotifier notifierMovie =
        ref.read(getAllMoviesProvider.notifier);

    final bool isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return SafeArea(
      //* Es para no dejar espacio abajo de este.
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined,
                  color: colorIconMovie(context: context)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              Text(
                S.of(context).appTitle,
                style: textAppBarStyle,
              ),
              const Spacer(),
              IconButton(
                onPressed: () =>
                    ref.read(themeNotifierProvider.notifier).toggleDarkMode(),
                icon: Icon(
                  isDarkMode
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                ),
              ),
              _LanguageWidget(
                activeLang: activeLang,
                listLanguage: listLanguage,
                changeLanguage: changeLanguage,
                notifierMovie: notifierMovie,
              ),
              IconButton(
                /* onPressed: () async {
                  final getMovieBySearch = ref.read(movieRepositoryProvider);
                  final movie = await showSearch<Movie?>(
                    context: context,
                    delegate: SearchMovieDelegate(
                      moviescallBack: ({required query, required language}) =>
                          getMovieBySearch.getMovieBySearch(
                              query: query, language: activeLang.code),
                    ),
                  );

                  if (movie != null && context.mounted) {
                    NavigatorRouter.goToMovieId(
                      context: context,
                      id: movie.id,
                    );
                  }
                }, */
                onPressed: () {
                  final getMovieBySearch = ref.read(movieRepositoryProvider);
                  final searchQuery = ref.read(searchMovieProvider);

                  final listMovie = ref.read(searchedMoviesProvider);

                  showSearch<Movie?>(
                    query: searchQuery.query,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initMovies: listMovie,
                      moviescallBack: ({required query, required language}) {
                        /* ref.read(searchMovieProvider.notifier).update((state) {
                          return state = CacheSearchMovie(
                            movieId: '',
                            lang: activeLang.code,
                            query: query,
                          );
                        }); */

                        ref
                            .read(searchedMoviesProvider.notifier)
                            .searchedMoviesByQuery(
                                query: query, language: language);

                        return getMovieBySearch.getMovieBySearch(
                            query: query, language: activeLang.code);
                      },

                      /*  ({required query, required language}) =>
                          getMovieBySearch.getMovieBySearch(
                              query: query, language: activeLang.code), */
                    ),
                  ).then((value) {
                    if (value != null) {
                      NavigatorRouter.goToMovieId(
                        context: context,
                        id: value.id,
                      );
                    }
                  });
                },
                icon: const Icon(Icons.search_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageWidget extends StatelessWidget {
  const _LanguageWidget({
    required this.activeLang,
    required this.listLanguage,
    required this.changeLanguage,
    required this.notifierMovie,
  });

  final AppLanguage activeLang;
  final List<AppLanguage> listLanguage;
  final LanguageNotifier changeLanguage;
  final MoviesNotifier notifierMovie;

  @override
  Widget build(BuildContext context) {
    final textAppBarStyle = Theme.of(context).textTheme.titleMedium;

    return PopupMenuButton(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      splashRadius: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      offset: const Offset(25, 10),
      color: colorDesplegableLang(context: context),
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            clipBehavior: Clip.antiAlias,
            child: SvgPicture.asset(
              activeLang.flagSvg,
              width: AppTheme.withSize,
              height: AppTheme.withSize,
              clipBehavior: Clip.antiAlias,
              excludeFromSemantics: true,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            width: 2.5,
          ),
          Text(
            activeLang.getLanguage().languageCode,
            style: textAppBarStyle,
          ),
        ],
      ),
      position: PopupMenuPosition.under,
      itemBuilder: (context) => listLanguage
          .skip(0)
          .map(
            (e) => PopupMenuItem(
              enabled: true,
              value: e,
              onTap: () {
                changeLanguage.changeLanguage(e);
                notifierMovie.loadNextPage();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    e.flagSvg,
                    alignment: Alignment.centerLeft,
                    width: AppTheme.withSize,
                    height: AppTheme.withSize,
                    clipBehavior: Clip.antiAlias,
                    excludeFromSemantics: true,
                    fit: BoxFit.cover,
                    semanticsLabel: e.code,
                  ),
                  Text(
                    e.code,
                    style: textAppBarStyle
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
