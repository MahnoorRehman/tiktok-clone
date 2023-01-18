import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String userName;
  String comment;
  final datePub;
  List likes;
  String profilePic;
  String uid;
  String id;

  Comment(
      {required this.userName,
      required this.comment,
      required this.datePub,
      required this.likes,
      required this.profilePic,
      required this.uid,
      required this.id});

  Map<String, dynamic> toJosn() => {
        'userName': userName,
        'comment': comment,
        'datePub': datePub,
        'likes': likes,
        'profilePic': profilePic,
        'uid': uid,
        'id': id,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return Comment(
        userName: snapShot['userName'],
        comment: snapShot['comment'],
        datePub: snapShot['datePub'],
        likes: snapShot['likes'],
        profilePic: snapShot['profilePic'],
        uid: snapShot['uid'],
        id: snapShot['id']);
  }
}
