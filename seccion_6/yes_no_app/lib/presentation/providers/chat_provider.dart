import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';

import '../domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();

  List<Message> messageList = [];

  final getYesNoAnswer = GetYesNoAnswer();

  Future<void> sendMessage(String text) async {
    final message = Message(text: text, fromWho: FromWho.mine);

    messageList.add(message);

    if (text.endsWith('?')) {
      herAnswer();
    }
    // Notificar que ha habido un cambio, similar al setState pero con ChangeNotifier
    notifyListeners();
    moveScrollToButton();
  }

  void moveScrollToButton() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  Future<void> herAnswer() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
    notifyListeners();

    moveScrollToButton();
  }
}
