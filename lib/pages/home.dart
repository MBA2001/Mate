import 'package:final_project/models/user.dart';
import '../services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool firstBuild = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(100),
        child: Center(
          child: Column(
            children: [
              const Text('Home Screen'),
              const SizedBox(
                height: 20,
              ),
              Text(user.email!),
              user.image!,
              Text(user.username!),
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
      ),
    );
  }
}
