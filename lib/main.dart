import 'package:final_project/pages/account_settings.dart';
import 'package:final_project/pages/home.dart';
import 'package:final_project/pages/login.dart';
import 'package:final_project/pages/other_user_profile.dart';
import 'package:final_project/pages/profile.dart';
import 'package:final_project/pages/register.dart';
import 'package:final_project/pages/search.dart';
import 'package:final_project/providers/posts_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:final_project/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'pages/settings.dart';

import 'models/user.dart';

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
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<PostsProvider>(
          create: (_) => PostsProvider(),
        )
        
      ],
      child: MaterialApp(
        title: 'Mate',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          brightness: Brightness.dark,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/login': (context) => LogIn(),
          '/register': (context) => SignUp(),
          '/settings': (context) => const Settings(),
          '/accountSettings': (context)=> Accountsettings(),
          '/othersProfile': (context)=> OthersProfile(),
        },
      ),
    );
  }
}
