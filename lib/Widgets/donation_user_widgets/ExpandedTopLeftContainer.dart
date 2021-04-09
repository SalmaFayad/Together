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
                FutureBuilder<DocumentSnapshot>(
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

                        return CircleAvatar(
                          backgroundImage: data['imageUrl'] == null
                              ? null
                              : NetworkImage(data['imageUrl']),
                          radius: 32,
                        );
                      }
                      return Text("loading");
                    }),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder<DocumentSnapshot>(
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
                            width:
                            MediaQuery.of(context).size.width / 4 - 4.0,
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
