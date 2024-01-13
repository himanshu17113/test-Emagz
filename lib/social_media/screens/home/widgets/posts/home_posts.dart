import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/post_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../story/story_view.dart';
import 'home_pop_up.dart';

class HomePosts extends StatelessWidget {
  const HomePosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("HomePosts Screen build");
    return GetBuilder<HomePostsController>(
        id: "HomePosts",
        //  assignId: true,
        tag: "HomePostsController",
        init: HomePostsController(),
        autoRemove: false,
        builder: (homePostController) {
          debugPrint("HomePosts --- GetBuilder");
          return ListView.builder(
            //   cacheExtent: 1000,
            padding: const EdgeInsets.only(bottom: 80.0),
            controller: homePostController.scrollController,
            itemCount: homePostController.posts!.length + 2,
            itemBuilder: (context, index) {
              if (index == homePostController.posts!.length + 1) {
                return homePostController.endOfPost
                    ? const SizedBox()
                    : const CupertinoActivityIndicator();
              } else if (index == 0) {
                return const StoryView();
              } else {
                if (homePostController.posts!.isNotEmpty) {
                  if (homePostController
                          .posts![index - 1].mediaUrl!.isNotEmpty &&
                      homePostController.posts?[index - 1].mediaUrl?[0] !=
                          null) {
                    if (homePostController.posts![index - 1].mediaUrl![0]!
                            .endsWith(".svg") ||
                        homePostController.posts?[index - 1].mediaUrl?[0] ==
                            null) {
                      return const SizedBox();
                    } else {
                      return GestureDetector(
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
                                      height: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          HomePagePopupWidget(
                                            title: "View Post",
                                            post: homePostController
                                                .posts![index - 1],
                                          ),
                                          HomePagePopupWidget(
                                            title: "View Stats",
                                            post: homePostController
                                                .posts![index - 1],
                                          ),
                                          HomePagePopupWidget(
                                            title: "Download",
                                            post: homePostController
                                                .posts![index - 1],
                                          ),
                                          HomePagePopupWidget(
                                            title: "Share",
                                            post: homePostController
                                                .posts![index - 1],
                                          ),
                                          HomePagePopupWidget(
                                            title: "Report",
                                            post: homePostController
                                                .posts![index - 1],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: PostCard(
                            index: index - 1,
                            post: homePostController.posts?[index - 1],
                          ));
                    }
                  } else {
                    return const SizedBox();
                  }
                } else {
                  return const CupertinoActivityIndicator();
                }
              }
            },
          );
        });
  }
}
