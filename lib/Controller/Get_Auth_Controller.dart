import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/Model/user_model.dart'as model;
import 'package:tiktok_clone/constraints.dart';

class AuthController extends GetxController{

 static AuthController instance = Get.find();



  Future<String> _uploadToStorage(File image)async{
    Reference ref = firebaseStorage.ref().child('profilePics').child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);

    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;

  }
  late Rx<File?> _pickedImage;

 File? get profilePhoto => _pickedImage.value;

  void pickImage()async{

    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedImage!=null){

      Get.snackbar('Profile picture', 'Profile Picture selected successfully');

      _pickedImage = Rx<File?>(File(pickedImage.path));
    }



  }

  void signUpUser(String username, String password , String email , File? image)async{

    try{
      if(username.isNotEmpty && password.isNotEmpty && email.isNotEmpty && image!= null){
      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim());

      String downloadUrl = await _uploadToStorage(image);

      model.User user = model.User(

          name: username,
          profilePhoto: downloadUrl,
          email: email,
          uid: cred.user!.uid);
      await firebaseCloudFirestore.collection('users').doc(cred.user!.uid).set(user.toJson());

      print('user successfully created');

      }else{
        Get.snackbar('error occures', 'couldn\'t sign up');

      }


    }catch(e){
      
      Get.snackbar('Error creating the account', e.toString());

    }


  }


  void loginUser(String email , String password)async{
    try{
      if(email.isNotEmpty&&password.isNotEmpty){

        await firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
        );
        print('logged in successfully');
      }else{

        Get.snackbar('Error occurred', 'Error while logging you in!!');
      }

    }catch(e){

      Get.snackbar('Error', e.toString());

    }
  }

}