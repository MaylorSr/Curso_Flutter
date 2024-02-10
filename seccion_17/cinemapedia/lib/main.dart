import 'package:cinemapedia/config/lang/app_lang.dart';
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:cinemapedia/presentation/provider/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'generated/l10n.dart';
import 'presentation/provider/providers.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLanguage activeLang = ref.watch(languageNotifierProvider);

    final AppTheme activeTheme = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale: activeLang.getLanguage(),
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: activeTheme.getThemeData(),
      // no se pone builder ni nada porque las rutas ya saben cual es la pantalla incial.
    );
  }
}
