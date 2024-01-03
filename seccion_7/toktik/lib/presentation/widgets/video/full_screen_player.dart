import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toktik/shared/data/local_video_post.dart';
import 'package:video_player/video_player.dart';

import 'video_background.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  const FullScreenPlayer({super.key, required this.videoUrl});

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..setVolume(0.0)
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _controller.initialize(),
      builder: (context, snapshot) {
        // cuando el state es done es que ya hemos obtenido el video
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 2.0,
            ),
          );
        } else {
          return Stack(children: [
            GestureDetector(
              onTap: () => _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play(),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            VideoBackground(
              stops: const [0.8, 1.0],
            )
          ]);
        }
      },
    );
  }
}
