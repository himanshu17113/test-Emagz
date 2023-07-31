import 'dart:ui';

import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:emagz_vendor/social_media/screens/comment/widgets/floatingCommentInput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentViewScreen extends StatefulWidget {
  final Post post;
  final bool isLiked;
  const CommentViewScreen({Key? key, required this.isLiked, required this.post}) : super(key: key);

  @override
  State<CommentViewScreen> createState() => _CommentViewScreenState();
}

class _CommentViewScreenState extends State<CommentViewScreen> {
  var jwtController = Get.put(JWTController());
  String? myUserId;
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  var commentsController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  asyncInit() async {
    myUserId = await jwtController.getUserId();
  }

  @override
  Widget build(BuildContext context) {
    final String url = widget.post.mediaUrl!;

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _changeOpacity();
            },
            child: Container(
              height: Get.size.height,
              // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _changeOpacity();
              // Get.to(() => CommentViewScreen());
            },
            child: AnimatedOpacity(
              opacity: opacityLevel,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10.0,
                      sigmaY: 10.0,
                    ),
                    child: SizedBox(
                      height: Get.size.height / 2,
                      width: Get.width,
                      child: SingleChildScrollView(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            // width: Get.size.width / 2.5,
                            child: Text("${widget.post.caption}",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: whiteColor)),
                          ),
                          // const Expanded(child: SizedBox()),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                (widget.isLiked)
                                    ? Image.asset(
                                        "assets/png/liked_icon.png",
                                        width: 26,
                                      )
                                    : Image.asset(
                                        "assets/png/unlike_icon.png",
                                        width: 22,
                                      ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${widget.post.likes!.length}",
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: whiteColor),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    // updateName(context);
                                  },
                                  child: Image.asset(
                                    "assets/png/comment_icon.png",
                                    width: 22,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${(widget.post.comments!.length + commentsController.instantComments.value.length)}",
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: whiteColor),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Image.asset(
                                  "assets/png/share_icon.png",
                                  width: 26,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            child: const Text(
                              "COMMENT",
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xffD2D2D2)),
                            ),
                          ),
                          if (widget.post.comments != null) ...[
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.post.comments?.length ?? 0,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) => CommentCard(comment: widget.post.comments![index]!),
                            ),
                          ]
                          // Obx(() => ListView.builder(
                          //   shrinkWrap: true,
                          //   itemCount: commentsController.instantComments.value.length,
                          //   physics: ScrollPhysics(),
                          //   itemBuilder: (context, index) => CommentCard(comment: commentsController.instantComments.value[index]),)
                          // )
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 10,
              child: FloatingCommentInput(
                postId: widget.post.sId ?? "",
                onTapExtra: (String text) {
               widget.post.comments!.add(Comment(userId: UserSchema(sId:myUserId ) , text: text));
                  return setState(() {});
                },
              ))
        ],
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;
  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 228,
            child: Text(
              "${comment.text}",
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xffD2D2D2)),
            ),
          ),
          const Text(
            "5:30 PM",
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xffD2D2D2)),
          ),
        ],
      ),
    );
  }
}
