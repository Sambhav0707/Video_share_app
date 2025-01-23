import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Controller/upload_video_controller.dart';
import 'package:tiktok_clone/View/Widgets/input_form.dart';
import 'package:video_player/video_player.dart';

class ConfirmVideoScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmVideoScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmVideoScreen> createState() => _ConfirmVideoScreenState();
}

class _ConfirmVideoScreenState extends State<ConfirmVideoScreen> {
  late VideoPlayerController controller;
  final TextEditingController songController = TextEditingController();
  final TextEditingController captionController = TextEditingController();

  final UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  @override
  void initState() {
    controller = VideoPlayerController.file(widget.videoFile);
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();
                });
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                child: VideoPlayer(controller),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: InputForms(
                      controller: songController,
                      labelText: 'song name',
                      icon: Icons.music_note,
                      isObscure: false,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: InputForms(
                      controller: captionController,
                      labelText: 'Caption',
                      icon: Icons.closed_caption,
                      isObscure: false,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.red, // Set the background color to red
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20)), // Make the button rectangular
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12), // Optional: Adjust padding
                          ),
                          onPressed: () async {
                            await uploadVideoController.uploadVideo(
                                songController.text,
                                captionController.text,
                                widget.videoPath);
                            Get.back();
                          },
                          child: Obx(() {
                            if (uploadVideoController.isLoading.value) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ));
                            } else {
                              return const Text(
                                'share',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              );
                            }
                          })),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
