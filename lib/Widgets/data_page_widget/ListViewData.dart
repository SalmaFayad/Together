import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListViewData extends StatelessWidget {
  Size size; double appBarSize, bottomNavigationBarSize, statusBarHeight;

  ListViewData(this.size, this.appBarSize, this.bottomNavigationBarSize,
      this.statusBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
