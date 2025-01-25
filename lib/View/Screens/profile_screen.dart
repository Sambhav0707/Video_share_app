import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    profileController.getUid(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      if (controller.users.value.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          leading: const Icon(
            Icons.person_add_alt_1_outlined,
          ),
          title: Text(
            profileController.users.value["name"],
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: profileController.users.value["profilePhoto"],
                        height: 100,
                        width: 100,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProfileInfo(
                        profileController.users.value["following"],
                        "Following"),
                    const SizedBox(
                      width: 15,
                    ),
                    _buildProfileInfo(
                        profileController.users.value["followers"],
                        "Followers"),
                    const SizedBox(
                      width: 15,
                    ),
                    _buildProfileInfo(
                        profileController.users.value["likes"], "Likes"),
                  ],
                )
              ],
            )
          ],
        )),
      );
    });
  }

  Widget _buildProfileInfo(String uppertText, String downText) {
    return Container(
      height: 50,
      child: Column(
        children: [
          Text(
            uppertText,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            downText,
            style: const TextStyle(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
