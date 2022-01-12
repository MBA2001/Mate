import 'package:final_project/models/post.dart';
import 'package:final_project/pages/comment_page.dart';
import 'package:final_project/providers/posts_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
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
                onPressed: () async{
                  final postsProvider =
                      Provider.of<PostsProvider>(context, listen: false);
                  await postsProvider.deletePost(widget.post.id);
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
                  backgroundImage: NetworkImage(widget.post.creatorImage),
                ),
              ),
              // const SizedBox(width: 10,),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/othersProfile',
                      arguments: {'username': widget.post.creatorName});
                },
                child: Text(
                  widget.post.creatorName,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              // const SizedBox(width: 160,),
              Provider.of<UserProvider>(context, listen: false)
                          .user!
                          .username ==
                      widget.post.creatorName
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
              widget.post.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: Text(widget.post.body),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              user!.likes.contains(widget.post.id)
                  ? TextButton.icon(
                      onPressed: () async {
                        final postsProvider =
                            Provider.of<PostsProvider>(context, listen: false);
                        await postsProvider.removeLike(widget.post.id);
                        await userProvider.removeLike(widget.post.id);
                        setState(() {
                        });
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      label: Text(
                        '${widget.post.likeCount}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  : TextButton.icon(
                      onPressed: () async {
                        final postsProvider =
                            Provider.of<PostsProvider>(context, listen: false);
                        await postsProvider.addLike(widget.post.id);
                        await userProvider.addLike(widget.post.id);
                        setState(() {
                        });
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      ),
                      label: Text(
                        '${widget.post.likeCount}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Comments(comments: widget.post.comments,postId: widget.post.id,)));
                },
                icon: const Icon(
                  Icons.comment,
                  color: Colors.grey,
                ),
                label: Text(
                  '${widget.post.commentCount}',
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
