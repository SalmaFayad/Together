import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Screens/chat_screens/chat_screen.dart';
import 'package:solution_challenge_project/Widgets/delivery_users_widgets/ExpandedTopLeftContainer.dart';
import 'package:solution_challenge_project/Widgets/delivery_users_widgets/FutureBuilderNameState.dart';
import 'package:solution_challenge_project/Widgets/delivery_users_widgets/FutureBuilderGetImage.dart';
import 'package:solution_challenge_project/Widgets/delivery_users_widgets/deliveryInfo.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryUserScreen extends StatefulWidget {
  @override
  _DeliveryUserScreenState createState() => _DeliveryUserScreenState();
}

class _DeliveryUserScreenState extends State<DeliveryUserScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final String currentUserId = FirebaseAuth.instance.currentUser.uid;

  bool isDelivery = false;

  Future<void> updateUserStatus() {
    if (isDelivery) {
      isDelivery = false;
      return users.doc(currentUserId).update({'status': 'away'});
    } else {
      isDelivery = true;
      return users.doc(currentUserId).update({'status': 'delivery'});
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
              ExpandedTopLeftContainer(users,currentUserId),
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
                            Text('Change Location',style: GoogleFonts.lato(
                              fontSize: 15,

                              color: Colors.grey[700],

                            ),),
                            DropdownButton(
                                hint: Text('Select City',style: GoogleFonts.lato(
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),),
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
          deliveryInfo(valueChoose,users, currentUserId),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
