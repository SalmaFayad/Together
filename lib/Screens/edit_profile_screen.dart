import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final String currentUserId = FirebaseAuth.instance.currentUser.uid;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserdata() {
    if(nameController.text.isNotEmpty){
      return users.doc(currentUserId).update(
          {
            'username' : nameController.text,
          }
      );
    }
    if(phoneController.text.isNotEmpty){
      return users.doc(currentUserId).update(
          {
            'phone' : phoneController.text,
          }
      );
    }
    if(countryController.text.isNotEmpty){
      return users.doc(currentUserId).update(
          {
            'country' : countryController.text,
          }
      );
    }
    if(cityController.text.isNotEmpty){
      return users.doc(currentUserId).update(
          {
            'city' : cityController.text
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('EDIT PROFILE'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users').doc(currentUserId).snapshots(includeMetadataChanges: true),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            final docs = snapshot.data;
            return ListView(
              children: <Widget>[
                GestureDetector(
                      child: Padding(
                          padding: EdgeInsets.only(top: 40.0, right: 100.0),
                          child:
                               CircleAvatar(
                               backgroundImage: NetworkImage(docs['imageUrl']),
                                radius: 60.0,
                          )
                      ),
                    ),
                 Padding(
                   padding: EdgeInsets.only(bottom: 25.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       Padding(
                           padding: EdgeInsets.only(
                               left: 25.0, right: 25.0, top: 25.0),
                           child: Row(
                             mainAxisAlignment:
                                 MainAxisAlignment.spaceBetween,
                             mainAxisSize: MainAxisSize.max,
                             children: <Widget>[
                               Text(
                                'Personal Information',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                                   ),
                                GestureDetector(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[700],
                                    radius: 14.0,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                  ),
                                )
                             ],
                           )
                       ),
                       Padding(
                           padding: EdgeInsets.only(
                               left: 25.0, right: 25.0, top: 25.0),
                           child: Text(
                             'Name',
                             style: TextStyle(
                                 fontSize: 16.0,
                                 fontWeight: FontWeight.bold),
                           )
                       ),
                       Padding(
                           padding: EdgeInsets.only(
                               left: 25.0, right: 25.0, top: 2.0),
                           child: Flexible(
                             child: TextField(
                               controller: nameController,
                               decoration: InputDecoration(
                                 hintText: docs['username'] ,
                               ),
                             ),
                           )
                       ),
                       Padding(
                           padding: EdgeInsets.only(
                               left: 25.0, right: 25.0, top: 25.0),
                           child: Text(
                             'Phone',
                             style: TextStyle(
                                 fontSize: 16.0,
                                 fontWeight: FontWeight.bold),
                           )
                       ),
                       Padding(
                           padding: EdgeInsets.only(
                               left: 25.0, right: 25.0, top: 2.0),
                           child: Flexible(
                             child: TextField(
                               controller: phoneController,
                               decoration: InputDecoration(
                                   hintText: docs['phone']),
                             ),
                           )
                       ),
                       Padding(
                           padding: EdgeInsets.only(
                               left: 25.0, right: 25.0, top: 25.0),
                           child: Text(
                             'Country',
                             style: TextStyle(
                                 fontSize: 16.0,
                                 fontWeight: FontWeight.bold),
                           )),
                       Padding(
                           padding: EdgeInsets.only(
                               left: 25.0, right: 25.0, top: 2.0),
                           child: Flexible(
                             child: TextField(
                               controller: countryController,
                               decoration: InputDecoration(
                                   hintText: docs['country']),
                             ),
                           )),
                       Padding(
                           padding: EdgeInsets.only(
                               left: 25.0, right: 25.0, top: 25.0),
                           child: Expanded(
                             child: Container(
                               child: Text(
                                 'City',
                                 style: TextStyle(
                                     fontSize: 16.0,
                                     fontWeight: FontWeight.bold),
                               ),
                             ),
                             flex: 2,
                           )
                       ),
                       Padding(
                           padding: EdgeInsets.only(
                               left: 25.0, right: 25.0, top: 2.0),
                           child: Flexible(
                             child: Padding(
                               padding: EdgeInsets.only(right: 10.0),
                               child: TextField(
                                 controller: cityController,
                                 decoration:  InputDecoration(
                                     hintText: docs['city']),
                               ),
                             ),
                             flex: 2,
                           )
                       ),
                   Padding(
                   padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
                   child: Row(
                     mainAxisSize: MainAxisSize.max,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       Expanded(
                         child: Padding(
                           padding: EdgeInsets.only(right: 10.0),
                           child: Container(
                               child: RaisedButton(
                                 child: Text("Save"),
                                 textColor: Colors.white,
                                 color: Color(0xFFFBC02D),
                                 onPressed: () {
                                   setState(() {
                                     updateUserdata();
                                   });
                                 },
                                 shape: new RoundedRectangleBorder(
                                     borderRadius: new BorderRadius.circular(20.0)),
                               )),
                         ),
                         flex: 2,
                       ),
                       Expanded(
                         child: Padding(
                           padding: EdgeInsets.only(left: 10.0),
                           child: Container(
                               child: RaisedButton(
                                 child: Text("Cancel"),
                                 textColor: Colors.white,
                                 //color: Colors.red,
                                 onPressed: () {
                                   setState(() {

                                   });
                                 },
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(20.0)),
                               )),
                         ),
                         flex: 2,
                       ),
                     ],
                   ),
                 )
                     ],
                   ),
                 ),
              ],
            );
          }
        ));
  }

}
