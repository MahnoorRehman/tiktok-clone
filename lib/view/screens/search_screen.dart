import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/model/user.dart';
import 'package:tiktok_clone/view/screens/profile_screen.dart';

import '../../controller/searcgUser_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchQuery = TextEditingController();

  final SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(

          title: TextFormField(
            decoration:  const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Search Username"
            )
            ,controller: searchQuery , onChanged: (value){
            searchController.searchUser(value);
          },),


        ),
        body:  searchController.searchedUsers.isEmpty ?   const Center(
          child: Text("Search Users!"),
        ) :
        ListView.builder(
            itemCount: searchController.searchedUsers.length,
            itemBuilder: (context, index){
              myUser user = searchController.searchedUsers[index];

              return ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(uid: user.uid)));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(

                      user.profilePic
                  ),
                ),

                title: Text(user.name),

              );
            })
        ,
      );
    }
    );
  }
}
