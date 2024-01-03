import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const String name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackback = SnackBar(
      content: const Text('Hola Mundo'),
      duration: const Duration(
        seconds: 1,
      ),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackback);
  }

  void openDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          '¿Estas seguro?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Aceptar'),
          )
        ],
        content: const Text(
            "Tempor minim eiusmod aliqua veniam proident do esse duis anim. Deserunt do ut eu voluptate anim ipsum do duis aliquip nulla. Est est labore ex cupidatat dolor laborum cillum voluptate elit ad laboris. Ex mollit et enim occaecat et est nostrud anim id."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Snackbarsd y Dialogo',
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showCustomSnackbar(context);
        },
        icon: const Icon(
          Icons.remove_red_eye_outlined,
        ),
        label: const Text(
          'Mostrar Snackbar',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  children: [
                    const Text(
                        'Duis laboris sint voluptate enim commodo. Consequat aliquip ex nulla nulla. Ullamco reprehenderit ea esse sint esse magna qui. Irure mollit nostrud nisi nisi irure.')
                  ],
                );
              },
              child: const Text(
                'Licencias usadas',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonal(
              onPressed: () => openDialog(context),
              child: const Text(
                'Mostrar dialogo en pantalla',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
