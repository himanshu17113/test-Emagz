import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/notification/notification_screen.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/posts/home_posts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat/controllers/socketController.dart';

class SocialMediaHomePage extends StatelessWidget {
  SocialMediaHomePage({Key? key}) : super(key: key);

  final jwtController = Get.put(JWTController());
 

  final homePostController = Get.put(HomePostsController());
  final GetXStoryController storyController = Get.put(GetXStoryController());
  final socketController = Get.put(SocketController());
  // final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        backgroundColor: socialBack,
        appBar: homePostController.isVisible.value
            ? AppBar(
                backgroundColor: socialBack,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/png/new_logo.png",
                    color: const Color(0xff1B47C1),
                    height: 38,
                    width: 36,
                  ),
                ),
                actions: [
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.to(() => NotificationScreen()),
                      child: Stack(alignment: Alignment.topRight, children: [
                        Image.asset(
                          "assets/png/notification_bell.png",
                          height: 28,
                          width: 28,
                        ),
                        if (socketController.notifications.isNotEmpty)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.red,
                                child: Text(
                                  socketController.notifications.length.toString(),
                                  style: const TextStyle(fontSize: 12),
                                )),
                          )
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              )
            : null,
        body: RefreshIndicator(
          onRefresh: () {
            homePostController.skip.value = -10;
            homePostController.posts?.clear();
            storyController.stories?.clear();
            storyController.getStories();
            return homePostController.getPost();
          },
          child: HomePosts(myUserId: jwtController.userId ?? homePostController.userId),
        ),
      ),
    ));
  }
}
