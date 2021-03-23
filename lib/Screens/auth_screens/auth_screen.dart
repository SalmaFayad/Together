import 'package:flutter/material.dart';
import 'package:solution_challenge_project/Widgets/auth_widgets/Auth_form.dart';
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(),
    );
  }
}
