import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/story_screen.dart';
import 'package:emagz_vendor/social_media/screens/home/story/widgets/my_story/my_story.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/story_view_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key});
  // final GetXStoryController storyController = Get.find<GetXStoryController>(tag: "GetXStoryController");

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.size.width,
        margin: const EdgeInsets.only(top: 10),
        height: 85,
        decoration:
            BoxDecoration(border: Border.all(color: whiteColor, width: 1)),
        child: GetBuilder<GetXStoryController>(
          tag: "GetXStoryController",
          id: "storylist",
          init: GetXStoryController(),
          initState: (_) {},
          builder: (storyController) => ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemCount: storyController.stories!.length + 1,
              itemBuilder: (ctx, index) {
                if (index == 0) {
                  if (storyController.stories!.isNotEmpty
                      //  &&
                      //     storyController.stories?[index].userId?.sId ==
                      //         globUserId
                      ) {
                    return SizedBox(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: MyStory(
                        stories: storyController.stories?[index].stories,
                        userID: storyController.stories?[index].userId,
                      ),
                    ));
                  } else {
                    return const SizedBox(
                        child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: MyStory(
                        stories: [],
                        userID: null,
                      ),
                    ));
                  }
                } else if (storyController.stories?[index - 1].stories !=
                        null &&
                    storyController.stories![index - 1].stories!.isNotEmpty) {
                  return InkWell(
                      onTap: () {
                        Get.to(() => StoryScreen(
                            userId: storyController.stories![index - 1].userId!,
                            stories:
                                storyController.stories![index - 1].stories!));
                      },
                      child: StoryViewCard(
                        url: storyController
                                .stories?[index - 1].stories?[0].mediaUrl ??
                            "https://res.cloudinary.com/dzarrma99/image/upload/v1693305203/cbyzdleae3zilg5yf7r5.jpg",
                        username: storyController.stories![index - 1].userId,
                      ));
                } else {
                  return const SizedBox();
                }
              }),
        ));
  }
}
