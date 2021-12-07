import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class User {
  String? uid;
  String? email;
  String? username;
  String? image;
  int? PostNumber;
  List<Map<String, dynamic>>? _users;


  initializeUser(String email, String username) {
    this.PostNumber = 0;
    this.uid = uid;
    this.email = email;
    this.username = username;
    this.image =
        'https://firebasestorage.googleapis.com/v0/b/mate-20088.appspot.com/o/no-img.png?alt=media&token=cdda0bcb-2b74-47f9-a1d5-591cca5ca625';
  }

  addUID(String uid) {
    this.uid = uid;
  }

  getUser(email) async {
    if (_users == null) {
      QuerySnapshot<Map<String, dynamic>> database =
          await FirebaseFirestore.instance.collection('users').get();
      List<Map<String, dynamic>> data =
          database.docs.map((doc) => doc.data()).toList();
      _users = data;
      for (var item in data) {
        if (item['email'] == email) {
          this.email = email;
          this.username = item['username'];
          image = item['image'];
          return;
        }
      }
    }else{
      for (var item in _users!) {
        if (item['email'] == email) {
          this.email = email;
          this.username = item['username'];
          image = item['image'];
          _users!.clear();
          return;
        }
      }
    }
  }
}
