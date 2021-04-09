import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Screens/chat_screens/chat_screen.dart';

class FutureBuilderGetImage extends StatelessWidget {
  CollectionReference users ;
  final String currentUserId ;

  FutureBuilderGetImage(this.users, this.currentUserId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(currentUserId).get(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
            snapshot.data.data();
            return CircleAvatar(
              backgroundImage: data['imageUrl'] == null
                  ? AssetImage('assets/user.png')
                  : NetworkImage(data['imageUrl']),
              radius: 32,
            );
          }
          return const CircleAvatar(
            backgroundImage: AssetImage('assets/user.png'),
            radius: 32,
          );
        });
  }
}
