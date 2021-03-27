import 'package:flutter/material.dart';

class donationUsersScreen extends StatefulWidget {
  @override
  _donationUsersScreenState createState() => _donationUsersScreenState();
}

class _donationUsersScreenState extends State<donationUsersScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double sizeTopConatainer = size.height / 7;
    double sizeTopLeftContainer = size.width / 1.5;
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Card(
                elevation: 3,
                child: Container(
                  height: sizeTopConatainer,
                  width: sizeTopLeftContainer,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('UserName'),
                          Text('statue'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                  elevation: 3,
                  child: Container(
                    height: sizeTopConatainer,
                    width: sizeTopLeftContainer - 8.5,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text('Change Location'),
                        new DropdownButton<String>(
                          items: <String>['Ismailia', 'Cairo', 'Giza']
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height - 300,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // go to chat
                  },
                  child: Card(
                      elevation: 3,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.black,
                              ),
                            ),
                            Text('UserName'),
                          ],
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
