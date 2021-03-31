import 'package:flutter/material.dart';

import 'Screens/drawerScreen.dart';
import 'Screens/main_pages.dart';

class connectScreen extends StatefulWidget {
  @override
  _connectScreenState createState() => _connectScreenState();
}

class _connectScreenState extends State<connectScreen> {
  double XOffset = 0, YOffset = 0, ScaleFactor = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          drawerScreen(),
          AnimatedContainer(
              transform: Matrix4.translationValues(XOffset, YOffset, 0)
                ..scale(ScaleFactor),
              child: MainPages()),
        ],
      ),
    );
  }
}
