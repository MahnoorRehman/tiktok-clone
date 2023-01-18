import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/view/screens/auth/login_Screen.dart';
import 'package:tiktok_clone/view/screens/home.dart';

import '../model/user.dart';

class AuthController extends GetxController {

  //instance of the class
  static AuthController instance = Get.find();
  io.File? proImg;

  //Pick image form device
  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final img = io.File(image.path);
      this.proImg = img;
    }
  }
//User State Persistence  (User already login or Not)

  late Rx<User?> _user;

  //this get method is for like function
  User get user => _user.value!;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //Rx is Observable Keyword => Check continuously the variable value is changing or not
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());

    //ever function check continuously the changing
    ever(_user, _setInitialView);
  }

  _setInitialView(User? user) {
    if (user == null) {
      Get.to(() => LoginScreen());
    } else {
      Get.to(() =>  HomeScreen());
    }
  }
  //User Register
  SignUp(
    String userName,
    String email,
    String password,
    io.File? image,
  ) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String downloadUrl = await _uploadProPic(image);

        myUser user = myUser(
            name: userName,
            profilePic: downloadUrl,
            email: email,
            uid: credential.user!.uid);

        //upload data to firebase
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error....', "Please Enter all the Fields");
      }
    } catch (e) {
      print('Error is $e');
      Get.snackbar('Error is', e.toString());
    }
  }

  Future<String> _uploadProPic(io.File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePic')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);

    TaskSnapshot taskSnapshot = await uploadTask;
    String imageDwnUrl = await taskSnapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }

  //Login User

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password).then((value){
              Get.offAll(HomeScreen());
        });
      } else {
        Get.snackbar("Error....", "Please Enter Correct email and password");
      }
    } catch (e) {
      Get.snackbar("Error Logging In", e.toString());
    }
  }

  //Signout Mehitd
singOut(){
    FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
}

}
