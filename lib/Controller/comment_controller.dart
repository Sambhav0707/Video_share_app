import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tiktok_clone/Model/comment.dart';
import 'package:tiktok_clone/constraints.dart';

class CommentController extends GetxController {
  RxList<Comment> comments = <Comment>[].obs;
  String postId = "";

  updatepostId(String id) {
    postId = id;

    getComments();
  }

  getComments() async {
    comments.bindStream(firebaseCloudFirestore
        .collection("videos")
        .doc(postId)
        .collection("comments")
        .snapshots()
        .map((QuerySnapshot query) {
      final List<Comment> returnList = [];

      for (var element in query.docs) {
        returnList.add(Comment.fromSnap(element));
      }
      return returnList;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        // Post comment logic here
        DocumentSnapshot userDoc = await firebaseCloudFirestore
            .collection("users")
            .doc(authContoller.user.uid)
            .get();

        var allDocs = await firebaseCloudFirestore
            .collection("videos")
            .doc(postId)
            .collection("comments")
            .get();

        int len = allDocs.docs.length;

        Comment comment = Comment(
          username: (userDoc.data()! as dynamic)["name"],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (userDoc.data()! as dynamic)["profilePhoto"],
          uid: authContoller.user.uid,
          id: "Comment $len",
        );

        await firebaseCloudFirestore
            .collection("videos")
            .doc(postId)
            .collection("comments")
            .doc("Comment $len")
            .set(comment.toJson());

        DocumentSnapshot doc =
            await firebaseCloudFirestore.collection("videos").doc(postId).get();

        await firebaseCloudFirestore.collection("videos").doc(postId).update({
          "commentsCount": (doc.data()! as dynamic)["commentsCount"] + 1,
        });
      }
    } catch (e) {
      Get.snackbar("error while posting commment", e.toString());
    }
  }

  DateTime convertFirestoreTimestampToDateTime(Timestamp timestamp) {
  return timestamp.toDate();
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat("MMMM d, y 'at' h:mm:ss a 'UTC'xxx");
  return formatter.format(dateTime.toUtc());
}


  String getRelativeTime(String dateTimeString) {
    try {
      DateTime parsedTime = DateTime.parse(dateTimeString).toLocal();
      DateTime presentTime = DateTime.now();

      Duration difference = presentTime.difference(parsedTime);

      if (difference.inMinutes < 1) {
        return "Just now";
      } else if (difference.inMinutes == 1) {
        return "${difference.inMinutes} min ago";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} mins ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} hours ago";
      } else if (difference.inDays == 1) {
        return "Yesterday";
      } else {
        return "${difference.inDays} days ago";
      }
    } catch (error) {
      log('error occuered :- ${error.toString()}');

      return "invalid time/ date";
    }
  }


String processFirestoreTimestamp(Timestamp timestamp) {
  // Convert Firestore Timestamp to DateTime
  DateTime dateTime = convertFirestoreTimestampToDateTime(timestamp);

  // Format DateTime as a string
  String formattedDate = formatDateTime(dateTime);

  // Get relative time representation
  String relativeTime = getRelativeTime(dateTime.toIso8601String());

  return relativeTime;
}
}
