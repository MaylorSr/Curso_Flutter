import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigatorRouter {
  static goToMovieId({required BuildContext context, required int id}) =>
      context.push('/home/0/movie/$id');


  static goToHome({required BuildContext context}){
    context.go('/home/0');
  }

  static goToPopular({required BuildContext context}){
    context.go('/home/1');
  }

   static goToFavorites({required BuildContext context}){
    context.go('/home/2');
  }

  static goToCategories({required BuildContext context}){
    context.go('/home/3');
  }
}
