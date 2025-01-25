import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/Controller/Get_Auth_Controller.dart';
import 'package:tiktok_clone/View/Screens/add_video_screen.dart';
import 'package:tiktok_clone/View/Screens/profile_screen.dart';
import 'package:tiktok_clone/View/Screens/search_screen.dart';
import 'package:tiktok_clone/View/Screens/video_screen.dart';

//pages
var pages = [
  // Center(child: Text('HOME SCREEN'),),
  const VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  const Center(
    child: Text('MESSAGES SCREEN'),
  ),
  ProfileScreen( uid: authContoller.user.uid)
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//FIREBASE OPERATIONS CONSTRAINTS

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firebaseCloudFirestore = FirebaseFirestore.instance;

//CONTORLLER

var authContoller = AuthController.instance;
