import 'package:flutter/material.dart';
import 'file:///D:/Flutter_app/challenge_solution_project/lib/Screens/auth_screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
    );
  }
}

