import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Screens/Main_Screens/chats_with_users_screen.dart';
import 'package:solution_challenge_project/Screens/drawerScreen.dart';
import 'Main_Screens/data_page_screen.dart';
import 'Main_Screens/delivery_users_screen.dart';
import 'Main_Screens/donation_users_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
    ChatScreen(),
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
            ? 'Chat'
            : _selectedIndex == 1
                ? 'Data'
                : _selectedIndex == 2
                    ? 'Donors' :
        _selectedIndex == 3
            ? 'Delivery'
                    : ''
          ,style: GoogleFonts.oswald(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        ),
      ),
      body: PageView(
        // to swep between screens
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar:
      BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFFFBC02D),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Icon(Icons.chat_outlined,
                size: 20.0,
                color: _selectedIndex == 0 ?  Color(0xFFFBC02D) : Colors.black,
              )
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Image.asset(
                'assets/data.png',
                width: 20,
                color: _selectedIndex ==1 ?  Color(0xFFFBC02D) : Colors.black,
              ),
            ),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Image.asset(
                'assets/donor.png',
                width: 20,
                color: _selectedIndex == 2? Color(0xFFFBC02D) : Colors.black,
              ),
            ),
            label: 'Donors',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Image.asset(
                'assets/delivery.png',
                width: 20,
                color: _selectedIndex == 3 ? Color(0xFFFBC02D) : Colors.black,
              ),
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
