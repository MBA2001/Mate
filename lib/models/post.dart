import 'package:final_project/models/comment.dart';

class Post {
  String title;
  String body;
  String creatorName;
  String creatorImage;
  int commentCount;
  int likeCount;
  DateTime creationDate;
  String id;
  List<Comment> comments;
  Post(this.id,this.title,this.body,this.creatorName,this.creatorImage,this.commentCount,this.likeCount,this.creationDate,this.comments);
}