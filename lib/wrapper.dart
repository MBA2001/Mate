import 'package:final_project/pages/home.dart';
import 'package:final_project/pages/logged_in.dart';
import 'package:final_project/pages/login.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserProvider>().user;

    if (user == null) {
      return LogIn();
    } else {
      return LoggedIn();
    }
  }
}
