import 'package:flutter/material.dart';

class MessageFieldBoxWidget extends StatelessWidget {
  MessageFieldBoxWidget({super.key, required this.onValue});

  final ValueChanged<String> onValue;

  final textController = TextEditingController();
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final outlinesInputBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));
    return TextFormField(
      autofocus: false,
      keyboardType: TextInputType.multiline,
      enableIMEPersonalizedLearning: true,
      enableSuggestions: true,
      decoration: InputDecoration(
        hintText: "End your message with a '?'",
        enabledBorder: outlinesInputBorder,
        focusedBorder: outlinesInputBorder,
        filled: true,
        suffixIcon: IconButton(
          onPressed: () {
            final textValue = textController.value.text;
            textController.clear();
            textValue.isNotEmpty ? onValue(textValue) : null;
          },
          icon: const Icon(Icons.send_outlined),
        ),
      ),
      controller: textController,
      onFieldSubmitted: (value) {
        textController.clear();
        focusNode.requestFocus();
        value.isNotEmpty ? onValue(value) : null;
      },
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      enabled: true,
    );
  }
}
