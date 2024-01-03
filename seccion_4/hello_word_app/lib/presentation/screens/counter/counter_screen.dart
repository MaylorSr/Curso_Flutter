import 'package:flutter/material.dart';

// Hay que tratar de no utilizar tantos StatefulWidgets
class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int countes = 0;
  @override
  Widget build(BuildContext context) {
    // Shit + End para poner el punto y coma del final
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              countes.toString(),
              style:
                  const TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
            ),
            Text(
              "Click${countes == 1 ? '' : 's'}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(
          () {
            countes++;
          },
        ),
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
