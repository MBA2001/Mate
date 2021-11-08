import '../services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool firstBuild = true;
  User? user;

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    if(firstBuild){
      authService.user?.first.then((value){
        setState(() {
          user = value;
          firstBuild = false;
        });
      });
    }
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
              Text('${user?.email}'),
              Text('${user?.uid}'),
              const SizedBox(height: 20,),
              ElevatedButton.icon(
                onPressed: ()async {
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