import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Model/video.dart';
import 'package:tiktok_clone/constraints.dart';

class VideoController extends GetxController {
  final RxList<Video> videoList = <Video>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit

    videoList.bindStream(firebaseCloudFirestore
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot snap) {
      List<Video> retVal = [];
      for (var element in snap.docs) {
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    }));
    super.onInit();
  }

  likePost(String id) async {
    final uid = authContoller.user.uid;

    DocumentSnapshot snapshot =
        await firebaseCloudFirestore.collection("videos").doc(id).get();

    if ((snapshot.data()! as dynamic)["likes"].contains(uid)) {
      await firebaseCloudFirestore.collection("videos").doc(id).update({
        "likes": FieldValue.arrayRemove([uid])
      });
    } else {
      await firebaseCloudFirestore.collection("videos").doc(id).update({
        "likes": FieldValue.arrayUnion([uid])
      });
    }
  }
}
