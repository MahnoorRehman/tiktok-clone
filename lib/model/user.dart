import 'package:cloud_firestore/cloud_firestore.dart';

class myUser {
  String name;
  String profilePic;
  String email;
  String uid;

  myUser({required this.name,
    required this.profilePic,
    required this.email,
    required this.uid});

  //Convert Json into Map (App=>Firebase)
  Map<String, dynamic> toJson() {
    return {

      "name": name,
      "profilePic": profilePic,
      "email": email,
      "uid": uid
    };
  }

//Firebase=>App
  static myUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
      return myUser(name: snapshot["name"],
          profilePic: snapshot["profilePic"],
          email: snapshot["email"],
          uid: snapshot["uid"]);

  }
}
