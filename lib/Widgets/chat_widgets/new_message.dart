import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class NewMessage extends StatefulWidget{
  final String userId;
  NewMessage(this.userId);
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {

  final _controller = TextEditingController();
  String _enteredMessage = "";

  _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user =  FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if(user.uid[0].codeUnitAt(0) >= widget.userId[0].codeUnitAt(0))
         FirebaseFirestore.instance.collection('chat').doc(user.uid+'-'+widget.userId)
             .collection(user.uid+'-'+widget.userId).add({
           'text': _enteredMessage,
           'createdAt': Timestamp.now(),
           'username': userData['username'],
           'myId': user.uid,
           'userId': widget.userId
         });
    else {
      FirebaseFirestore.instance.collection('chat').doc(widget.userId+'-'+user.uid)
          .collection(widget.userId+'-'+user.uid).add({
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'username': userData['username'],
        'myId': user.uid,
        'userId': widget.userId
      });
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (val){
                setState(() {
                  _enteredMessage = val;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}