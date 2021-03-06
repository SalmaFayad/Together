import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MessageBubble extends StatelessWidget{

  MessageBubble(this.message,this.username,this.isMe,{this.key});

  final Key key;
  final String message;
  final String username;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: !isMe ? Colors.grey[700] : Color(0xFFFBC02D),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(14),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(14),
            )
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          child: Column(
            crossAxisAlignment: !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                message,
                style: TextStyle(
                    color: isMe
                        ?Colors.black
                        :Colors.white,
                  fontWeight: FontWeight.bold
                ),
                textAlign: !isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        )
      ],
    );
  }

}