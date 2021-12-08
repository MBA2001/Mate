import 'package:final_project/models/user.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/account_settings');
                    },
                    child: const Text('Account settings')),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await authservice.signOut();
                      Navigator.pop(context);
                    },
                    child: const Text('Sign Out')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
