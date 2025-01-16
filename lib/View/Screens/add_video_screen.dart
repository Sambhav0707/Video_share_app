import 'dart:developer';
import 'dart:io';

import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constraints.dart';
import 'package:tiktok_clone/View/Screens/confirm_video_screen.dart';


class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}


class _AddVideoScreenState extends State<AddVideoScreen> {

  pickVideo(ImageSource src , BuildContext context)async{
     final video = await ImagePicker().pickVideo(source: src);

     if(video!=null){
       log('${video.path}');
       Get.to(()=>ConfirmVideoScreen(
         videoFile: File(video.path),
         videoPath: video.path,

       ));
       print('${src}');
     }



  }

  showOptionsDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context)=>
            SimpleDialog(
              children: [

                SimpleDialogOption(
                  onPressed: ()=> pickVideo(ImageSource.gallery , context),
                  child: const Row(
                    children: [
                      Icon(Icons.image,),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: Text('Gallery')),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: ()=> pickVideo(ImageSource.camera , context),
                  child: const Row(
                    children: [
                      Icon(Icons.camera_alt,),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: Text('Camera')),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: (){
                    Get.back();
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.cancel_outlined,),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: Text('Cancel')),
                      ),
                    ],
                  ),
                )

              ],
            )
    );
  }





  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: (){
          setState(() {
            showOptionsDialog(context);
          });
        },
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),

          ),
          child: const Center(
            child: Text('ADD VIDEO',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
          ),
        ),
      ),
    );
  }
}
