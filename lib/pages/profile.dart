import 'package:final_project/models/post.dart';
import 'package:final_project/providers/posts_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:final_project/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  int postsNumber = 0;
  int followingNumber = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    followingNumber = user!.following.length;
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20,),
              CircleAvatar(
                backgroundImage: NetworkImage(user.image),
                radius: 40,
              ),
              const SizedBox(width: 60,),
              Column(
                children: [
                  Text('$postsNumber'),
                  const Text("posts")
                ],
              ),
              const SizedBox(width: 60,),
              Column(
                children: [
                  Text('$followingNumber'),
                  const Text("Following")
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            user.email,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Text(
            user.username,
            style: const TextStyle(fontSize: 20),
          ),
          const Divider(thickness: 1),
          Consumer<PostsProvider>(builder: (context, data, child) {
            List<Post> posts = [];
            data.posts.forEach((element) {
              if (user.username == element.creatorName) {
                posts.add(element);
              }
            });
            postsNumber = posts.length;
            return Expanded(
              child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return PostCard(post: posts[index]);
                  }),
            );
          }),
        ],
      ),
    );
  }
}
