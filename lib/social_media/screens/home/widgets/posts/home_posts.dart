import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/post_card.dart';
import 'package:emagz_vendor/social_media/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../story/story_view.dart';

class HomePosts extends StatelessWidget {
  final String? myUserId;
  HomePosts({Key? key, this.myUserId}) : super(key: key);

  final HomePostsController homePostController =
      Get.find<HomePostsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
     ListView.builder(
          padding: const EdgeInsets.only(bottom: 80.0),
          controller: homePostController.scrollController,
          //   shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: homePostController.posts!.length+1,
          itemBuilder: (context, index) {
            if (index == homePostController.posts!.length) {
              return const CupertinoActivityIndicator();
            }
            if (index == 0) {
              return StoryView();
            } else {
              return InkWell(
                  onTap: () {
                    // Get.to(() => ExploreScreen());
                  },
                  onLongPress: () {
                    showDialog(
                        barrierColor: Colors.black.withOpacity(.5),
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            iconPadding: EdgeInsets.zero,
                            titlePadding: EdgeInsets.zero,
                            buttonPadding: EdgeInsets.zero,
                            actionsPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,
                            elevation: 0.0,
                            actionsAlignment: MainAxisAlignment.center,
                            alignment: Alignment.center,
                            backgroundColor: Colors.transparent,
                            content: SizedBox(
                              height: 250,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  HomePagePopupWidget(
                                    isBorder: false,
                                    title: "View Post",
                                  ),
                                  HomePagePopupWidget(
                                    title: "View Stats",
                                  ),
                                  HomePagePopupWidget(
                                    title: "Download",
                                  ),
                                  HomePagePopupWidget(
                                    title: "Share",
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: VisibilityDetector(
                    key: Key("$index+@4+1999"),
                    onVisibilityChanged: (info) {
                      if (index - 9 >= homePostController.skip.value) {
                        // debugPrint(info.visibleFraction);
                        // setState(() {});
                      }
                    },
                    child: homePostController.posts?[index] == null
                        ? const SizedBox()
                        : PostCard(
                            isLiked: homePostController.posts?[index].likes!
                                .contains(myUserId),
                            myUserId: myUserId,
                            post: homePostController.posts?[index],
                            url:
                                homePostController.posts?[index].mediaUrl ?? "",
                          ),
                  ));
            }
          },
        ));
  }
}
