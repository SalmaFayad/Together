import 'package:flutter/material.dart';

class dataPageScreen extends StatefulWidget {
  /*var height;
  dataPageScreen(this.height);*/

  @override
  _dataPageScreenState createState() => _dataPageScreenState();
}

class _dataPageScreenState extends State<dataPageScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var appBarSize = AppBar().preferredSize.height;
    var bottomNavigationBarSize = kBottomNavigationBarHeight;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    /*print(appBarSize);
    print(bottomNavigationBarSize);
    print(statusBarHeight);
    print(size.height);*/
    return Scaffold(
      body: Container(
        height: size.height -
            appBarSize -
            bottomNavigationBarSize -
            statusBarHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < 100; i++)
                Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Ismailia, Ard Elgmayaat'),
                    subtitle: Text('3 Person '),
                    trailing: Text('01284782085'),
                  ),
                ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
