import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigatorRouter {
  static goToMovieId({required BuildContext context, required int id}) =>
      context.push('/movie/$id');
}
