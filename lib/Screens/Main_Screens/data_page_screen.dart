import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solution_challenge_project/Widgets/data_page_widget/ListViewData.dart';

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
        changeLocationCard(valueChoose, cityList),
          ListViewData(size, appBarSize, bottomNavigationBarSize, statusBarHeight),
        ],
      ),
    );
  }

  Card changeLocationCard(String valueChoose, List<String> cityList) {
    return Card(
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
    );
  }

 
}