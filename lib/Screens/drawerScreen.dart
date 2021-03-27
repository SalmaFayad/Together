import 'package:flutter/material.dart';

class drawerScreen extends StatefulWidget {
  @override
  _drawerScreenState createState() => _drawerScreenState();
}

class _drawerScreenState extends State<drawerScreen> {
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
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.purple, // must be Image
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "UserName",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      ListTile(
        onTap: () {
          // go to profile page
        },
        leading: Icon(
          Icons.person,
          color: Colors.black,
        ),
        title: Text("Your Profile"),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.language,
          color: Colors.black,
        ),
        title: Text("Change Language"),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        title: Text("Edit Profile"),
      ),
      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.logout,
          color: Colors.black,
        ),
        title: Text("LogOut"),
      ),
    ]);
  }
}
