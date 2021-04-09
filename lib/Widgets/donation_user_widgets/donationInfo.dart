import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Screens/chat_screens/chat_screen.dart';
import 'package:solution_challenge_project/Widgets/delivery_users_widgets/FutureBuilderNameState.dart';
import 'package:solution_challenge_project/Widgets/delivery_users_widgets/FutureBuilderGetImage.dart';

class donationInfo extends StatelessWidget {
  String valueChoose ;
  CollectionReference users ;
  final String currentUserId ;


  donationInfo(this.valueChoose, this.users, this.currentUserId);

  Future<void> updateUserId() {
    return users.doc(currentUserId).update({'id': currentUserId});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('status', isEqualTo: 'donor')
          .where('city', isEqualTo: valueChoose)
          .snapshots(includeMetadataChanges: true),
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final docs = snapShot.data.docs;
        return Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    updateUserId();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                              docs[index]['id'],
                              docs[index]['username'],
                              docs[index]['imageUrl']
                          )
                      ),
                    );
                  },
                  child: Card(
                      elevation: 3,
                      child: Container(
                        // padding: const EdgeInsets.all(20),
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                              NetworkImage(docs[index]['imageUrl']),
                              radius: 25.0,
                            ),
                            title: Text(docs[index]['username'])),
                      )),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
