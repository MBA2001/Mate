import 'package:final_project/models/comment.dart';
import 'package:final_project/providers/posts_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  final List<Comment> comments;
  final String postId;
  const Comments({Key? key, required this.comments, required this.postId})
      : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController controller = TextEditingController();

  _alertDialog(context, String id) {
    return showDialog(
        context: context,
        builder: (
          context,
        ) {
          return AlertDialog(
            title: const Text('Delete'),
            content: const Text("Are you sure u want to delete this comment?"),
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
                  await postsProvider.deleteComment(id, widget.postId);
                  setState(() {
                    
                  });
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.comments.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 150),
                    child: Text('This post has no comments'),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: widget.comments.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          widget.comments[index].creatorImage),
                                    ),
                                  ),
                                  Text(widget.comments[index].creatorName),
                                  SizedBox(
                                    width: 180,
                                  ),
                                  Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .user!
                                              .username ==
                                          widget.comments[index].creatorName
                                      ? IconButton(
                                          onPressed: () => _alertDialog(context,
                                              widget.comments[index].id),
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
                              Text(widget.comments[index].body),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          );
                        }),
                  ),
            const Divider(
              thickness: 2,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(7, 0, 7, 5),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Add a comment',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final user =
                          Provider.of<UserProvider>(context, listen: false)
                              .user;
                      final postsProvider =
                          Provider.of<PostsProvider>(context, listen: false);
                      Comment comm = await postsProvider.addComment(
                          controller.text,
                          widget.postId,
                          user!.username,
                          user.image);
                      setState(() {});
                      controller.clear();
                    },
                    icon: const Icon(Icons.post_add),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
