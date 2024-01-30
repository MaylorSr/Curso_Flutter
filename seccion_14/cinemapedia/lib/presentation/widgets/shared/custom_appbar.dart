import 'package:cinemapedia/config/lang/app_lang.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:cinemapedia/generated/l10n.dart';
import 'package:cinemapedia/presentation/provider/providers.dart';
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
              const Icon(Icons.movie_outlined),
              SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              Text(
                S.of(context).appTitle,
                style: textAppBarStyle,
              ),
              const Spacer(),
              _LanguageWidget(
                activeLang: activeLang,
                listLanguage: listLanguage,
                changeLanguage: changeLanguage,
                notifierMovie: notifierMovie,
              ),
              IconButton(
                onPressed: () {},
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
      color: Theme.of(context).disabledColor,
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
                    style: textAppBarStyle?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
