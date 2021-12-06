import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class User{
  String? uid;
  String? email;
  String? username;
  Image? image;


  initializeUser(String email,String username){
    this.uid = uid;
    this.email = email;
    this.username = username;
    this.image = Image.network('https://firebasestorage.googleapis.com/v0/b/mate-20088.appspot.com/o/no-img.png?alt=media&token=cdda0bcb-2b74-47f9-a1d5-591cca5ca625');

  }

  addUID(String uid){
    this.uid = uid;
  }

  getUser(email)async {
    QuerySnapshot<Map<String, dynamic>> database =
          await FirebaseFirestore.instance.collection('users').get();
      List<Map<String, dynamic>> data =
          database.docs.map((doc) => doc.data()).toList();
      for (var item in data) {
        print(item);
        if (item['email'] == email) {
          this.email = email;
          this.username = item['username'];
          image = Image.network(item['image']);
          return;
        }
      }
  }
  
}
