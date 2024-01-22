import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final initalLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(movieSlideShow).isEmpty;

  final step2 = ref.watch(getAllMoviesProvider).isEmpty;

  final step3 = ref.watch(getAllPopularMoviesProvider).isEmpty;

  final step4 = ref.watch(getUpComingMoviesProvider).isEmpty;

  final step5 = ref.watch(getTopRatedMoviesProvider).isEmpty;

  if (step1 || step2 || step3 || step4 || step5) return true;
  return false;
});
