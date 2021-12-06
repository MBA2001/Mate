import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges();

  signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  createUserWithEmailAndPassword(
      String email, String password, String name) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  signOut() async {
    return await _auth.signOut();
  }
}
