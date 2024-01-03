import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/shared/video_player/botones_view.dart';
import 'package:toktik/presentation/widgets/video/full_screen_player.dart';

import '../../../../domain/entities/video_post.dart';

class VideoScrollableView extends StatelessWidget {
  const VideoScrollableView({
    super.key,
    required this.videos,
  });
  final List<VideoPost> videos;

  @override
  Widget build(BuildContext context) {
    // Widget que nos permite hacer scroll a pantalla completa
    return PageView.builder(
      scrollDirection: Axis.vertical,
      // para que se pueda hacer scroll en Android
      physics: const BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final VideoPost video = videos[index];
        return Stack(
          children: [
            // video player + gradient
            SizedBox.expand(
              child: FullScreenPlayer(
                videoUrl: video.videoUrl,
              ),
            ),
            // botones
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BotonesView(
                  video: video,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  video.caption,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
