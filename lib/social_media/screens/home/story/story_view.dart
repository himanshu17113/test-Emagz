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
  final ScrollController _scrollController = ScrollController();

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
      child: FutureBuilder<List<Story?>?>(
        future: storyController.getStories(),
        builder: (context, snapshot) {
          // if (!snapshot.hasData) {
          //   return const Center(
          //     child: Text("Loading..."),
          //   );
          // } else

          if (snapshot.hasData) {
            return Row(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const MyStory(),

                    // InkWell(
                    //     onTap: () {
                    //       Get.to(() =>
                    //           StoryScreen(userId: snapshot.data?[index]?.userId?.sId??'Loding..', stories: snapshot.data![index]!.stories!));
                    //     },
                    //     child: StoryViewCard(
                    //       url: url,
                    //       username: snapshot.data?[index]?.userId?.sId??"64a28b0d31a31c338a18f5f3",
                    //     ))
                  ],
                ),

                SizedBox(
                  width: double.minPositive,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (ctx, index) {
                        if (index == 0) {
                          final String url = "https://picsum.photos/500/500?random=${index + 1}";

                        } else {
                          final String url = "https://picsum.photos/500/500?random=${index + 1}";
                          return InkWell(
                              onTap: () {
                                Get.to(
                                    () => StoryScreen(userId: snapshot.data![index]!.userId!.sId!, stories: snapshot.data![index]!.stories!));
                              },
                              child: StoryViewCard(
                                url: url,
                                username: snapshot.data![index]?.userId?.sId ??  "",
                              ));
                        }
                      }),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}
