import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:solution_challenge_project/Widgets/data_page_widget/ListViewData.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:solution_challenge_project/models/country.dart';
import 'package:google_fonts/google_fonts.dart';

class DataPageScreen extends StatefulWidget {
  /*var height;
  dataPageScreen(this.height);*/

  @override
  _DataPageScreenState createState() => _DataPageScreenState();
}

class _DataPageScreenState extends State<DataPageScreen> {
  List<Country> countries=  [];
  Future<List<Country>> _getCountry () async{
       var data = await http.get(Uri.parse('https://gist.github.com/keeguon/2310008.js'));
       var jsonData = json.decode( data.body );

       for(var v in jsonData){
         Country country = Country(v["name"],v["code"]);
         countries.add(country);
       }
       print(countries.length);
  }

  String valueChoose;
  List<String> cityList = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Qalyubia' 'Port Said',
    'Suez',
    'Gharbia',
    'Luxor',
    'Dakahlia',
    'Asyut',
    'Ismailia',
    'Faiyum',
    'Sharqia',
    'Damietta',
    'Aswan',
    'Minya',
    'Beheira',
    'Beni Suef',
    'Red Sea',
    'Qena',
    'Sohag',
    'Monufia',
    'North Sinai'
  ];

  @override
  Widget build(BuildContext context) {
    _getCountry();
    Size size = MediaQuery.of(context).size;
    var appBarSize = AppBar().preferredSize.height;
    var bottomNavigationBarSize = kBottomNavigationBarHeight;
    var statusBarHeight = MediaQuery.of(context).padding.top;

    valueChoose = cityList[0];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
           Container(
              padding: const EdgeInsets.all(8.0),

              child: Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  //    color: Colors.blueAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Change Location',style: GoogleFonts.oswald(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],

                      ),),
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
                              child: Text(valueItem,style: GoogleFonts.oswald(
                                fontSize: 15,
                                //fontWeight: FontWeight.bold,
                                color: Colors.grey[700],

                              ),),
                            );
                          }).toList()),
                    ],
                  ),
                ),
              ),
            ),

          Expanded(
            flex: 7,
              child: ListViewData(size, appBarSize, bottomNavigationBarSize, statusBarHeight)
          ),
        ],
      ),
    );
  }

  Card changeLocationCard(String valueChoose, List<String> cityList) {


  }

 
}