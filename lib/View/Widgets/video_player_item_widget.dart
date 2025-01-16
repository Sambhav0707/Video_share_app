import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItemWidget extends StatefulWidget {
  final videoUrl;
  const VideoPlayerItemWidget({super.key, this.videoUrl});

  @override
  State<VideoPlayerItemWidget> createState() => _VideoPlayerItemWidgetState();
}

class _VideoPlayerItemWidgetState extends State<VideoPlayerItemWidget> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    videoPlayerController =
        VideoPlayerController.contentUri(Uri.parse(widget.videoUrl))
          ..initialize().then((value) {
            videoPlayerController.play();
            videoPlayerController.setVolume(1);
          });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(videoPlayerController),
    );
  }
}
