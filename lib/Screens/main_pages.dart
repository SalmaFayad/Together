import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Screens/drawerScreen.dart';

import 'Main_Screens/data_page_screen.dart';
import 'Main_Screens/delivery_users_screen.dart';
import 'Main_Screens/donation_users_screen.dart';


class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  PageController _pageController = PageController();
  var height = AppBar().preferredSize.height;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final String currentUserId = FirebaseAuth.instance.currentUser.uid;


  List<Widget> _screen = [
    DataPageScreen(),
    DonationUsersScreen(),
    DeliveryUserScreen(),
  ];

  int _selectedIndex = 0; // to make the icon selected
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0
            ? 'Data'
            : _selectedIndex == 1
                ? 'Donors'
                : _selectedIndex == 2
                    ? 'Delivery'
                    : ''
        ),
      ),
      body: PageView(
        // to swep between screens
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.data_usage,
              color: _selectedIndex == 0 ? Color(0xFF757575) : Colors.black,
            ),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 1 ? Color(0xFF757575) : Colors.black,
            ),
            label: 'Donors',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.delivery_dining,
              color: _selectedIndex == 2 ? Color(0xFF757575) : Colors.black,
            ),
            label: 'Delivery',
          ),
        ],
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(child: drawerScreen()),
    );
  }
}
