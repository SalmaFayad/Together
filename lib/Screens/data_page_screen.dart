import 'package:flutter/material.dart';

class dataPageScreen extends StatefulWidget {
  @override
  _dataPageScreenState createState() => _dataPageScreenState();
}

class _dataPageScreenState extends State<dataPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Data')),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.5,
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                /* CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.black,
                ),*/
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        'Ismailia, Ard Elgmayaat',
                        style: TextStyle(
                          fontSize: 30,
                          //    color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '3 person',
                        style: TextStyle(
                          fontSize: 25,
                          //    color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '01284782085',
                        style: TextStyle(
                          fontSize: 25,
                          //    color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
