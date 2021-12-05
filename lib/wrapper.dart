import 'package:final_project/pages/home.dart';
import 'package:final_project/pages/login.dart';
import 'package:final_project/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder:(_,snapshot) {
        if(snapshot.hasData){
          return Home(); 
        }else if(snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(body: Center(child: CircularProgressIndicator()),);
        }else if(snapshot.hasError){
          return Text('Something wrong occured');
        }else{
          return LogIn();
        }
      });
  }
}