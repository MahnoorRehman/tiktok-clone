import 'dart:io';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/upload_video_controller.dart';
import 'package:tiktok_clone/view/widgets/text_input.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCaptionScreen extends StatefulWidget {
  File videoFile;
  String videoPath;

  AddCaptionScreen({Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
  late VideoPlayerController videoPlayerController;

  TextEditingController songNameController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  VideoUploadController videoUploadController =
      Get.put(VideoUploadController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
      videoPlayerController.initialize();
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
      videoPlayerController.setVolume(0.75);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width,
            child: VideoPlayer(videoPlayerController),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInputFiled(
                    controller: songNameController,
                    myIcon: Icons.music_note,
                    mylabelText: 'Song Name'),
                const SizedBox(
                  height: 20,
                ),
                TextInputFiled(
                    controller: captionController,
                    myIcon: Icons.closed_caption,
                    mylabelText: 'Caption'),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    uploadVideo();
                    videoUploadController.uploadVideo(songNameController.text,
                        captionController.text, widget.videoPath);
                  },
                  style: ElevatedButton.styleFrom(primary: buttonColor),
                  child: uploadContent,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget uploadContent =Text('Upload');
  uploadVideo(){
    uploadContent= Text('Please Wait.....');
    setState(() {

    });
  }
}
