import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_project/models/user.dart';

class DatabaseManager {
  final CollectionReference UserAccountt =
      FirebaseFirestore.instance.collection('users');

  Future getUserCountry() async {
    List items = [];
    try {
      await UserAccountt.get().then((query) {
        query.docs.forEach((element) {
          items.add(element.data);
        });
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
