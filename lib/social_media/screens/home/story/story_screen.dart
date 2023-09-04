import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/widgets/comment_tile/comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:story_view/story_view.dart";

import '../../../../screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/screens/home/story/model/story_model.dart';

class StoryScreen extends StatefulWidget {
  late String userId;
  late List<Stories> stories;
  StoryScreen({super.key, required this.stories, required this.userId});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  StoryController controller = StoryController();

  var storyController = Get.put(GetXStoryController());

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = List.generate(widget.stories.length, (index) {
      return widget.stories[index].mediaType == "video"
          ? StoryItem.pageVideo(widget.stories[index].mediaUrl!, key: Key(index.toString()), controller: controller)
          : StoryItem.pageImage(key: Key(index.toString()), url: widget.stories[index].mediaUrl ?? "", controller: controller);
    });
    //   StoryItem.pageImage(
    //       url: foodImage[0], controller: controller, imageFit: BoxFit.cover),
    return widget.stories.isNotEmpty?Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Material(
              type: MaterialType.transparency,
              child: StoryView(
                  storyItems: storyItems,
                  controller: controller,
                  repeat: false,
                  onStoryShow: (s) {
                    storyController.currentStoryIndex.value = int.parse(s.view.key.toString().substring(3, s.view.key.toString().length - 3));
                  },
                  onComplete: () {
                    Navigator.pop(context);
                  },
                  onVerticalSwipeComplete: (direction) {
                    if (direction == Direction.down) {
                      Navigator.pop(context);
                    }
                  } // To disable vertical swipe gestures, ignore this parameter.
                  // Preferrably for inline story view.
                  ),
            ),
            Material(
              type: MaterialType.transparency,
              child: Container(
                margin: const EdgeInsets.only(top: 70, left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(templateFiveImage[0]),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    FutureBuilder<UserSchema?>(
                      future: storyController.jwtController.getUserDetail(widget.userId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.username ?? "loading...",
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: whiteColor),
                            ),
                            Text(snapshot.data!.username ?? "loading...", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: whiteColor)),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              child: Material(
                type: MaterialType.transparency,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          storyController.likeStory(widget.stories[storyController.currentStoryIndex.value].sId.toString());
                          if (widget.stories[storyController.currentStoryIndex.value].likes!.contains(storyController.myId.value)) {
                            widget.stories[storyController.currentStoryIndex.value].likes!.add(storyController.myId.value);
                          }
                        },
                        child: widget.stories.isEmpty?(Container(
                          child: Image.asset(
                            "assets/png/unlike_icon.png",
                            width: 22,
                          ),
                        )): Obx(() =>(widget.stories[storyController.currentStoryIndex.value].likes!.contains(storyController.myId.value))
                            ? Image.asset(
                                "assets/png/liked_icon.png",
                                width: 22,
                              )
                            : Image.asset(
                                "assets/png/unlike_icon.png",
                                width: 22,
                              )),
                      ),
                      const SizedBox(
                        width: 5,
                      ),

                          widget.stories.isEmpty?const Text('Valid'):
                          Obx(
                                () => Text(
                          widget.stories[storyController.currentStoryIndex.value].likes!.length.toString(),
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: whiteColor),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        onTap: () {
                          updateName(context, widget.stories[storyController.currentStoryIndex.value].comments!,
                              widget.stories[storyController.currentStoryIndex.value].sId!, storyController.myId.value);
                        },
                        child: Image.asset(
                          "assets/png/comment_icon.png",
                          width: 22,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),

                          widget.stories.isNotEmpty?Obx(
                                () => Text(
                          widget.stories[storyController.currentStoryIndex.value].comments!.length.toString())):
                          Text('VAlid',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: whiteColor),
                        ),

                      const SizedBox(
                        width: 30,
                      ),
                      Image.asset(
                        "assets/png/share_icon.png",
                        width: 26,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )):
    Container(
      child: const Text('No Story'),

    )
    ;
  }

  updateName(BuildContext context, List<Comments> comments, String storyId, String myId) {
    TextEditingController textEditingController = TextEditingController();
    return showDialog(
      barrierColor: const Color(0xff252525).withOpacity(.4),
      context: context,
      builder: (ctx) {
        return AlertDialog(
          alignment: Alignment.bottomCenter,
          contentPadding: EdgeInsets.zero,
          iconPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          elevation: 0.0,
          backgroundColor: Colors.transparent,

          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(20),
          // ),
          content: SizedBox(
            height: 400,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  // width: double.infinity,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.white.withOpacity(.5), blurRadius: 20, spreadRadius: 2, offset: const Offset(0, -10))],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [const Color(0xffE7E9FE).withOpacity(.01), const Color(0xffE7E9FE).withOpacity(.02), const Color(0xffE7E9FE)],
                    ),
                    color: Colors.white.withOpacity(.2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        "assets/png/unlike_icon.png",
                        width: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "0",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: whiteColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          // updateName(context,);
                        },
                        child: Image.asset(
                          "assets/png/comment_icon.png",
                          width: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${comments.length}",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: whiteColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/png/share_icon.png",
                        width: 30,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: const Color(0xffE7E9FE),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.arrow_back_sharp),
                            const SizedBox(
                              width: 15,
                            ),
                            FormHeadingText(
                              headings: "Comments",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            const Spacer(),
                            FormHeadingText(
                              headings: "Latest",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Same Boc

                        SizedBox(
                          height: 230,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: comments.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return StoryCommentTile(
                                text: comments[index].text!,
                                userId: comments[index].userId!,
                              );
                            },
                          ),
                        ),

                        // CommentReplyTile(),
                        // StoryCommentTile(),
                        SizedBox(
                          height: 55,
                          child: TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              hintText: "write comment",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: IconButton(
                                    onPressed: () {
                                      storyController.commentStory(textEditingController.text, storyId);
                                      comments.add(Comments(
                                        text: textEditingController.text,
                                        userId: myId,
                                      ));
                                      textEditingController.clear();
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.blue,
                                    )),
                              ),
                              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
