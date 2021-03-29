import 'package:flutter/material.dart';

class deliveryUserScreen extends StatefulWidget {
  @override
  _deliveryUserScreenState createState() => _deliveryUserScreenState();
}

class _deliveryUserScreenState extends State<deliveryUserScreen> {
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
              Expanded(
                flex: 1,
                child: Container(
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 32,
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
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Card(
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(10),
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
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: 115,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // go to chat
                    },
                    child: Card(
                        elevation: 3,
                        child: Container(
                          // padding: const EdgeInsets.all(20),
                          child: ListTile(
                              leading: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.black,
                              ),
                              title: Text('UserName')),
                        )),
                  );
                },
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.clean_hands),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
