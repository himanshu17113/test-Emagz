import 'dart:ui';

import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/screens/chat/chat_list_screen.dart';
import 'package:emagz_vendor/social_media/screens/explore/explpre_screen.dart';
import 'package:emagz_vendor/social_media/screens/home_screen.dart';
import 'package:emagz_vendor/social_media/screens/post/create_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/settings/personal_page/personal_page_setting.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);

  final List<Widget> screen = [
    SocialMediaHomePage(),
    const ExploreScreen(),
    const CreatePostScreen(),
    const ChatListScreen(),
    const PersonalPageSetting(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePostsController>(
      id: "bottom_Nav",
      tag: "HomePostsController",
      autoRemove: false,
      assignId: true,
      init: HomePostsController(),
      builder: (homePostController) {
        return Stack(
          children: [
            Center(
              child: screen[homePostController.page],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                  height: homePostController.isVisible ? kBottomNavigationBarHeight + 5 : 0,
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(bottom: homePostController.isVisible ? 20 : 0, left: 20, right: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black38,
                    child: ClipRect(
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () => homePostController.pageUpdate(0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/png/home_icon.png",
                                      width: 18,
                                      height: 18,
                                      filterQuality: FilterQuality.high,
                                    ),
                                    const SizedBox(height: 2.5),
                                    const Text(
                                      "Feed",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8.5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => homePostController.pageUpdate(1),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 2.5),
                                    Text(
                                      "Search",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8.5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => homePostController.pageUpdate(2),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 2.5),
                                    Text(
                                      "Create",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8.5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => homePostController.pageUpdate(3),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/png/chat_icon.png",
                                      width: 18,
                                      height: 18,
                                      filterQuality: FilterQuality.high,
                                    ),
                                    const SizedBox(height: 2.5),
                                    const Text(
                                      "Chat",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8.5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => homePostController.pageUpdate(4),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.more_vert_rounded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 2.5),
                                    Text(
                                      "More",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8.5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  )
                  //   : const SizedBox.shrink(),
                  ),
            ),
          ],
        );
      },
    );
  }
}
