import 'package:final_project/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostsProvider extends ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  //* grabs all posts on the database to display them right after logging in
  initializePosts() async {
    if (_posts.isNotEmpty) return;
    final collection =
        await FirebaseFirestore.instance.collection('posts').get();
    collection.docs.forEach((element) {
      final data = element.data();
      Post post = Post(
          element.id,
          data['title'],
          data['body'],
          data['creatorName'],
          data['creatorImage'],
          data['commentCount'],
          data['likeCount'],
          data['creationDate'].toDate());
      _posts.add(post);
    });
    _posts.sort((a, b) => a.creationDate.compareTo(b.creationDate));
    _posts = _posts.reversed.toList();
    notifyListeners();
  }

  //* Clears the _posts when a user logs out of the app
  removeData() {
    _posts.clear();
  }

  //* Adds a post
  addPost(String title, String body, String creatorName,
      String creatorImage) async {
    DateTime date = DateTime.now();
    final doc = await FirebaseFirestore.instance.collection('posts').add({
      'title': title,
      'body': body,
      'creatorName': creatorName,
      'creatorImage': creatorImage,
      'commentCount': 0,
      'likeCount': 0,
      'creationDate': date
    });

    Post newPost =
        Post(doc.id, title, body, creatorName, creatorImage, 0, 0, date);
    _posts.insert(0, newPost);

    notifyListeners();
  }

  //* Deletes a post
  deletePost(index) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(_posts[index].id)
        .delete();
    _posts.removeAt(index);
    notifyListeners();
  }

  addLike(String id, index) async {
    posts.elementAt(index).likeCount++;
    await FirebaseFirestore.instance.collection('posts').doc(id).update({
      'likeCount': posts.elementAt(index).likeCount,
    });
    notifyListeners();
  }

  removeLike(String id, index) async {
    posts.elementAt(index).likeCount--;
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .update({'likeCount': posts.elementAt(index).likeCount});
    notifyListeners();
  }
}
