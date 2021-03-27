import 'package:flutter/material.dart';

class dataPageScreen extends StatefulWidget {
  @override
  _dataPageScreenState createState() => _dataPageScreenState();
}

class _dataPageScreenState extends State<dataPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text('Ismailia, Ard Elgmayaat'),
              subtitle: Text('3 Person '),
              trailing: Text('01284782085'),
              onTap: () {},
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
