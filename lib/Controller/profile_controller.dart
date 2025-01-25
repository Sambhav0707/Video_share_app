import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constraints.dart';

class ProfileController extends GetxController {
  Rx<Map<String, dynamic>> users = Rx<Map<String, dynamic>>({});

  RxString userUid = ''.obs;

  void getUid(String uid) {
    userUid.value = uid;
    getUserData();
  }

  void getUserData() async {
    List<String> thumbnails = [];

    var myVideos = await firebaseCloudFirestore
        .collection("videos")
        .where("uid", isEqualTo: userUid.value)
        .get();

    for (var video = 0; video < myVideos.docs.length; video++) {
      thumbnails.add((myVideos.docs[video].data() as dynamic)["thumbnail"]);
    }

    DocumentSnapshot userDoc = await firebaseCloudFirestore
        .collection("users")
        .doc(userUid.value)
        .get();

    final userData = userDoc.data() as dynamic;

    String username = userData["name"];
    String profilePhoto = userData["profilePhoto"];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    var followersDoc = await firebaseCloudFirestore
        .collection("users")
        .doc(userUid.value)
        .collection("followers")
        .get();
    var followingDoc = await firebaseCloudFirestore
        .collection("users")
        .doc(userUid.value)
        .collection("following")
        .get();

    followers = followersDoc.docs.length;
    following = followingDoc.docs.length;

    firebaseCloudFirestore
        .collection("users")
        .doc(userUid.value)
        .collection("followers")
        .doc(authContoller.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    users.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': username,
      'isFollowing': isFollowing,
      'thumbnails': thumbnails,
    };
    update();
  }
}
