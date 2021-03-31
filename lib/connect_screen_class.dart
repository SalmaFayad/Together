import 'package:flutter/material.dart';

import 'Screens/drawerScreen.dart';
import 'Screens/main_pages.dart';

class ConnectScreen extends StatefulWidget {
  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  double xOffset = 0, yOffset = 0, scaleFactor = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          drawerScreen(),
          AnimatedContainer(

              /// [todo] add duration!
              duration: null,
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor),
              child: MainPages()),
        ],
      ),
    );
  }
}
