import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/view/screens/add_video.dart';
import 'package:tiktok_clone/view/screens/display_Screen.dart';
import 'package:tiktok_clone/view/screens/profile_screen.dart';
import 'package:tiktok_clone/view/screens/search_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//glitch effect
getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];

final pageIndex = [
//  Text('Home'),
  DisplayVideosScreen(),
  // Text('Search'),
  SearchScreen(),
  // Text('Upload Video'),
  AddVideoScreen(),
  Text('Coming Soon'),
  // Text('Profile'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
