import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumRotaror extends StatefulWidget {
  String profilePicUrl;

  AlbumRotaror({Key? key, required this.profilePicUrl}) : super(key: key);

  @override
  State<AlbumRotaror> createState() => _AlbumRotarorState();
}

class _AlbumRotarorState extends State<AlbumRotaror > with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller= AnimationController(vsync: this, duration: Duration(seconds: 5));
    controller.forward();
    controller.repeat();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: SizedBox(
        width: 70,
        height: 70,
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.grey, Colors.white]),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image(
                   image: NetworkImage(widget.profilePicUrl),
                  /*image: NetworkImage(
                      'https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),*/
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
