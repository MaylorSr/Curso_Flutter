import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  static const String name = 'progress_screen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Progress Indicator',
        ),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Circular progress indicator',
          ),
          SizedBox(
            height: 10,
          ),
          CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.black45,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Progress indicator controlado',
          ),
          SizedBox(
            height: 10,
          ),
          _ControllerProgressIndicator(),
          Text(
            'Linear indicator controlado',
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class _ControllerProgressIndicator extends StatelessWidget {
  const _ControllerProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: Stream.periodic(const Duration(milliseconds: 250), (value) {
          return (value * 2) / 100;
        }).takeWhile(
          (value) => value < 100,
        ),
        builder: (context, snapshot) {
          final progressValue = snapshot.data;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                  value: double.tryParse(
                    progressValue.toString(),
                  ),
                  backgroundColor: Colors.black12,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: LinearProgressIndicator(
                    value: double.tryParse(
                      progressValue.toString(),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
