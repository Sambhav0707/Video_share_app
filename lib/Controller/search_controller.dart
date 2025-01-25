import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Model/user_model.dart';
import 'package:tiktok_clone/constraints.dart';

class SearchController extends GetxController {
  RxList<User> searchUsers = <User>[].obs;

   searchUser(String userName) async {
    searchUsers.bindStream(firebaseCloudFirestore
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: userName)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retVal = [];

      for (var element in query.docs) {
        retVal.add(User.fromSnap(element));
      }
      return retVal;
    }));
  }
}
