/*
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/model/video.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class VideoUploadController extends GetxController {
//instance of the class
  static VideoUploadController instance = Get.find();
  var uuid = Uuid();

  //to upload a video
  uploadVideo(String songName, String caption, String videoPath) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      //Video iD --(UUID=> generate flutter id )
      String id = uuid.v1();
      String videoUrl = await uploadVideoToStorage(id, videoPath);

      String thumbNail = await _uploadVideoThumbToStorage(id, videoPath);

      Video video = Video(
          userName: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: id,
          likes: [],
          commentsCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnail: thumbNail,
          profilePic:
              (userDoc.data()! as Map<String, dynamic>)['profilePics']);

      //data upload in firebase
      await FirebaseFirestore.instance
          .collection('Videos')
          .doc(id)
          .set(video.toJson());
      Get.snackbar('Thanks....', 'Video Uploaded Successfully');
      Get.back();
    } catch (e) {
      Get.snackbar('Error in uploading Video', e.toString());
    }
  }

  Future<String> uploadVideoToStorage(String videoID, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child('videos').child(videoID);

    UploadTask uploadTask = reference.putFile(_compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _compressVideo(String videoPath) async {
    final compressVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressVideo!.file;
  }

  Future<String> _uploadVideoThumbToStorage(String id, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child('thumbnail').child(id);

    UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<File> _getThumb(String videoPath) async {
    final thumbNail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbNail;
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';
import 'dart:io';

import '../model/video.dart';
import '../view/screens/home.dart';



class VideoUploadController extends GetxController{
  static VideoUploadController instance = Get.find();
  var uuid = Uuid();

  Future<File> _getThumb(String videoPath) async{
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadVideoThumbToStorage(String id , String videoPath) async{
    Reference reference = FirebaseStorage.instance.ref().child("thumbnail").child(id);
    UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //Main Video Upload
  //Video To Storage
  //Video Compress
  //Video Thumb Gen
  //Video Thumb To Storage

  uploadVideo(String songName , String caption , String videoPath) async{

    try{
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      //videoID - uuid
      String id  = uuid.v1();
      String videoUrl = await _uploadVideoToStorage( id, videoPath);

      String thumbnail  = await   _uploadVideoThumbToStorage(id , videoPath);
      //IDHAR SE
      print((userDoc.data()! as Map<String , dynamic>).toString());
      Video video = Video(
          uid: uid,
          userName: (userDoc.data()! as Map<String , dynamic>)['name'],
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          songName: songName,
          shareCount: 0,
          commentsCount: 0,
          likes: [],
          profilePic: (userDoc.data()! as Map<String , dynamic>)['profilePic'],
          caption: caption,
          id: id
      );
      await FirebaseFirestore.instance.collection("videos").doc(id).set(video.toJson());
      Get.snackbar("Video Uploaded Successfully", "Thank You Sharing Your Content");

    }catch(e){

      print(e);
      Get.snackbar("Error Uploading Video", e.toString());
      Get.to(HomeScreen());
    }
  }


  Future<String> _uploadVideoToStorage(String videoID , String videoPath) async{
    Reference reference = FirebaseStorage.instance.ref().child("videos").child(videoID);
    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _compressVideo(String videoPath) async{
    final compressedVideo =
    await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }
}
