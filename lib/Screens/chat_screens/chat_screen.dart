import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Widgets/chat_widgets/messages.dart';
import 'package:solution_challenge_project/Widgets/chat_widgets/new_message.dart';

class ChatScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}