import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Screens/chat_screens/chat_screen.dart';

class ChatsWithUsers extends StatefulWidget{
  final List<String> listOfId =[];
  @override
  _ChatsWithUsersState createState() => _ChatsWithUsersState();
}

class _ChatsWithUsersState extends State<ChatsWithUsers> {

  List<String> listOfId =[];

  final String currentUserId = FirebaseAuth.instance.currentUser.uid;

  void filterUsers()async{
    await FirebaseFirestore.instance
        .collection('chat').get().then((value) {
      value.docs.forEach((element) {
        if(element.id.contains(currentUserId))
          setState(() {
            listOfId.add(element.id.replaceAll(currentUserId, '').replaceAll('-', ''));
          });
      });
    });
  }

  @override
  void initState(){
    super.initState();
    filterUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        listOfId.length > 0 ?
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('id', whereIn: listOfId)
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                docs[index]['id'],
                                docs[index]['username'],
                                docs[index]['imageUrl'],
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
        ):
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Center(
                child: Text('No conversations yet'),
            ),
          ],
        )
      ],
    );
  }
}