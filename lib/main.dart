import 'package:final_project/pages/home.dart';
import 'package:final_project/pages/login.dart';
import 'package:final_project/pages/register.dart';
import 'package:final_project/services/authservice.dart';
import 'package:final_project/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/home': (context) => Home(),
          '/login': (context) => LogIn(),
          '/register': (context) => SignUp()
        },
      ),
    );
  }
}
