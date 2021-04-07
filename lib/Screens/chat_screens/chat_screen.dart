import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Widgets/chat_widgets/messages.dart';
import 'package:solution_challenge_project/Widgets/chat_widgets/new_message.dart';

class ChatScreen extends StatelessWidget{
  final String userId;
  final String username;
  final String imageUrl;
  ChatScreen(this.userId,this.username,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 70,
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        title: Text(username),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(userId:userId.trim()),
            ),
            NewMessage(userId),
          ],
        ),
      ),
    );
  }
}