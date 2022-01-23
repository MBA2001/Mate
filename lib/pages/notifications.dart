import 'package:final_project/providers/posts_provider.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/notifications.dart';

class Notifs extends StatefulWidget {
  Notifs({Key? key}) : super(key: key);

  @override
  _NotifsState createState() => _NotifsState();
}

class _NotifsState extends State<Notifs> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<PostsProvider>(
          builder: (context, PostsProvider data, child) {
            final user = Provider.of<UserProvider>(context).user;
            List<Notifications> notifications = [];
            for (Notifications item in data.notifications) {
              if (user!.username == item.postCreator && user.username != item.doer) {
                notifications.add(item);
              }
            }


            if (notifications.isEmpty) {
              return const Center(child: Padding(padding:EdgeInsets.all(20),child: Text('you dont have any Notifications yet.'),),);
            } else {
              return Expanded(
                child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: notifications[index].type == 'like'? const Icon(Icons.favorite_border_rounded): const Icon(Icons.comment),
                        title: notifications[index].type == 'like'? Text(notifications[index].doer+' Liked your post'):Text(notifications[index].doer+' commented on your post'),
                        subtitle: Text('Post Title: '+notifications[index].title),
                        onTap: (){
                          //Todo: Send him to this post's comments
                        },
                        
                      );
                    }),
              );
            }
          },
        ),
    );
  }
}