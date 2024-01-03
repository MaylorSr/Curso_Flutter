import 'package:flutter/material.dart';
import 'package:hello_word_app/presentation/screens/counter/counter_functions_screens.dart';
// import 'package:hello_word_app/presentation/screens/counter/counter_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Win + shit F es para autotabular el códigoF
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // El colorSchemeSeed hace que todo en la app sea de color blue
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      // home: const CounterScreen(),
      home: const CounterFunctionsScreen(),
    );
  }
}
