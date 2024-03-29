import 'package:flutter/material.dart';

class UiControlsScreen extends StatelessWidget {
  static const String name = 'uiControls_screen';

  const UiControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UI Controls',
        ),
      ),
      body: _UIControlsView(),
    );
  }
}

enum Transportation { car, plane, boat, submarine }

class _UIControlsView extends StatefulWidget {
  @override
  State<_UIControlsView> createState() => _UIControlsViewState();
}

class _UIControlsViewState extends State<_UIControlsView> {
  bool isDeveloper = true;

  bool wantsBreakfast = false;

  bool wantsLunch = false;

  bool wantsDinner = true;

  Transportation selectedTransportation = Transportation.boat;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SwitchListTile(
          title: const Text(
            'Developer mode',
          ),
          subtitle: const Text(
            'Controles adicionales',
          ),
          value: isDeveloper,
          onChanged: (value) => setState(
            () {
              isDeveloper = !isDeveloper;
            },
          ),
        ),
        ExpansionTile(
          title: const Text('Vehiculo de transporte'),
          subtitle: Text(selectedTransportation.name),
          initiallyExpanded: false,
          children: [
            RadioListTile(
              title: const Text('By car'),
              subtitle: const Text('Viajar por carro'),
              value: Transportation.car,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(
                () {
                  selectedTransportation = Transportation.car;
                },
              ),
            ),
            RadioListTile(
              title: const Text('By boat'),
              subtitle: const Text('Viajar por barco'),
              value: Transportation.boat,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(
                () {
                  selectedTransportation = Transportation.boat;
                },
              ),
            ),
            RadioListTile(
              title: const Text('By submarine'),
              subtitle: const Text('Viajar por submarino'),
              value: Transportation.submarine,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(
                () {
                  selectedTransportation = Transportation.submarine;
                },
              ),
            ),
            RadioListTile(
              title: const Text('By plane'),
              subtitle: const Text('Viajar por avion'),
              value: Transportation.plane,
              groupValue: selectedTransportation,
              onChanged: (value) => setState(
                () {
                  selectedTransportation = Transportation.plane;
                },
              ),
            ),
          ],
        ),
        CheckboxListTile(
          title: const Text('Quieres desayno?'),
          value: wantsBreakfast,
          onChanged: (value) => setState(
            () {
              wantsBreakfast = !wantsBreakfast;
            },
          ),
        ),
        CheckboxListTile(
          title: const Text('Quieres almuerzo?'),
          value: wantsLunch,
          onChanged: (value) => setState(
            () {
              wantsLunch = !wantsLunch;
            },
          ),
        ),
        CheckboxListTile(
          title: const Text('Quieres cena?'),
          value: wantsDinner,
          onChanged: (value) => setState(
            () {
              wantsDinner = !wantsDinner;
            },
          ),
        )
      ],
    );
  }
}
