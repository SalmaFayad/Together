import 'package:flutter/material.dart';

import 'Screens/drawerScreen.dart';
import 'Screens/main_pages.dart';

class connectScreen extends StatefulWidget {
  @override
  _connectScreenState createState() => _connectScreenState();
}

class _connectScreenState extends State<connectScreen> {
  double xOffset = 0, yOffset = 0, scaleFactor = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          drawerScreen(),
          AnimatedContainer(
              duration: null,

              /// [todo] add duration!
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor),
              child: MainPages()),
        ],
      ),
    );
  }
}
