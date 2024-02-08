

import 'package:cinemapedia/infrastructure/datasources/isar_storage_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider(
  (ref) => LocalStorageRepositoryImpl(
    localStorageDataSource: IsarStorageDataSource(),
  ),
);
