// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Cinemapedia_en`
  String get appTitle {
    return Intl.message(
      'Cinemapedia_en',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `In cinema`
  String get cine {
    return Intl.message(
      'In cinema',
      name: 'cine',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message(
      'Popular',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon to cinemas`
  String get proxiCine {
    return Intl.message(
      'Coming soon to cinemas',
      name: 'proxiCine',
      desc: '',
      args: [],
    );
  }

  /// `Best rated`
  String get bestRate {
    return Intl.message(
      'Best rated',
      name: 'bestRate',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Not found movies.`
  String get notFoundMovies {
    return Intl.message(
      'Not found movies.',
      name: 'notFoundMovies',
      desc: '',
      args: [],
    );
  }
  /// `January`
  String get january {
    return Intl.message(
      'January',
      name: 'january',
      desc: 'Name of the month January',
      args: [],
    );
  }

  /// `February`
  String get february {
    return Intl.message(
      'February',
      name: 'february',
      desc: 'Name of the month February',
      args: [],
    );
  }

  /// `March`
  String get march {
    return Intl.message(
      'March',
      name: 'march',
      desc: 'Name of the month March',
      args: [],
    );
  }

  /// `April`
  String get april {
    return Intl.message(
      'April',
      name: 'april',
      desc: 'Name of the month April',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: 'Name of the month May',
      args: [],
    );
  }

  /// `June`
  String get june {
    return Intl.message(
      'June',
      name: 'june',
      desc: 'Name of the month June',
      args: [],
    );
  }

  /// `July`
  String get july {
    return Intl.message(
      'July',
      name: 'july',
      desc: 'Name of the month July',
      args: [],
    );
  }

  /// `August`
  String get august {
    return Intl.message(
      'August',
      name: 'august',
      desc: 'Name of the month August',
      args: [],
    );
  }

  /// `September`
  String get september {
    return Intl.message(
      'September',
      name: 'september',
      desc: 'Name of the month September',
      args: [],
    );
  }

  /// `October`
  String get october {
    return Intl.message(
      'October',
      name: 'october',
      desc: 'Name of the month October',
      args: [],
    );
  }

  /// `November`
  String get november {
    return Intl.message(
      'November',
      name: 'november',
      desc: 'Name of the month November',
      args: [],
    );
  }

  /// `December`
  String get december {
    return Intl.message(
      'December',
      name: 'december',
      desc: 'Name of the month December',
      args: [],
    );
  }

    /// `Recommends.`
  String get recommends {
    return Intl.message(
      'Recommends / Similar.',
      name: 'recommends',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
