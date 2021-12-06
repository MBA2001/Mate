import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class User {
  final String uid;
  final String email;
  String username;
  Image image;
  String bio;

  User(this.uid, this.email, this.username, this.image, this.bio);
}
