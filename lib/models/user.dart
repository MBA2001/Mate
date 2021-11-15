import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String? email;
  String? username;
  String? image;
  String? bio;

  User(this.uid,this.email);


  createUser(String name){
    username = name;
    FirebaseFirestore.instance.collection('users').add({
      'uid':uid,
      'email': email,
      'username' : username,
      'bio' : ''
    });
  }
}