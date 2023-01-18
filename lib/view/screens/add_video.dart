import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/view/screens/addcaption_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            showDialogOpt(context);
          },
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
            ),
            child: const Center(
              child: Text(
                'Add Video',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showDialogOpt(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    videoPick(ImageSource.gallery, context);
                  },
                  child: const Text('Gallery'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    videoPick(ImageSource.camera, context);
                  },
                  child: const Text('Camera'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                )
              ],
            ));
  }

  videoPick(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);

    if (video != null) {
      Get.snackbar("Video Selected", video.path);
      //  Get.off(AddCaptionScreen(videoFile: File(video.path), videoPath: video.path ));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddCaptionScreen(
                  videoFile: File(video.path), videoPath: video.path)));
    } else {
      Get.snackbar(
          'Error in Selecting Video', 'Please choose an other video file');
    }
  }
}
