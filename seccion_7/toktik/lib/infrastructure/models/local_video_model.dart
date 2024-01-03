import '../../domain/entities/video_post.dart';

const jName = "name";
const jVideoUrl = "videoUrl";
const jLikes = "likes";
const jViews = "views";

class LocalVideoModel {
  final String name, videoUrl;
  final int? likes;
  final int? views;

  LocalVideoModel({
    required this.name,
    required this.videoUrl,
    this.likes,
    this.views,
  });

  factory LocalVideoModel.fromJson(Map<String, dynamic> json) =>
      LocalVideoModel(
        name: json[jName] ?? '',
        videoUrl: json[jVideoUrl],
        likes: json[jLikes] ?? 0,
        views: json[jViews] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        jName: name,
        jVideoUrl: videoUrl,
        jLikes: likes,
        jViews: views,
      };

  VideoPost toVideoPostEntity() =>
      VideoPost(caption: name, videoUrl: videoUrl, likes: likes, views: views);
}
