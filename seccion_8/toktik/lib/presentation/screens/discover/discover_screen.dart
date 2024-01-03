import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/presentation/widgets/shared/video_player/video_scrollable_view.dart';

import '../../providers/discover_provider.dart';

// TODOS LOS SCREEN SON SCAFFOLD
class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverProvider = context.watch<DiscoverProvider>();

    return Scaffold(
      body: Center(
        child: discoverProvider.initialLoading
            ? const CircularProgressIndicator.adaptive(
                strokeWidth: 2,
              )
            : VideoScrollableView(videos: discoverProvider.videos),
      ),
    );
  }
}
