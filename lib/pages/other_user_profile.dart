import 'package:final_project/models/post.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:final_project/providers/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/widgets/post_card.dart';

class OthersProfile extends StatefulWidget {
  OthersProfile({Key? key}) : super(key: key);

  @override
  State<OthersProfile> createState() => _OthersProfileState();
}

class _OthersProfileState extends State<OthersProfile> {
  bool firstBuild = true;

  User? user;

  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    List<Post> allPosts = Provider.of<PostsProvider>(context).posts;
    if (firstBuild) {
      for (User u in userProvider.users) {
        if (u.username == data['username']) {
          user = u;
          break;
        }
      }
      for (Post p in allPosts) {
        if (p.creatorName == user!.username) {
          posts.add(p);
        }
      }
      firstBuild = false;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
              user!.username,
              style: const TextStyle(fontSize: 20),
            ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(user!.image),
                  radius: 40,
                ),
                const SizedBox(
                  width: 60,
                ),
                Column(
                  children: [Text('${posts.length}'), const Text("posts")],
                ),
                const SizedBox(
                  width: 60,
                ),
                Column(
                  children: [
                    Text('${user!.following.length}'),
                    const Text("Following")
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              user!.email,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            
            userProvider.user!.following.contains(user!.username)
                ? ElevatedButton.icon(
                    onPressed: () async {
                      await userProvider.unFollow(user!.username);
                      setState(() {});
                    },
                    icon: const Icon(Icons.remove),
                    label: const Text('unfollow'),
                  )
                : ElevatedButton.icon(
                    onPressed: () async {
                      await userProvider.follow(user!.username);
                      setState(() {});
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Follow'),
                  ),
            const Divider(thickness: 1),
            Expanded(
              child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return PostCard(post: posts[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
