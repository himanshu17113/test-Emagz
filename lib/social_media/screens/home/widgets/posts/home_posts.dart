import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/post_card.dart';
import 'package:emagz_vendor/social_media/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../story/controller/story_controller.dart';
import '../../story/story_view.dart';

class HomePosts extends StatelessWidget {
  final String? myUserId;
  HomePosts({Key? key, this.myUserId}) : super(key: key);

  final HomePostsController homePostController = Get.find<HomePostsController>();
  final GetXStoryController storyController = Get.put(GetXStoryController());
  @override
  Widget build(BuildContext context) {
     
    return Obx(() => ListView.builder(
          cacheExtent: 2000,
          padding: const EdgeInsets.only(bottom: 80.0),
          controller: homePostController.scrollController,
          //   shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: homePostController.posts!.length + 2,
          itemBuilder: (context, index) {
            if (index == homePostController.posts!.length + 1) {
              return const CupertinoActivityIndicator();
            } else if (index == 0) {
              if (storyController.stories!.isNotEmpty) {
                return StoryView(sid: myUserId ?? homePostController.userId ?? "");
              } else {
                return
                    // const Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: MyStory(
                    //     stories: [],
                    //     userID: null,
                    //   ),
                    // );
                    StoryView(sid: myUserId ?? homePostController.userId ?? "");
                // const SizedBox();
                // const Text("loading");
              }
            } else {
              if (homePostController.posts!.isNotEmpty) {
                if (homePostController.posts![index - 1].mediaUrl!.endsWith(".svg")) {
                  return const SizedBox();
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
                              return const AlertDialog(
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
                                    children: [
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
                        child: homePostController.posts?[index - 1] == null
                            ? const SizedBox()
                            : PostCard(
                            
                                index: index - 1,
                                isLiked: homePostController.posts?[index - 1].likes!.contains(myUserId),
                                myUserId: myUserId,
                                //  post: homePostController.posts?[index - 1],
                                url: homePostController.posts?[index - 1].mediaUrl ?? "",
                                userImg: homePostController.posts?[index - 1].user?.ProfilePic ?? "",
                              ),
                      ));
                }
              } else {
                return const CupertinoActivityIndicator();
              }
            }
          },
        ));
  }
}


