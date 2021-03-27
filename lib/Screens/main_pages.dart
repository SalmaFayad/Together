import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Screens/drawerScreen.dart';

import 'Main_Screens/data_page_screen.dart';
import 'Main_Screens/delivery_users_screen.dart';
import 'Main_Screens/donation_users_screen.dart';
import 'Main_Screens/donation_users_screen.dart';

class mainPages extends StatefulWidget {
  @override
  _mainPagesState createState() => _mainPagesState();
}

class _mainPagesState extends State<mainPages> {
  PageController _pageController = PageController();

  List<Widget> _screen = [
    dataPageScreen(),
    donationUsersScreen(),
    deliveryUserScreen(),
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
                    : ''),
      ),
      body: PageView(
        // to swep between screens
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.data_usage,
              color: _selectedIndex == 0 ? Colors.blue : null,
            ),
            label: 'Date',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 1 ? Colors.blue : null,
            ),
            label: 'Donors',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.delivery_dining,
              color: _selectedIndex == 2 ? Colors.blue : null,
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