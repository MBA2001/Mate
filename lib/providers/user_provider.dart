import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  User? _user = null;
  List<Map<String, dynamic>>? _users;

  User? get user => _user;

  signIn(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (_users == null) {
      QuerySnapshot<Map<String, dynamic>> database =
          await FirebaseFirestore.instance.collection('users').get();

      List<Map<String, dynamic>> data =
          database.docs.map((doc) => doc.data()).toList();
      _users = data;
      for (var item in data) {
        if (item['email'] == email) {
          _user =
              User(item['uid'], item['email'], item['username'], item['image']);
          notifyListeners();
          return;
        }
      }
    } else {
      for (var item in _users!) {
        if (item['email'] == email) {
          _user =
              User(item['uid'], item['email'], item['username'], item['image']);
          _users = null;
          notifyListeners();
          return;
        }
      }
    }

    return credential.user;
  }

  createUser(
      String email, String password, String name) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    String image =
        'https://firebasestorage.googleapis.com/v0/b/mate-20088.appspot.com/o/no-img.png?alt=media&token=cdda0bcb-2b74-47f9-a1d5-591cca5ca625';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(credential.user!.uid)
        .set({
      'postNumber': 0,
      'username': name,
      'email': email,
      'image': image,
      'uid': credential.user!.uid,
    });

    _user = User(credential.user!.uid, email, name, image);
    notifyListeners();
    return credential.user;
  }

  signOut() async {

    await _auth.signOut();
    _user = null;
    
    notifyListeners();
  }
}
