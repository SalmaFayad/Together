import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {

  final String currentUserId = FirebaseAuth.instance.currentUser.uid;
  var url;

  File _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async{
    final pickedImageFile = await _picker.getImage(source: src,imageQuality: 50,maxWidth: 150);

    if(pickedImageFile != null){
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }else{
      print('No image selected');
    }
  }

  Future<void> uploadFile() async {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(EditProfileState().currentUserId+'.jpg')
          .putFile(_pickedImage);

      url =await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(EditProfileState().currentUserId+'.jpg')
          .getDownloadURL();
  }



  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');


  Future<void> updateUserImage() async {
      return users.doc(currentUserId).update(
          {
            'imageUrl': url,
          }
      );
  }

  Future<void> updateUserdata() async{
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
                Padding(
                    padding: EdgeInsets.only(top: 20.0,bottom: 10),
                    child:
                         Center(
                           child: CircleAvatar(
                           backgroundImage:docs['imageUrl']!=null?
                           NetworkImage(docs['imageUrl'])
                           :AssetImage('assets/user.png'),
                            radius: 60.0,
                    ),
                         )
                ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     FlatButton.icon(
                       textColor: Theme.of(context).primaryColor,
                       onPressed: () => _pickImage(ImageSource.camera),
                       icon: Icon(Icons.photo_camera_outlined),
                       label: Text('Add Image\nfrom Camera',textAlign: TextAlign.center),
                     ),
                     FlatButton.icon(
                       textColor: Theme.of(context).primaryColor,
                       onPressed: () => _pickImage(ImageSource.gallery),
                       icon: Icon(Icons.image_outlined),
                       label: Text('Add Image\nfrom Gallery',textAlign: TextAlign.center),
                     ),
                   ],
                 ),
                 Column(
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
                              CircleAvatar(
                                backgroundColor: Colors.grey[700],
                                radius: 14.0,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 16.0,
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
                         child: Container(
                           child: Text(
                             'City',
                             style: TextStyle(
                                 fontSize: 16.0,
                                 fontWeight: FontWeight.bold),
                           ),
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
                 padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0,bottom: 20),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       width: 180,
                         child: RaisedButton(
                           child: Text("Save"),
                           textColor: Colors.white,
                           color: Color(0xFFFBC02D),
                           onPressed: () {
                             setState(() {
                               uploadFile();
                               updateUserImage();
                               updateUserdata();
                             });
                           },
                           shape: new RoundedRectangleBorder(
                               borderRadius: new BorderRadius.circular(20.0)),
                         )),
                   ],
                 ),
                 )
                   ],
                 ),
              ],
            );
          }
        ));
  }

}
