import 'package:final_project/models/user.dart';
import '../services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool firstBuild = true;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
        margin: EdgeInsets.all(100),
        child: Center(
          child: Column(
            children: [
              const Text('Home Screen'),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await authService.signOut();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
              ),
            ],
          ),
        ),
      );
  }
}
