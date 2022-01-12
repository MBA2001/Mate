import 'package:final_project/models/comment.dart';
import 'package:final_project/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostsProvider extends ChangeNotifier {
  List<Post> _posts = [];
  List<Comment> _comments = [];

  List<Post> get posts => _posts;

  //* grabs all posts on the database to display them right after logging in
  initializePosts() async {
    if (_posts.isNotEmpty) return;
    final collection1 =
        await FirebaseFirestore.instance.collection('comments').get();
    collection1.docs.forEach((element) {
      final data = element.data();
      Comment comment = Comment(
          element.id,
          data['postId'],
          data['body'],
          data['creatorName'],
          data['creatorImage'],
          data['creationDate'].toDate());
      _comments.add(comment);
    });
    _comments.sort((a, b) => a.creationDate.compareTo(b.creationDate));
    _comments = _comments.reversed.toList();
    final collection =
        await FirebaseFirestore.instance.collection('posts').get();
    collection.docs.forEach((element) {
      final data = element.data();
      List<Comment> postComments = [];
      for (Comment comment in _comments) {
        if (comment.postId == element.id) {
          postComments.add(comment);
        }
      }
      Post post = Post(
          element.id,
          data['title'],
          data['body'],
          data['creatorName'],
          data['creatorImage'],
          data['commentCount'],
          data['likeCount'],
          data['creationDate'].toDate(),
          postComments);
      _posts.add(post);
      print(post.comments);
    });
    _posts.sort((a, b) => a.creationDate.compareTo(b.creationDate));
    _posts = _posts.reversed.toList();
    notifyListeners();
  }

  //* Clears the _posts when a user logs out of the app
  removeData() {
    _posts.clear();
    _comments.clear();
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
        Post(doc.id, title, body, creatorName, creatorImage, 0, 0, date, []);
    _posts.insert(0, newPost);

    notifyListeners();
  }

  //* Deletes a post
  deletePost(String id) async {
    await FirebaseFirestore.instance.collection('posts').doc(id).delete();
    _posts.removeAt(_posts.indexWhere((element) => element.id == id));
    notifyListeners();
  }

  addLike(String id) async {
    int likeCount = 0;
    for (var post in _posts) {
      if (post.id == id) {
        post.likeCount++;
        likeCount = post.likeCount;
      }
    }
    await FirebaseFirestore.instance.collection('posts').doc(id).update({
      'likeCount': likeCount,
    });
    notifyListeners();
  }

  removeLike(String id) async {
    int likeCount = 0;
    for (var post in _posts) {
      if (post.id == id) {
        post.likeCount--;
        likeCount = post.likeCount;
      }
    }
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .update({'likeCount': likeCount});
    notifyListeners();
  }

  Future<Comment> addComment(String body, String postId, String creatorName,
      String creatorImage) async {
    DateTime date = DateTime.now();
    final doc = await FirebaseFirestore.instance.collection('comments').add({
      'body': body,
      'creatorName': creatorName,
      'creatorImage': creatorImage,
      'creationDate': date,
      'postId': postId
    });

    Comment newComment =
        Comment(doc.id, postId, body, creatorName, creatorImage, date);
    _comments.insert(0, newComment);
    for (Post post in _posts) {
      if (post.id == postId) {
        post.comments.insert(0, newComment);
        post.commentCount++;
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({
          'commentCount': post.commentCount,
        });
      }
    }
    notifyListeners();
    return newComment;
  }

  deleteComment(String id, postId) async {
    await FirebaseFirestore.instance.collection('comments').doc(id).delete();
    Post affectedPost =
        _posts.elementAt(_posts.indexWhere((element) => element.id == postId));
    affectedPost.comments.remove(_comments
        .elementAt(_comments.indexWhere((element) => element.id == id)));
    affectedPost.commentCount--;
    _comments.removeAt(_comments.indexWhere((element) => element.id == id));
    await FirebaseFirestore.instance.collection('posts').doc(postId).update({
      'commentCount': affectedPost.commentCount,
    });
    notifyListeners();
  }
}
