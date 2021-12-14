import 'package:final_project/models/post.dart';
import 'package:final_project/providers/posts_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:final_project/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          CircleAvatar(
            backgroundImage: NetworkImage(user!.image!),
            radius: 50,
          ),
          const SizedBox(height: 20),
          Text(
            '${user.email}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Text(
            '${user.username}',
            style: const TextStyle(fontSize: 20),
          ),
          Divider(thickness: 1),
          Consumer<PostsProvider>(builder: (context, data, child) {
            List<Post> posts = [];
            data.posts.forEach((element) {
              if (user.username == element.creatorName) {
                posts.add(element);
              }
            });

            if (posts.isEmpty) {
              return Container(
                margin: const EdgeInsetsDirectional.all(50),
                child: const CircularProgressIndicator(),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostCard(index: index, post: posts[index]);
                    }),
              );
            }
          }),
        ],
      ),
    );
  }
}
