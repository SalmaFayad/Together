import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'edit_profile_screen.dart';

class drawerScreen extends StatefulWidget {
  @override
  _drawerScreenState createState() => _drawerScreenState();
}

class _drawerScreenState extends State<drawerScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final String documentId = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<DocumentSnapshot>(
                  future: users.doc(documentId).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();
                      return CircleAvatar(
                        backgroundImage:data['imageUrl']!=null?
                        NetworkImage(data['imageUrl'])
                            :AssetImage('assets/user.png'),
                        radius: 50.0,
                        backgroundColor: Colors.purple, // must be Image
                      );
                    }
                    return Text("loading");
                  }),

              SizedBox(
                height: 5.0,
              ),
              FutureBuilder<DocumentSnapshot>(
                future: users.doc(documentId).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data.data();
                    return Text("${data['username']}",style: TextStyle(fontWeight: FontWeight.bold),);
                  }

                  return Text("loading");
                },
              ),
            ],
          ),
        ),
      ),
      ListTile(
        onTap: () {
          // go to profile page
        },
      ),

      ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfile()),
          );
        },
        leading: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        title: Text("Edit Profile"),
      ),
      ListTile(
        onTap: () {
          FirebaseAuth.instance.signOut();
        },
        leading: Icon(
          Icons.logout,
          color: Colors.black,
        ),
        title: Text("LogOut"),
      ),
    ]);
  }
}
