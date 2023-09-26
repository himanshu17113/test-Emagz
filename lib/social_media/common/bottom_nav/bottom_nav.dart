import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/bottom_nav_controller.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);
  final homePostController = Get.put(HomePostsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(
      //  dispose: (state) => ,
      autoRemove: false,
      init: NavController(),
      builder: (value) {
        return Stack(
          children: [
            Center(
              child: value.screen[value.page],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: AnimatedContainer(
                height: value.show ? kBottomNavigationBarHeight : 0,
                duration: Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                decoration: BoxDecoration(color: Colors.black.withOpacity(.2), borderRadius: BorderRadius.circular(15)),
                child: BottomNavigationBar(
                  selectedItemColor: whiteColor,
                  unselectedItemColor: whiteColor,

                  showSelectedLabels: true,
                  // currentIndex: value.page,
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle: TextStyle(fontSize: 7, color: blackButtonColor),
                  unselectedLabelStyle: TextStyle(fontSize: 7, color: grayColor),
                  backgroundColor: Colors.transparent,
                  currentIndex: value.page,
                  elevation: 0.0,
                  onTap: (i) {
                    value.pageUpdate(i);
                    if (i == 0) {
                      homePostController.scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.bounceOut);
                    }
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Image.asset(
                            "assets/png/home_icon.png",
                            width: 19,
                          ),
                        ),
                        label: "Feed"),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Image.asset(
                            "assets/png/explore_icon.png",
                            width: 19,
                          ),
                        ),
                        label: "Explore"),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Image.asset(
                            "assets/png/create_icon.png",
                            width: 19,
                          ),
                        ),
                        label: "Create"),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Image.asset(
                            "assets/png/chat_icon.png",
                            width: 19,
                          ),
                        ),
                        label: "Chat"),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Image.asset(
                            "assets/png/more_icon.png",
                            width: 19,
                          ),
                        ),
                        label: "More"),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
