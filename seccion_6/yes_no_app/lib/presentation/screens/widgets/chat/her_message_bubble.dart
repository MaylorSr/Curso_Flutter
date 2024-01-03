import 'package:flutter/material.dart';

import '../../../domain/entities/message.dart';

class HerMessageBubbleWidget extends StatelessWidget {
  const HerMessageBubbleWidget({super.key, required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              message.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        _ImageBubbleWidget(
          url: message.imageUrl!,
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}

class _ImageBubbleWidget extends StatelessWidget {
  final String url;

  const _ImageBubbleWidget({required this.url});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Widget que nos permite poner border a todo hijo que tenga
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        url,
        width: size.width * 0.7,
        height: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
                ? child
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircularProgressIndicator(),
                    ),
                  ),
      ),
    );
  }
}
