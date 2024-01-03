class VideoPost {
  final String caption, videoUrl;
  final int? likes, views;

  VideoPost(
      {required this.caption, required this.videoUrl, this.likes, this.views});
}
