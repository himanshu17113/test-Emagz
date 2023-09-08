import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/social_media/screens/home/story/model/story_model.dart';

import 'package:emagz_vendor/social_media/screens/home/story/widgets/story_selection/ModalBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../story_screen.dart';

class MyStory extends StatelessWidget {
  final UserId? userID;
  final List<Stories>? stories;
  const MyStory({super.key, this.stories, this.userID});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (stories == [] || userID == null) {
          return;
        } else {
          Get.to(() => StoryScreen(userId: userID!, stories: stories!));
        }
      },
      child: Container(
        height: 55,
        width: 55,
        alignment: Alignment.centerRight,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/png/story_border.png"),
              fit: BoxFit.contain),
        ),
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(-48 / 360),
          child: Stack(
            children: [
              Positioned(
                top: 24,
                left: 7.3,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //   border: Border.all( color: ),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(stories!.isNotEmpty
                            ? stories![0].mediaUrl ??
                                "https://picsum.photos/500/500?random=0"
                            : "https://picsum.photos/500/500?random=0"),
                        fit: BoxFit.cover),
                  ),
                  // child: Image.network(
                  //   url,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              Positioned(
                top: 45,
                left: 10,
                child: IconButton(
                  alignment: Alignment.centerLeft,
                  iconSize: 10,
                  onPressed: () {
                    showModalBottomSheet(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return const StorySelectionBottomSheet();
                        });
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33),
                      border: Border.all(color: Colors.white, width: 2),
                      color: const Color(0xff3B12AA),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
