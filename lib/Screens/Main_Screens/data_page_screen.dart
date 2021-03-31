import 'package:flutter/material.dart';

class DataPageScreen extends StatefulWidget {
  /*var height;
  dataPageScreen(this.height);*/

  @override
  _DataPageScreenState createState() => _DataPageScreenState();
}

class _DataPageScreenState extends State<DataPageScreen> {
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
              //  for (int i = 0; i < 20; i++)
              Card(
                elevation: 3,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Ismailia, Ard Elgmayaat'),
                  subtitle: Text('3 Persons '),
                  trailing: Text('01200000000'),
                ),
              ),
              Card(
                elevation: 3,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Ismailia, Sheikh Zayed'),
                  subtitle: Text('1 Person '),
                  trailing: Text('01211111111'),
                ),
              ),
              Card(
                elevation: 3,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Ismailia, Elkhamsa'),
                  subtitle: Text('2 Persons '),
                  trailing: Text('01211112112'),
                ),
              ),
              Card(
                elevation: 3,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Ismailia, Elsalam'),
                  subtitle: Text('5 Persons '),
                  trailing: Text('01211133312'),
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