import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Widgets/chats_with_users_widget/chats_with_users_widget.dart';

class ChatScreen extends StatefulWidget {
  /*var height;
  dataPageScreen(this.height);*/
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ChatsWithUsers()
    );
  }
}