import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Screens/chat_screens/chat_screen.dart';
import 'package:solution_challenge_project/Widgets/delivery_users_widgets/FutureBuilderNameState.dart';
import 'package:solution_challenge_project/Widgets/delivery_users_widgets/FutureBuilderGetImage.dart';

class ExpandedTopLeftContainer extends StatelessWidget {
  CollectionReference users ;
  final String currentUserId ;


  ExpandedTopLeftContainer(this.users, this.currentUserId);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Card(
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FutureBuilderGetImage(users,currentUserId),
                FutureBuilderNameState(users,currentUserId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
