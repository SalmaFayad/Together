import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('WELCOME TO TOGETHER', ///3c3e43 b6a57e
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                color: Color(0xFFFBC02D),
                letterSpacing: 5.0
              ),
            ),
            Image.asset('assets/togetherLogo.png',
              width: 100.0,
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFBC02D)),
              strokeWidth: 4.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/resala.png'),
                  radius: 20.0,
                ),
                SizedBox(width: 10.0,),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/misr_el_kheir.png'),
                  radius: 20.0,
                ),
                SizedBox(width: 10.0,),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/elorman.png'),
                  radius: 20.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
