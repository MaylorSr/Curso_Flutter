import '../entities/video_post.dart';

abstract class VideoPostReporitory {
  // métodos
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID);
  Future<List<VideoPost>> getTrendingVideosByPage(int page);
}
