import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../models/user.dart';


class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  
  User? _userFromFirebase(auth.User? user){
    if(user == null){
      return null;
    }else{
      return User(user.uid,user.email);
    }
  }


  Stream<User?>? get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  signInWithEmailAndPassword(String email,String password) async{
      final credential  = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(credential.user);
  }

  createUserWithEmailAndPassword(String email,String password) async{

      final credential  = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(credential.user);
  }

  signOut() async{
    return await _auth.signOut();

  }

}