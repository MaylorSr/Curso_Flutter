import 'package:flutter/material.dart';

// Hay que tratar de no utilizar tantos StatefulWidgets
class CounterFunctionsScreen extends StatefulWidget {
  const CounterFunctionsScreen({Key? key}) : super(key: key);

  @override
  State<CounterFunctionsScreen> createState() => _CounterFunctionsScreenState();
}

class _CounterFunctionsScreenState extends State<CounterFunctionsScreen> {
  int countes = 0;
  @override
  Widget build(BuildContext context) {
    // Shit + End para poner el punto y coma del final
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Functions Screen"),
        actions: [
          IconButton(
            onPressed: () => setState(
              () {
                countes = 0;
              },
            ),
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton(
            icono: Icons.refresh_outlined,
            onPressed: () => setState(
              () {
                countes = 0;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            icono: Icons.exposure_minus_1_outlined,
            onPressed: countes == 0
                ? null
                : () => setState(
                      () {
                        countes == 0 ? null : countes--;
                      },
                    ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            icono: Icons.plus_one_outlined,
            onPressed: () => setState(
              () {
                countes++;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icono;
  final VoidCallback? onPressed;
  const CustomButton({
    super.key,
    required this.icono,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5,
      enableFeedback: true,
      disabledElevation: 100.00,
      // El shape hace el boton circula usando StadiumBorder
      // shape: const StadiumBorder(),
      onPressed: onPressed,
      child: Icon(icono),
    );
  }
}
