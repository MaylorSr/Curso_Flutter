import 'package:flutter/material.dart';
import 'package:toktik/domain/repositories/video_post_repository.dart';

import '../../domain/entities/video_post.dart';

class DiscoverProvider extends ChangeNotifier {
  final VideoPostReporitory _reporitory;
  bool initialLoading = true;
  final List<VideoPost> videos = [];

  DiscoverProvider({required VideoPostReporitory reporitory})
      : _reporitory = reporitory;

  Future<void> loadNextPage() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    // videoPost hace referencia a la lista de videos del local
    /*  final List<VideoPost> newVideos = videoPosts
        .map((video) => LocalVideoModel.fromJson(video).toVideoPostEntity())
        .toList();
 */

    final newVideos = await _reporitory.getTrendingVideosByPage(0);

    videos.addAll(newVideos);

    initialLoading = false;

    notifyListeners();
  }
}
