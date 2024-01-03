import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//! Datos creados a manos para el slide
final slides = <SlideInfo>[
  SlideInfo(
    title: 'Busca la comida',
    caption: "Fugiat nostrud dolore laboris nisi reprehenderit anim commodo.",
    imageUrl: 'assets/images/1.png',
  ),
  SlideInfo(
    title: 'Entrega rapida',
    caption:
        "Aliquip deserunt quis nostrud nostrud quis quis aute dolor. In reprehenderit est quis consectetur excepteur deserunt consectetur consequat ipsum consequat est qui irure. Nisi ad mollit tempor reprehenderit adipisicing. Anim aliqua quis ullamco eu ipsum adipisicing sint do eu commodo velit occaecat veniam dolor. Exercitation qui proident do enim amet laboris ipsum ipsum anim ad commodo.",
    imageUrl: 'assets/images/2.png',
  ),
  SlideInfo(
    title: 'Disfruta de la comida',
    caption:
        "Ad culpa officia cillum Lorem nulla culpa reprehenderit culpa veniam magna sit cillum. Laboris culpa adipisicing Lorem nisi ad ea anim dolor nostrud ad irure fugiat eiusmod. Laboris cupidatat minim minim incididunt culpa et incididunt. Dolore et occaecat adipisicing velit ipsum amet magna sunt nisi. Nisi aliqua proident cupidatat excepteur et reprehenderit officia qui est aute dolor non occaecat commodo. Tempor aliquip aute sint dolore.",
    imageUrl: 'assets/images/3.png',
  ),
];

//! Clase auxiliar para los slide.
class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo({
    required this.title,
    required this.caption,
    required this.imageUrl,
  });
}

class TutorialScreen extends StatefulWidget {
  static const String name = 'tutorial_screen';
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late final pageviewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();
    pageviewController.addListener(
      () {
        final page = pageviewController.page ?? 0;
        if (!endReached && page >= slides.length - 1) {
          setState(() {
            endReached = true;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    pageviewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageviewController,
            physics: const BouncingScrollPhysics(),
            children: slides
                .map((slideData) => _Slide(
                    title: slideData.title,
                    caption: slideData.caption,
                    imageUrl: slideData.imageUrl))
                .toList(),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => context.pop(),
              child: const Text('Salir'),
            ),
          ),
          if (endReached) ...[
            Positioned(
              bottom: 30,
              right: 30,
              child: FadeInRight(
                from: 15,
                duration: const Duration(
                  milliseconds: 100,
                ),
                child: FilledButton(
                  onPressed: () {
                    pageviewController.initialPage;
                  },
                  child: const Text('Comenzar'),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

//! Widget auxiliar para los slides.
class _Slide extends StatelessWidget {
  final String title;

  final String caption;

  final String imageUrl;

  const _Slide(
      {required this.title, required this.caption, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(imageUrl),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(title, style: titleStyle),
            const SizedBox(
              height: 10,
            ),
            Text(caption, style: captionStyle),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
