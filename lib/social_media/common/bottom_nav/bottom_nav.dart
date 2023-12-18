import 'dart:ui';

import 'package:emagz_vendor/constant/colors.dart';
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: BottomNavigationBar(
                        selectedItemColor: whiteColor,
                        unselectedItemColor: whiteColor,
                        showSelectedLabels: true,
                        type: BottomNavigationBarType.fixed,
                        selectedLabelStyle: const TextStyle(fontSize: 7, color: blackButtonColor),
                        unselectedLabelStyle: const TextStyle(fontSize: 7, color: grayColor),
                        backgroundColor: Colors.transparent,
                        currentIndex: homePostController.page,
                        elevation: 0.0,
                        onTap: (i) {
                          homePostController.pageUpdate(i);
                        },
                        items: [
                          BottomNavigationBarItem(
                              icon: Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Image.asset(
                                  "assets/png/home_icon.png",
                                  width: 15,
                                ),
                              ),
                              label: "Feed"),
                          BottomNavigationBarItem(
                              icon: Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Image.asset(
                                  "assets/png/explore_icon.png",
                                  width: 15,
                                ),
                              ),
                              label: "Explore"),
                          BottomNavigationBarItem(
                              icon: Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Image.asset(
                                  "assets/png/create_icon.png",
                                  width: 15,
                                ),
                              ),
                              label: "Create"),
                          BottomNavigationBarItem(
                              icon: Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Image.asset(
                                  "assets/png/chat_icon.png",
                                  width: 15,
                                ),
                              ),
                              label: "Chat"),
                          BottomNavigationBarItem(
                              icon: Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Image.asset(
                                  "assets/png/more_icon.png",
                                  width: 15,
                                ),
                              ),
                              label: "More"),
                        ],
                      ),
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
