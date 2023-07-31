import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/model/story_model.dart';
import 'package:emagz_vendor/social_media/screens/home/story/story_screen.dart';
import 'package:emagz_vendor/social_media/screens/home/story/widgets/my_story/my_story.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/story_view_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryView extends StatefulWidget {
  const StoryView({super.key});

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var storyController = Get.put(GetXStoryController());
    return Container(
      width: Get.size.width,
      margin: const EdgeInsets.only(top: 10),
      height: 85,
      decoration: BoxDecoration(border: Border.all(color: whiteColor, width: 1)),
      child: FutureBuilder<Map<String, Map<String, Story>>>(
        future: storyController.getStories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Loading..."),
            );
          } else {
            return SizedBox(
              width: double.minPositive,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.keys.length,
                  itemBuilder: (ctx, index) {
                    if (index == 0) {
                      final String url = "https://picsum.photos/500/500?random=${index + 1}";
                      return Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const MyStory(),
                          InkWell(
                              onTap: () {
                                Get.to(() => StoryScreen(
                                    userId: snapshot.data!.keys.toList()[index],
                                    stories: snapshot.data![snapshot.data!.keys.elementAt(index)]!.values.toList()));
                              },
                              child: StoryViewCard(
                                url: url,
                                username: snapshot.data!.keys.elementAt(index),
                              ))
                        ],
                      );
                    } else {
                      final String url = "https://picsum.photos/500/500?random=${index + 1}";
                      return InkWell(
                          onTap: () {
                            Get.to(() => StoryScreen(
                                userId: snapshot.data!.keys.toList()[index],
                                stories: snapshot.data![snapshot.data!.keys.elementAt(index)]!.values.toList()));
                          },
                          child: StoryViewCard(
                            url: url,
                            username: snapshot.data!.keys.elementAt(index),
                          ));
                    }
                  }),
            );
          }
        },
      ),
    );
  }
}
