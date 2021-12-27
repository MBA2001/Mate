import 'package:final_project/models/user.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  int index;
  User user;
  UserCard({
    Key? key,
    required this.index,
    required this.user,
  }) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.user.image),
      ),
      title: Text(widget.user.username),
      trailing: userProvider.user!.following.contains(widget.user.username)
          ? ElevatedButton.icon(
              onPressed: () async {
                await userProvider.unFollow(widget.user.username);
                setState(() {});
              },
              icon: const Icon(Icons.remove),
              label: const Text('unfollow'),
            )
          : ElevatedButton.icon(
              onPressed: () async {
                await userProvider.follow(widget.user.username);
                setState(() {});
              },
              icon: const Icon(Icons.add),
              label: const Text('Follow'),
            ),
      onTap: () {
        Navigator.pushNamed(context, '/othersProfile',
            arguments: {'username': widget.user.username});
      },
    );
  }
}
