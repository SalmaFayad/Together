import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    List<String> cityList = ['Amr', 'Amr2', 'Amr3'];
    String valueChoose = cityList[0];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Card(
            elevation: 5,
            child: Container(
              width: double.infinity,
              //    color: Colors.blueAccent,
              child: Column(
                children: [
                  Text('Change Location'),
                  DropdownButton(
                      hint: Text('Select City'),
                      value: valueChoose,
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue;
                        });
                      },
                      items: cityList.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList()),
                ],
              ),
            ),
          ),
          Container(
            height: size.height -
                appBarSize -
                bottomNavigationBarSize -
                statusBarHeight -
                100,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('data').snapshots(),
              builder: (ctx, snapshot) {
                //final docs = snapshot.data.docs;
                if (snapshot.connectionState == ConnectionState.waiting &&
                    snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  /* gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      childAspectRatio: 4 / 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10),*/
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Text('Address : ' +
                                  snapshot.data.docs[i]['address']),
                              Text('Phone : ' + snapshot.data.docs[i]['phone']),
                              Text('Number of Family :' +
                                  snapshot.data.docs[i]['numFamilyPerson']),
                            ],
                          ),
                        ),
                        /*   child: ListTile(
                          title: Text(snapshot.data.docs[i]['address']),
                          subtitle: Text(snapshot.data.docs[i]['phone']),
                          trailing:
                              Text(snapshot.data.docs[i]['numFamilyPerson']),
                        ),*/
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}