import 'package:toktik/domain/entities/video_post.dart';

abstract class VideoPostDataSource {
  // métodos
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID);
  Future<List<VideoPost>> getTrendingVideosByPage(int page);
}
