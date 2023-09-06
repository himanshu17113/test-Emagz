import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:emagz_vendor/social_media/screens/comment/widgets/floatingCommentInput.dart';
import 'package:emagz_vendor/social_media/screens/home/story/widgets/comment_tile/comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../screens/auth/widgets/form_haeding_text.dart';
import '../../controller/home/home_controller.dart';

class CommentViewScreen extends StatefulWidget {
  Post post;
  bool isLiked;

  String? myUserId;
  CommentViewScreen({Key? key, required this.isLiked, required this.post, required this.myUserId}) : super(key: key);

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

  var homePostController = Get.put(HomePostsController());
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
                  image: DecorationImage(image: CachedNetworkImageProvider(url), fit: BoxFit.cover),
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
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(

                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0)

                        )
                    ),
                        child: SizedBox(
                          height: Get.size.height / 2,
                          width: Get.width,
                          child: SingleChildScrollView(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                // width: Get.size.width / 2.5,
                                child: Text(widget.post.caption ?? "",
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
                                    GestureDetector(
                                      onTap: () {
                                        homePostController.likePost(widget.post.sId!);
                                        setState(() {
                                          if (widget.isLiked == true) {
                                            widget.post.likes!.removeLast();
                                            widget.isLiked = false;
                                          } else {
                                            widget.post.likes!.add(widget.myUserId!);
                                            widget.isLiked = true;
                                          }
                                        });
                                      },
                                      child: (widget.isLiked)
                                          ? Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Image.asset(
                                                "assets/png/liked_icon.png",
                                                width: 40,
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "assets/png/unlike_icon.png",
                                                width: 40,
                                              ),
                                            ),
                                    ),
                                    Text(
                                      "${widget.post.likes!.length}",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: whiteColor),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // updateName(context);
                                      },
                                      child: Image.asset(
                                        "assets/png/comment_icon.png",
                                        width: 40,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${(widget.post.comments!.length + commentsController.instantComments.value.length)}",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: whiteColor),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Image.asset(
                                      "assets/png/share_icon.png",
                                      width: 35,
                                    ),
                                  ],
                                ),
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
                              if (widget.post.comments != null) ...[
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(bottom: 100),
                                  itemCount: widget.post.comments?.length ?? 0,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (context, index) => StoryCommentTile(text: widget.post.comments![index]!.text!, userId: widget.post.comments![index]!.userId!.sId!),
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
            // Positioned(
            //     width: MediaQuery.of(context).size.width,
            //     bottom: 10,
            //     child: FloatingCommentInput(
            //       postId: widget.post.sId ?? "",
            //       onTapExtra: (String text) {
            //         widget.post.comments!.add(Comment(userId: UserSchema(sId: myUserId), text: text));
            //         return setState(() {});
            //       },
            //     ))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingCommentInput(
            postId: widget.post.sId ?? "",
            onTapExtra: (String text) {
              widget.post.comments!.add(Comment(userId: UserSchema(sId: myUserId), text: text));
            }));
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
          SizedBox(
            width: 228,
            child: Text(
              comment.text ?? "",
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xffD2D2D2)),
            ),
          ),
          Text(
            comment.timestamp?.toString() ?? "5:30 PM",
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xffD2D2D2)),
          ),
        ],
      ),
    );
  }
}
