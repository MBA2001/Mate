import 'package:final_project/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/account_settings');
                    },
                    child: const Text('Account settings')),
                SizedBox(
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
