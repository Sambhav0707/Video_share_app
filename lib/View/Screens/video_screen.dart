import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Controller/video_controller.dart';
import 'package:tiktok_clone/View/Screens/comment_screen.dart';
import 'package:tiktok_clone/View/Widgets/circle_animation.dart';
import 'package:tiktok_clone/View/Widgets/video_player_item_widget.dart';
import 'package:tiktok_clone/constraints.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final VideoController controller = Get.put(VideoController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            itemCount: controller.videoList.length,
            scrollDirection: Axis.vertical,
            controller: PageController(viewportFraction: 1, initialPage: 0),
            itemBuilder: (context, index) {
              final data = controller.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItemWidget(
                    videoUrl: data.videoUrl,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data.username,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      data.caption,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.music_note,
                                          size: 10,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          data.songName,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  buildProfile(data.profilePhoto),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.likePost(data.id);
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: data.likes.contains(
                                                  authContoller.user.uid)
                                              ? Colors.red
                                              : Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        data.likes.length.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(CommentScreen(
                                            id: data.id,
                                          ));
                                        },
                                        child: const Icon(
                                          Icons.comment,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        data.commentsCount.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.reply,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        data.shareCount.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      CircleAnimation(
                                          child: buildMusicAlbum(
                                              data.profilePhoto))
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              );
            });
      }),
    );
  }

  buildProfile(String profilePhotoUrl) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(profilePhotoUrl, fit: BoxFit.cover),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhotoUrl) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhotoUrl),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }
}
