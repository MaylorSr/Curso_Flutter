import 'package:cinemapedia/config/constants/environment.dart';
import 'package:flutter/material.dart';

const nameAppBar = "Cinemapedia";

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(nameAppBar),
      ),
      body: Text(Environment.apiKey),
    );
  }
}
