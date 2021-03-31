import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Screens/chat_screens/chat_screen.dart';
import 'package:solution_challenge_project/models/databaseManager.dart';
import 'package:solution_challenge_project/models/user.dart';

class DonationUsersScreen extends StatefulWidget {
  @override
  _DonationUsersScreenState createState() => _DonationUsersScreenState();
}

class _DonationUsersScreenState extends State<DonationUsersScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final String currentUserId = FirebaseAuth.instance.currentUser.uid;
  Map<String, dynamic> data;

  bool isDonor = false;

  Future<void> updateUserStatus() {
    if (isDonor) {
      isDonor = false;
      return users.doc(currentUserId).update({'status': 'away'});
    } else {
      isDonor = true;
      return users.doc(currentUserId).update({'status': 'donor'});
    }
  }

  Future<void> updateUserId() {
    return users.doc(currentUserId).update({'id': currentUserId});
  }

  String valueChoose;

  List<String> cityList = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Qalyubia' 'Port Said',
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
    'Monufia',
    'North Sinai'
  ];

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
                          FutureBuilder<DocumentSnapshot>(
                              future: users.doc(currentUserId).get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text("Something went wrong");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  Map<String, dynamic> data =
                                      snapshot.data.data();

                                  return CircleAvatar(
                                    backgroundImage: data['imageUrl'] == null
                                        ? null
                                        : NetworkImage(data['imageUrl']),
                                    radius: 32,
                                  );
                                }
                                return Text("loading");
                              }),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder<DocumentSnapshot>(
                                future: users.doc(currentUserId).get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("Something went wrong");
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    Map<String, dynamic> data =
                                        snapshot.data.data();
                                    return Container(
                                      alignment: Alignment.topLeft,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${data['username']}",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            'status: ${data['status']}',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return Text("loading");
                                },
                              ),
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
          StreamBuilder(
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
                                    docs[index]['username'])),
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
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            updateUserStatus();
          });
        },
        child: const Icon(Icons.arrow_upward_sharp),
      ),
    );
  }
}
