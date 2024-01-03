import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {
  static const String name = 'buttons_screen';
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buttons Screens"),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        child: const Icon(
          Icons.arrow_back_rounded,
        ),
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        //! Similar a las columnas o ROW, cuando no tenga mas espacio va a generar una nueva linea
        child: Wrap(
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Elevated Button',
              ),
            ),
            const ElevatedButton(
              onPressed: null,
              child: Text(
                'Disable Elevated Button',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.access_alarm_outlined,
              ),
              label: const Text(
                'Elevated button icon',
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text(
                'Filled Button',
              ),
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_a_photo_rounded),
              label: const Text('Filled icon'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outline Button'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.outbond_outlined),
              label: const Text('Outline Icon Button'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Text Button',
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.text_fields_outlined,
              ),
              label: const Text(
                'Text Icon Button',
              ),
            ),
            IconButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const CustomButtons()
          ],
        ),
      ),
    );
  }
}

class CustomButtons extends StatelessWidget {
  const CustomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: colors.primary,
        child:  InkWell(
          onTap: () {
            
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              'Hello word',
              style: TextStyle(color: colors.onSecondary),
            ),
          ),
        ),
      ),
    );
  }
}
