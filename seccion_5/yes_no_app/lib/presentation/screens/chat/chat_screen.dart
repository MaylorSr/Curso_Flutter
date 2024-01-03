import 'package:flutter/material.dart';
import 'package:yes_no_app/presentation/screens/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/screens/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/screens/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/765582ae-ee02-4dc4-851a-d3dc540cdf79/d417rsy-8f84dd2d-b361-48a4-b54c-37495f8c8b44.png/v1/fill/w_256,h_256/the_flash_icon_by_jeremymallin_d417rsy-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MjU2IiwicGF0aCI6IlwvZlwvNzY1NTgyYWUtZWUwMi00ZGM0LTg1MWEtZDNkYzU0MGNkZjc5XC9kNDE3cnN5LThmODRkZDJkLWIzNjEtNDhhNC1iNTRjLTM3NDk1ZjhjOGI0NC5wbmciLCJ3aWR0aCI6Ijw9MjU2In1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.mTyS5pcT3BxR-BhU2jZcvAwvpFjhWlmHAcCf2kGBGE4",
            ),
            // child: Icon(Icons.headphones_battery),
          ),
        ),
        title: const Text("Yes and No App"),
        centerTitle: false,
      ),
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return index % 2 == 0
                      ? const HerMessageBubbleWidget()
                      : const MyMessageBubbleWidget();
                },
              ),
            ),
            MessageFieldBoxWidget(),
          ],
        ),
      ),
    );
  }
}
