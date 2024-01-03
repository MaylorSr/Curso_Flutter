import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/helpers/human_format.dart';

import '../../../screens/shared/buttons/icon_button.dart';

class BotonesView extends StatelessWidget {
  final VideoPost video;
  const BotonesView({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Iconbutton(
              icon: Icons.favorite_rounded,
              onPressed: () {},
              color: Colors.red,
            ),
            Text(
              HumanFormat.humanReadbleNumber(
                video.likes?.toDouble() ?? 0.0,
              ),
              style: _voidText(),
              maxLines: 1,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Iconbutton(
              icon: Icons.remove_red_eye_sharp,
              onPressed: () {},
            ),
            Text(
              HumanFormat.humanReadbleNumber(
                video.views?.toDouble() ?? 0.0,
              ),
              style: _voidText(),
              maxLines: 1,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinPerfect(
              infinite: true,
              duration: const Duration(seconds: 5),
              child: Iconbutton(
                icon: Icons.play_arrow_rounded,
                onPressed: () {},
              ),
            ),
            Text(
              "Share",
              style: _voidText(),
              maxLines: 1,
            )
          ],
        ),
        const SizedBox(height: 20,)
      ],
    );
  }

  TextStyle _voidText() => const TextStyle(
      fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 0.25);
}
