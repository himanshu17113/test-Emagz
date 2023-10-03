import 'package:emagz_vendor/social_media/screens/chat/chat_list_screen.dart';
import 'package:emagz_vendor/social_media/screens/home_screen.dart';
import 'package:emagz_vendor/social_media/screens/settings/personal_page/personal_page_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/explore/explpre_screen.dart';
import '../screens/post/create_post_screen.dart';
 
class NavController extends GetxController {
  // int? position;
  // bool isEdit = false;
 

  List<Widget> screen = [
    SocialMediaHomePage(),
    const ExploreScreen(),
    // SearchScreen(),

    // const Text("data"),
    const CreatePostScreen(),
    // PrePostScreen(),
    // LiveFullScreenLandScapeMode(),
    // LiveScreen(),
    const ChatListScreen(),
    const PersonalPageSetting(),

    // Material(
    //   child: PopupMenuButton<int>(
    //     itemBuilder: (context) => [
    //       // PopupMenuItem 1
    //       PopupMenuItem(
    //         value: 1,
    //         // row with 2 children
    //         child: Row(
    //           children: [
    //             Icon(Icons.star),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             FormHeadingText(headings: "headings"),
    //             Text(
    //               "Get The App",
    //             )
    //           ],
    //         ),
    //       ),
    //       // PopupMenuItem 2
    //       PopupMenuItem(
    //         value: 2,
    //         // row with two children
    //         child: Row(
    //           children: [
    //             Icon(Icons.chrome_reader_mode),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             Text("About")
    //           ],
    //         ),
    //       ),
    //     ],
    //     offset: Offset(0, 100),
    //     color: Colors.grey,
    //     elevation: 2,
    //     // on selected we show the dialog box
    //     onSelected: (value) {
    //       // if value 1 show dialog
    //       if (value == 1) {
    //         // _showDialog(context);
    //         // if value 2 show dialog
    //       } else if (value == 2) {
    //         // _showDialog(context);
    //       }
    //     },
    //   ),
    // ),
  ];
  RxInt page = RxInt(0);

  // pageUpdate(int index) {
  //   page.value = index;
  //   if (index == 0) {
  //     if (homePostController.scrollController.positions.isNotEmpty) {
  //       homePostController.scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.bounceOut);
  //     }
  
  //   }
  //   //   update();
  // }
}
