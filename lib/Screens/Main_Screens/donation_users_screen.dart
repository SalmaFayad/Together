import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:solution_challenge_project/models/databaseManager.dart';

class donationUsersScreen extends StatefulWidget {
  @override
  _donationUsersScreenState createState() => _donationUsersScreenState();
}

class _donationUsersScreenState extends State<donationUsersScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final String documentId = FirebaseAuth.instance.currentUser.uid;
  Map<String, dynamic> data;

  List<Map<String, String>> userData = [
    {'username': "Amr", 'image': "assets/images/photo.jpeg"},
    {'username': "Ayman", 'image': "assets/images/photo.jpeg"},
    {'username': "Ahmed", 'image': "assets/images/photo.jpeg"},
  ];

  String statue = "User Out";
  bool isIn = false;
  void userIn() {
    statue = "User In";
    isIn = true;
  }

  String valueChoose;
  List<String> cityList = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Qalyubia'
        'Port Said',
    'Suez',
    'Gharbia',
    'Luxor',
    'Dakahlia',
    'Gharbia',
    'Asyut',
    'Ismailia',
    'Faiyum',
    'Sharqia',
    'Damietta',
    'Aswan',
    'Minya',
    'Beheira',
    'Beni Suef',
    'Red Sea',
    'Qena',
    'Sohag',
    '	Monufia',
    'North Sinai'
  ];
/*  List country = [];
  @override
  void initState() {
    super.initState();
    fetchDatabase();
  }

  fetchDatabase() async {
    dynamic res = await DatabaseManager.getUserCountry();
    if (res == null)
      print('No one in this counrty');
    else {
      setState(() {
        res = country;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double sizeTopConatainer = size.height / 6;
    double sizeTopLeftContainer = size.width / 1.5;
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/photo.jpeg'),
                            radius: 32,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder<DocumentSnapshot>(
                                future: users.doc(documentId).get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("Something went wrong");
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    data = snapshot.data.data();
                                    return Text("${data['username']}");
                                  }
                                  return Text("loading");
                                },
                              ),
                              Text('statue: $statue'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Card(
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Change Location'),
                            DropdownButton(
                                hint: Text('Select City'),
                                value: valueChoose,
                                onChanged: (newValue) {
                                  setState(() {
                                    valueChoose = newValue;
                                  });
                                },
                                items: cityList.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(valueItem),
                                  );
                                }).toList()),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // go to chat
                    },
                    child: Card(
                        elevation: 3,
                        child: Container(
                          // padding: const EdgeInsets.all(20),
                          child: ListTile(
                              leading: CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage:
                                      AssetImage(userData[index]['image'])),
                              title: Text(userData[index]['username'])),
                        )),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (!isIn) {
              userIn();
              userData.add({
                'username': data['username'],
                'image': "assets/images/photo.jpeg",
              });
            } else {
              userData.removeLast();
              isIn = false;
              statue = "User Out";
            }
          });
        },
        child: const Icon(Icons.arrow_upward_sharp),
      ),
    );
  }
}
