// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tiktok_clone/Model/video.dart';
// import 'package:tiktok_clone/constraints.dart';
// import 'package:video_compress/video_compress.dart';

// class UploadVideoController extends GetxController {
//   _compressVideo(String videoPath) async {
//     final compressedVideo = await VideoCompress.compressVideo(
//       videoPath,
//       quality: VideoQuality.MediumQuality,
//     );

//     return compressedVideo!.file;
//   }

//   Future<String> _uploadVideoToStorage(String id, String videoPath) async {
//     Reference ref = await firebaseStorage.ref().child('videos').child(id);

//     UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));

//     TaskSnapshot snapshot = await uploadTask;

//     String downloadUrl = await snapshot.ref.getDownloadURL();

//     return downloadUrl;
//   }

//   _getThumbnail(String videoPath) async {
//     final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
//     return thumbnail;
//   }

//   Future<String> _uploadImageToStorage(String id, String videoPath) async {
//     Reference ref = firebaseStorage.ref().child('videos').child(id);

//     UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));

//     TaskSnapshot snapshot = await uploadTask;

//     String downloadUrl = await snapshot.ref.getDownloadURL();

//     return downloadUrl;
//   }

//   uploadVideo(String songName, String caption, String videoPath) async {
//     try {
//       String uid = firebaseAuth.currentUser!.uid;

//       DocumentSnapshot userDoc =
//           await firebaseCloudFirestore.collection('users').doc(uid).get();

//       var allDocs = await firebaseCloudFirestore.collection('videos').get();

//       var lenDocs = allDocs.docs.length;

//       String videoUrl =
//           await _uploadVideoToStorage('Video $lenDocs', videoPath);

//       log('video url ${videoUrl}');

//       String thumbnail =
//           await _uploadImageToStorage('Video $lenDocs', videoPath);

//       Video video = Video(
//         username: (userDoc.data()! as Map<String, dynamic>)['name'],
//         uid: uid,
//         id: "Video $lenDocs",
//         likes: [],
//         commentsCount: 0,
//         shareCount: 0,
//         songName: songName,
//         caption: caption,
//         videoUrl: videoUrl,
//         thumbnail: thumbnail,
//         profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
//       );

//       await firebaseCloudFirestore
//           .collection('videos')
//           .doc('Video $lenDocs')
//           .set(video.toJson());

//       Get.back();

//       Get.snackbar('Upload', 'video successfuly uploaded');

//       // showLoadingSnackbar();
//       // Get.back();
//     } catch (e) {
//       Get.snackbar("Error uploading Video", e.toString());
//     }
//   }

//   void showLoadingSnackbar() {
//     Get.snackbar(
//       '',
//       '',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.grey[800],
//       margin: const EdgeInsets.all(16),
//       borderRadius: 8,
//       duration: const Duration(seconds: 3),
//       isDismissible: false,
//       showProgressIndicator: false, // Hide the default progress indicator
//       messageText: const Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//           ),
//           SizedBox(width: 16),
//           Text(
//             'Loading...',
//             style: TextStyle(color: Colors.white, fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Model/video.dart';
import 'package:tiktok_clone/constraints.dart';
import 'package:video_compress/video_compress.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

class UploadVideoController extends GetxController {

  RxBool isLoading = false.obs;
  Future<String> _convertToMp4(String videoPath) async {
    final String outputFilePath = '${videoPath.substring(0, videoPath.lastIndexOf('.'))}.mp4';
    await FFmpegKit.execute(
        '-i $videoPath -c:v libx264 -preset veryfast -crf 28 -c:a aac -b:a 128k -movflags +faststart $outputFilePath');
    return outputFilePath;
  }

  Future<File> _compressVideo(String videoPath) async {
    final String mp4Path = await _convertToMp4(videoPath);
    final compressedVideo = await VideoCompress.compressVideo(
      mp4Path,
      quality: VideoQuality.MediumQuality,
    );

    return compressedVideo!.file!;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<File> _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);

    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<void>uploadVideo(String songName, String caption, String videoPath) async {
    isLoading.value = true;
    try {
      String uid = firebaseAuth.currentUser!.uid;

      DocumentSnapshot userDoc =
          await firebaseCloudFirestore.collection('users').doc(uid).get();

      var allDocs = await firebaseCloudFirestore.collection('videos').get();

      var lenDocs = allDocs.docs.length;

      String videoUrl =
          await _uploadVideoToStorage('Video $lenDocs', videoPath);

      log('Video URL: $videoUrl');

      String thumbnail =
          await _uploadImageToStorage('Video $lenDocs', videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video $lenDocs",
        likes: [],
        commentsCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
      );

      await firebaseCloudFirestore
          .collection('videos')
          .doc('Video $lenDocs')
          .set(video.toJson());

      Get.back();

      Get.snackbar('Upload', 'Video successfully uploaded');
    } catch (e) {
      Get.snackbar("Error uploading video", e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  void showLoadingSnackbar() {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey[800],
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      isDismissible: false,
      messageText: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          SizedBox(width: 16),
          Text(
            'Loading...',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

