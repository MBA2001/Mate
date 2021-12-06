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
    User user = Provider.of<User>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      user.image!,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(user.username!),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              leading: FaIcon(FontAwesomeIcons.userAlt),
              title: Text('Profile'),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
              leading: FaIcon(FontAwesomeIcons.search),
              title: Text('Search'),
            ),
          ],
        ),
      ),
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
