import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:tiktok_clone/Controller/comment_controller.dart';
import 'package:tiktok_clone/constraints.dart';

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({super.key, required this.id});

  final TextEditingController commentsController = TextEditingController();
  final CommentController controller = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    controller.updatepostId(id);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                        itemCount: controller.comments.length,
                        itemBuilder: (context, index) {
                          final data = controller.comments[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(data.profilePhoto),
                              backgroundColor: Colors.black,
                            ),
                            title: Row(
                              children: [
                                Text(
                                  data.username,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  controller.processFirestoreTimestamp(
                                      data.datePublished),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${data.likes.length} likes',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                )
                              ],
                            ),
                            subtitle: ReadMoreText(
                              trimMode: TrimMode.Line,
                              trimLines: 2,
                              colorClickableText: Colors.red.shade200,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              moreStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade200),
                              data.comment,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                controller.likeComment(data.id);
                              },
                              child: Icon(
                                Icons.favorite,
                                color:
                                    data.likes.contains(authContoller.user.uid)
                                        ? Colors.red
                                        : Colors.white,
                              ),
                            ),
                          );
                        });
                  }),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                ListTile(
                  title: TextFormField(
                      controller: commentsController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        labelText: 'Add a comment',
                        labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
                      )),
                  trailing: TextButton(
                    onPressed: () {
                      controller.postComment(commentsController.text.trim());
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
