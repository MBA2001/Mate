import 'package:final_project/models/post.dart';
import 'package:final_project/providers/posts_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final int index;
  final Post post;
  const PostCard({
    Key? key,
    required this.index,
    required this.post,
  }) : super(key: key);

  _alertDialog(context) {
    return showDialog(
        context: context,
        builder: (
          context,
        ) {
          return AlertDialog(
            title: const Text('Delete'),
            content: const Text("Are you sure u want to delete this post?"),
            actions: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.remove),
                label: const Text('No'),
              ),
              TextButton.icon(
                onPressed: () {
                  final postsProvider =
                      Provider.of<PostsProvider>(context, listen: false);
                  postsProvider.deletePost(index);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Yes'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Card(
      elevation: 10,
      color: Colors.grey[700],
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 9),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(post.creatorImage),
                ),
              ),
              // const SizedBox(width: 10,),
              Text(post.creatorName),
              // const SizedBox(width: 160,),
              Provider.of<UserProvider>(context, listen: false)
                          .user!
                          .username! ==
                      post.creatorName
                  ? IconButton(
                      onPressed: () => _alertDialog(context),
                      icon: const Icon(Icons.delete),
                    )
                  : const Opacity(
                      opacity: 0.0,
                      child: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.delete),
                      ),
                    ),
            ],
          ),
          // const SizedBox(height: 20,),
          const Divider(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              post.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: Text(post.body),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              user!.likes.contains(post.id)
                  ? TextButton.icon(
                      onPressed: () async {
                        final postsProvider =
                            Provider.of<PostsProvider>(context, listen: false);
                        await postsProvider.removeLike(post.id, index);
                        await userProvider.removeLike(post.id);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      label: Text(
                        '${post.likeCount}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  : TextButton.icon(
                      onPressed: () async {
                        final postsProvider =
                            Provider.of<PostsProvider>(context, listen: false);
                        await postsProvider.addLike(post.id, index);
                        await userProvider.addLike(post.id);
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      ),
                      label: Text(
                        '${post.likeCount}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment,
                  color: Colors.grey,
                ),
                label: Text(
                  '${post.commentCount}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}