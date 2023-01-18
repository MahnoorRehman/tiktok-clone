import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tiktok_clone/view/screens/comment_screen.dart';
import 'package:tiktok_clone/view/screens/profile_screen.dart';

import '../../controller/video_controller.dart';
import '../widgets/album_rotator.dart';
import '../widgets/profile_button.dart';
import '../widgets/tiktok_video_player.dart';

class DisplayVideosScreen extends StatelessWidget {
  DisplayVideosScreen({Key? key}) : super(key: key);

  //initialize the videoController class
  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            itemCount: videoController.videoList.length,
            itemBuilder: (context, index) {
              final data = videoController.videoList[index];

              return InkWell(
                onDoubleTap: () {
                  videoController.likeVideo(data.id);
                },
                child: Stack(
                  children: [
                    TikTokVideoPlayer(
                      videoUrl: videoController.videoList[index].videoUrl,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            data.caption,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            data.songName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 400,
                        //  width: 100,
                        margin: EdgeInsets.only(
                            top: MediaQuery
                                .of(context)
                                .size
                                .height / 3,
                            right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileScreen(uid: data.uid)));
                              },
                              child: ProfileButton(
                                profilePhotoUrl: data.profilePic,
                              ),
                            ),
                            //like
                            InkWell(
                              onTap: () {
                                videoController.likeVideo(data.id);
                              },
                              child: Column(
                                children: [
                                   Icon(
                                    Icons.favorite,
                                    size: 35,
                                    color: data.likes.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                        ? Colors.pinkAccent:Colors.white,
                                  ),
                                  Text(
                                    data.likes.length.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //share
                            InkWell(
                              onTap: (){
                                shareFile(data.id);
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.reply,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data.shareCount.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //commenst
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CommentScreen(
                                              id: data.id,
                                            )));
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.comment,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data.commentsCount.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                AlbumRotaror(
                                  profilePicUrl: data.profilePic,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      }),
    );
  }


  //Share Video
  Future<void> shareFile(String vidId) async {
    await FlutterShare.share(
      title: 'Download My Tiktok',
      text: 'Watch Interesting Short Videos ',

    );
    videoController.shareVideo(vidId);
  }
}
