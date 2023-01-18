import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {

  String profilePhotoUrl;

  ProfileButton({Key? key, required this.profilePhotoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        children: [
          Positioned(
            left: 5,
              child: Container(
                width: 60,
                height: 60,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image(
                    image: NetworkImage(profilePhotoUrl),
                 //   image: NetworkImage('https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                    fit: BoxFit.cover,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
