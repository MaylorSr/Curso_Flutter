import 'dart:math' show Random;
import 'package:flutter/material.dart';

class AnimatedScreen extends StatefulWidget {
  static const name = 'animated_screen';
  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  double width = 50;
  double height = 50;
  Color color = Colors.indigo;
  double borderRadius = 10.0;

  void changeShape() {
    final random = Random();

    width = random.nextInt(300) + 50;

    height = random.nextInt(300) + 50;

    borderRadius = random.nextInt(100) + 10;

    color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Animated Container',
        ),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 400,
          ),
          curve: Curves.elasticInOut,
          width: width <= 0 ? 0 : width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //Como no hay argumentos no hace falta pasarle los parentesis.
        onPressed: changeShape,
        child: const Icon(
          Icons.play_arrow_rounded,
        ),
      ),
    );
  }
}
