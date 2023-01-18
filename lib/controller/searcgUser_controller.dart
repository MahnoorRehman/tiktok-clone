import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/model/user.dart';

class SearchController extends GetxController {

  final Rx<List<myUser>> _searchUser = Rx<List<myUser>>([]);

  List<myUser> get searchedUsers => _searchUser.value;

  searchUser(String query) async {
    _searchUser.bindStream(
        FirebaseFirestore.instance.collection('users').where(
            'name', isGreaterThanOrEqualTo: query).snapshots().map((
            QuerySnapshot queryRes) {
          List<myUser> retVal = [];
          for (var element in queryRes.docs) {
            retVal.add(myUser.fromSnap(element));
          }
          return retVal;
        })
    );
  }
}
