import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Screens/chat_screens/chat_screen.dart';

class FutureBuilderNameState extends StatelessWidget {
  CollectionReference users ;
  final String currentUserId ;


  FutureBuilderNameState(this.users, this.currentUserId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(currentUserId).get(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState ==
            ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data.data();
          return Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width / 4 - 4.0,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "${data['username']}",
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'status: ${data['status']}',
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        }
        return Text("loading");
      },
    );
  }
}
