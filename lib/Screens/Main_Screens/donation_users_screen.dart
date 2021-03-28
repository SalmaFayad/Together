import 'package:flutter/material.dart';

class donationUsersScreen extends StatefulWidget {
  @override
  _donationUsersScreenState createState() => _donationUsersScreenState();
}

class _donationUsersScreenState extends State<donationUsersScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double sizeTopConatainer = size.height / 6;
    double sizeTopLeftContainer = size.width / 1.5;
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: sizeTopConatainer,
                width: sizeTopLeftContainer,
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 50,
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
              ),
              Container(
                height: sizeTopConatainer,
                width: size.width - sizeTopLeftContainer,
                child: Card(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              ),
            ],
          ),
          Container(
            height: size.height -
                sizeTopConatainer -
                (AppBar().preferredSize.height) -
                kBottomNavigationBarHeight,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // go to chat
                  },
                  child: SingleChildScrollView(
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
                  ),
                );
              },
            ),
          ),
          /*    FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.clean_hands),
          ),*/
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
