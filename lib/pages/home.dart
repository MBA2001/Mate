import 'package:final_project/models/post.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/providers/posts_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/widgets/post_card.dart';

//TODO: Make like and comment work and the home page will be done

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool firstBuild = true;
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  _displayDialog(BuildContext context,PostsProvider postsProvider,User user) async {
    return showDialog(
        context: context,
        builder: (context,) {
          return AlertDialog(
            title: Text('Add Post'),
            content: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                TextField(
                  controller: bodyController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Body',
                  ),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Add Post'),
                onPressed: () async {
                  await postsProvider.addPost(titleController.text,bodyController.text,user.username,user.image);
                  titleController.clear();
                  bodyController.clear();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final postsProvider = Provider.of<PostsProvider>(context, listen: false);
      postsProvider.initializePosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 5),
          width: 341,
          child: ElevatedButton.icon(
            onPressed: () {
              final postsProvider = Provider.of<PostsProvider>(context,listen: false);
              User user = Provider.of<UserProvider>(context,listen: false).user!;
              _displayDialog(context,postsProvider,user);
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Post'),
          ),
        ),
        Consumer<PostsProvider>(
          builder: (context, PostsProvider data, child) {
            List<Post> posts = data.posts;
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
          },
        )
      ],
    );
  }
}
