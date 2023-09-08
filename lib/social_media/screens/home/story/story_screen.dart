import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/glass.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/widgets/comment_tile/comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:story_view/story_view.dart";

import '../../../../screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/screens/home/story/model/story_model.dart';

import '../screens/post_view/widgets/modal_bottom_sheet.dart';

class StoryScreen extends StatelessWidget {
  late UserId userId;
  late List<Stories> stories;
  StoryScreen({super.key, required this.stories, required this.userId});

  final StoryController controller = StoryController();

  final storyController = Get.put(GetXStoryController());

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = List.generate(stories.length, (index) {
      return stories[index].mediaType == "video"
          ? StoryItem.pageVideo(stories[index].mediaUrl!,
              key: Key(index.toString()), controller: controller)
          : StoryItem.pageImage(
              key: Key(index.toString()),
              url: stories[index].mediaUrl ?? "",
              controller: controller);
    });
    //   StoryItem.pageImage(
    //       url: foodImage[0], controller: controller, imageFit: BoxFit.cover),
    return stories.isNotEmpty
        ? Scaffold(
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
                        storyController.currentStoryIndex.value = int.parse(s
                            .view.key
                            .toString()
                            .substring(3, s.view.key.toString().length - 3));
                      },
                      onComplete: () {
                        //  Navigator.pop(context);
                      },
                      onVerticalSwipeComplete: (direction) {
                        if (direction == Direction.down) {
                          Navigator.pop(context);
                        }
                      } // To disable vertical swipe gestures, ignore this parameter.
                      // Preferrably for inline story view.
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage:
                            CachedNetworkImageProvider(userId.profilePic ?? ""),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userId.username ?? "loading...",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: whiteColor),
                          ),
                          Text(userId.sId ?? "loading...",
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: whiteColor)),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: Material(
                    type: MaterialType.transparency,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: StatefulBuilder(
                          builder: (BuildContext context, setState) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      // storyController.likeStory(stories[
                                      //         storyController
                                      //             .currentStoryIndex.value]
                                      //     .sId
                                      //     .toString());

                                      setState(() {
                                        if (stories[storyController
                                                    .currentStoryIndex.value]
                                                .isLike ??
                                            stories[storyController
                                                    .currentStoryIndex.value]
                                                .likes!
                                                .contains(storyController
                                                    .myId.value)) {
                                          stories[storyController
                                                  .currentStoryIndex.value]
                                              .isLike = false;
                                          stories[storyController
                                                  .currentStoryIndex.value]
                                              .likes!
                                              .remove(
                                                  storyController.myId.value);
                                        } else {
                                          stories[storyController
                                                  .currentStoryIndex.value]
                                              .isLike = true;
                                          stories[storyController
                                                  .currentStoryIndex.value]
                                              .likes!
                                              .add(storyController.myId.value);
                                        }
                                      });
                                    },
                                    child: stories.isEmpty
                                        ? (Image.asset(
                                            "assets/png/unlike_icon.png",
                                            width: 22,
                                          ))
                                        : (stories[storyController
                                                        .currentStoryIndex
                                                        .value]
                                                    .isLike ??
                                                stories[storyController
                                                        .currentStoryIndex
                                                        .value]
                                                    .likes!
                                                    .contains(storyController
                                                        .myId.value))
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  "assets/png/liked_icon.png",
                                                  width: 22,
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  // "assets/png/liked_icon.png",
                                                  "assets/png/unlike_icon.png",
                                                  width: 22,
                                                ),
                                              )),
                                stories.isEmpty
                                    ? const Text('Valid')
                                    : Text(
                                        stories[storyController
                                                .currentStoryIndex.value]
                                            .likes!
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: whiteColor),
                                      ),
                                InkWell(
                                  onTap: () async {
                                    controller.pause();
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        // enableDrag: true,
                                        enableDrag: true,
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        context: context,
                                        builder: (context) {
                                          return Wrap(children: [
                                            PostCommentsModalBottomSheet(
                                              comments: stories[storyController
                                                      .currentStoryIndex.value]
                                                  .comments!,
                                              postId: stories[storyController
                                                      .currentStoryIndex.value]
                                                  .sId!,
                                              isStory: true,
                                            )
                                          ]);
                                        }).whenComplete(() {
                                      controller.play();
                                    });

                                    // updateName(
                                    //     context,
                                    //     stories[storyController
                                    //             .currentStoryIndex.value]
                                    //         .comments!,
                                    //     stories[storyController
                                    //             .currentStoryIndex.value]
                                    //         .sId!,
                                    //     storyController.myId.value);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 8, 5, 8),
                                    child: Image.asset(
                                      "assets/png/comment_icon.png",
                                      width: 22,
                                    ),
                                  ),
                                ),
                                stories.isNotEmpty
                                    ? Text(stories[storyController
                                            .currentStoryIndex.value]
                                        .comments!
                                        .length
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: whiteColor),)
                                    : Text(
                                        'VAlid',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: whiteColor),
                                      ),
                                const SizedBox(
                                  width: 30,
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      shape: const OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20))),
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return ShareStory();
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/png/share_icon.png",
                                    width: 26,
                                  ),
                                ),
                              ],
                            );
                          },
                        )),
                  ),
                ),
              ],
            ))
        : const Text('No Story');
  }

  updateName(BuildContext context, List<Comments> comments, String storyId,
      String myId) {
    print('ndn');
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

          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(50.0),
          //     topRight: Radius.circular(50.0)
          //
          //   ),
          // ),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 400,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GlassmorphicContainer(
                      blur: 6,
                      borderRadius: 2,
                      height: 200,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  "assets/png/unlike_icon.png",
                                  width: 40,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: whiteColor),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    // updateName(context,);
                                  },
                                  child: Image.asset(
                                    "assets/png/comment_icon.png",
                                    width: 40,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${comments.length}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: whiteColor),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Image.asset(
                                  "assets/png/share_icon.png",
                                  width: 40,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.arrow_back_sharp,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                FormHeadingText(
                                  color: Colors.white,
                                  headings: "Comments",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                const Spacer(),
                                FormHeadingText(
                                  color: Colors.white,
                                  headings: "Latest",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
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
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(160, 160, 160, 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 55,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      textAlign: TextAlign.left,
                                      cursorColor: grayColor,
                                      controller: textEditingController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                          isDense: true,
                                          hintText: "Type Your Comment ",
                                          hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(
                                              0xff909090,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(left: 20),

                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    alignment: Alignment.center,
                                    width: 55,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.emoji_emotions_outlined,
                                          color: Color(
                                            0xff909090,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons.attach_file,
                                          color: Color(
                                            0xff909090,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        gradient: LinearGradient(
                                            end: Alignment.bottomRight,
                                            begin: Alignment.topLeft,
                                            colors: [
                                              Color.fromRGBO(27, 71, 193, 1),
                                              Color.fromRGBO(49, 219, 199, 1)
                                            ])),
                                    child: IconButton(
                                        onPressed: () {
                                          storyController.commentStory(
                                              textEditingController.text,
                                              storyId);
                                          comments.add(Comments(
                                            text: textEditingController.text,
                                            userId: myId,
                                          ));
                                          textEditingController.clear();
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.send,
                                          color: Colors.white,
                                          size: 24,
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
