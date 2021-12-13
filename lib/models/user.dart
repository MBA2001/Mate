import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class User {
  String? uid;
  String? email;
  String? username;
  String? image;
  List likes;

  User(this.uid,this.email,this.username,this.image,this.likes);
}
