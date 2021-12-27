import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  User? _user;
  final List<User> _users = [];

  User? get user => _user;
  List<User> get users => _users;

  signIn(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (_users.isEmpty) {
      QuerySnapshot<Map<String, dynamic>> database =
          await FirebaseFirestore.instance.collection('users').get();

      List<Map<String, dynamic>> data =
          database.docs.map((doc) => doc.data()).toList();
      bool found = false;
      for (var item in data) {
        if (item['email'] == email) {
          _user = User(item['uid'], item['email'], item['username'],
              item['image'], item['likes'] ?? [], item['following'] ?? []);
          found = true;
        } else {
          _users.add(User(item['uid'], item['email'], item['username'],
              item['image'], item['likes'] ?? [], item['following'] ?? []));
        }
      }
      if (found) {
        print(_users);
        notifyListeners();
        return;
      }
    } else {
      for (var item in _users) {
        if (item.email == email) {
          _user = User(item.uid, item.email, item.username, item.image,
              item.likes, item.following);
          notifyListeners();
          return;
        }
      }
    }
  }

  createUser(String email, String password, String name) async {
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
      'likes': [],
      'followers': []
    });
    QuerySnapshot<Map<String, dynamic>> database =
        await FirebaseFirestore.instance.collection('users').get();
    List<Map<String, dynamic>> data =
        database.docs.map((doc) => doc.data()).toList();
    bool found = false;
    for (var item in data) {
      User user = User(item['uid'], item['email'], item['username'],
          item['image'], item['likes'] ?? [], item['following'] ?? []);
      if (user.email != email) {
        _users.add(user);
      }
    }

    _user = User(credential.user!.uid, email, name, image, [], []);
    notifyListeners();
  }

  addLike(String id) async {
    _user!.likes.add(id);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .update({'likes': _user!.likes});
    notifyListeners();
  }

  removeLike(String id) async {
    _user!.likes.remove(id);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .update({'likes': _user!.likes});
    notifyListeners();
  }

  follow(String username) async {
    _user!.following.add(username);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .update({'following': _user!.following});
    notifyListeners();
  }

  unFollow(String username) async {
    _user!.following.remove(username);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .update({'following': _user!.following});
    notifyListeners();
  }

  signOut() async {
    await _auth.signOut();
    _user = null;
    _users.clear();

    notifyListeners();
  }
}
