import 'package:emagz_vendor/social_media/screens/chat/chat_list_screen.dart';
import 'package:emagz_vendor/social_media/screens/home_screen.dart';
import 'package:emagz_vendor/social_media/screens/settings/personal_page/personal_page_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../screens/explore/explpre_screen.dart';
import '../screens/post/create_post_screen.dart';

class NavController extends GetxController {
  int? position;
  bool isEdit = false;

  List<Widget> screen = [
    const SocialMediaHomePage(),
    const ExploreScreen(),
    // SearchScreen(),

    // const Text("data"),
    CreatePostScreen(),
    // PrePostScreen(),
    // LiveFullScreenLandScapeMode(),
    // LiveScreen(),
    const ChatListScreen(),
    PersonalPageSetting(),

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
  int page = 0;

  pageUpdate(int index) {
    page = index;
    update();
  }
}

