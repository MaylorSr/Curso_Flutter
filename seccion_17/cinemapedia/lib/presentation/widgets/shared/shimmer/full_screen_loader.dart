import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getMessages() {
    List<String> messages = [
      "Cargando películas",
      "Cargando",
      "Espere",
      "Tarda :("
    ];
    return Stream.periodic(
      const Duration(
        seconds: 1,
      ),
      (computationCount) => messages[computationCount],
    ).take(messages.length);
    //*El take es para cancelar la lectura
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Espere por favor"),
        const SizedBox(
          height: 10,
        ),
        const CircularProgressIndicator(
          strokeWidth: 2,
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: getMessages(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("cargando...");

            return Text(snapshot.data!);
          },
        ),
      ],
    ));
  }
}
