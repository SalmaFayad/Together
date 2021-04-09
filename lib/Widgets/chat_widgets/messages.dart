import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Widgets/chat_widgets/message_bubble.dart';

class Messages extends StatelessWidget{

  String user =  FirebaseAuth.instance.currentUser.uid;
  String path;
  String userId;
  Messages({this.userId});


  Widget changePath(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat').doc(userId+'-'+user)
          .collection(userId+'-'+user)
          .orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx,snapShot){
        if(snapShot.connectionState == ConnectionState.waiting||snapShot.data == null){
          return CircularProgressIndicator();
        }
        final docs = snapShot.data.docs;
        return  ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx,index) => MessageBubble(
              docs[index]['text'],
              docs[index]['username'],
              docs[index]['myId'] == user,
            )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat').doc(user+'-'+userId)
            .collection(user+'-'+userId)
            .orderBy('createdAt', descending: true).snapshots(),
        builder: (ctx,snapShot){
          if(snapShot.connectionState == ConnectionState.waiting||snapShot.data == null){
            return CircularProgressIndicator();
          }
          final docs = snapShot.data.docs;
          if(docs.length == 0){
            return changePath();
          }
          else{
            return ListView.builder(
                reverse: true,
                itemCount: docs.length,
                itemBuilder: (ctx,index) => MessageBubble(
                  docs[index]['text'],
                  docs[index]['username'],
                  docs[index]['myId'] == user,
                )
            );
          }
        },
      );
  }
}