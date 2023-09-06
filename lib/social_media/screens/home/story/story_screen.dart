import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/glass.dart';
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
        return 
           AlertDialog(
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

                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0)

                            )
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),

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
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: whiteColor),
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
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: whiteColor),
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
                                  const Icon(Icons.arrow_back_sharp,
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
                                  const Icon(Icons.keyboard_arrow_down,
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
                              SizedBox(
                                height: 55,
                                child: Row(
                                  children: [

                                    Expanded(
                                      child: TextField(
                                        cursorColor: grayColor,
                                        controller: textEditingController,
                                        decoration: const InputDecoration(
                                            isDense: true,
                                            hintText: "Type Your Comment ",
                                            hintStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(
                                                0xff909090,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.only(left: 2),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(1))
                                            )),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      alignment: Alignment.center,
                                      width: 55,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                      decoration:  const BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        gradient: LinearGradient(
                                          end: Alignment.bottomRight,
                                          begin: Alignment.topLeft,
                                          colors: [
                                            Color.fromRGBO(27, 71, 193, 1),
                                            Color.fromRGBO(49, 219, 199, 1)


                                          ]
                                        )

                                      ),
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
