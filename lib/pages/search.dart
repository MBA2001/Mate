import 'package:final_project/models/user.dart';
import 'package:final_project/widgets/user_card.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

//TODO: Add search bar to search for a specific user

class _SearchState extends State<Search> {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<UserProvider>(
          builder: (context, UserProvider data, child) {
            List<User> users = data.users;
            if (users.isEmpty) {
              return Container(
                margin: const EdgeInsetsDirectional.all(50),
                child: const CircularProgressIndicator(),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return UserCard(index: index, user: users[index]);
                    }),
              );
            }
          },
        ),
    );
  }
}
