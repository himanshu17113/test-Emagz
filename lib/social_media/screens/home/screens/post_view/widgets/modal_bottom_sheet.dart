import 'dart:developer';
import 'package:emagz_vendor/constant/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/comment_tile/comment_tile.dart';
import '../../../../../../constant/colors.dart';
import '../../../../../../screens/auth/widgets/form_haeding_text.dart';
import '../../../../../models/user_schema.dart';
import 'glass.dart';

class PostCommentsModalBottomSheet extends StatefulWidget {
  VoidCallback? update;
  final String postId;
  final String? postuID;
  bool? islike;
  int? likelength;
  final int? index;
  List<Comment?> comments;
  final bool isblurNeeded;
  final bool? isStory;
  PostCommentsModalBottomSheet({
    super.key,
    this.update,
    required this.postId,
    this.islike,
    required this.likelength,
    this.index,
    required this.comments,
    this.isblurNeeded = false,
    this.isStory = false,
    this.postuID,
  });

  @override
  State<PostCommentsModalBottomSheet> createState() => _PostCommentsModalBottomSheetState();
}

class _PostCommentsModalBottomSheetState extends State<PostCommentsModalBottomSheet> {
  final commentsController = Get.put(CommentController());

  double mainHeight = 450;

  @override
  void dispose() {
    commentsController.setedCommentIdclear();
    debugPrint("👺👺👺👺👺commentsController.setedCommentIdclear();👺👺👺👺👺");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
        borderRadius: widget.isblurNeeded ? 33 : 0,
        blur: widget.isblurNeeded ? 6 : 0,
        height: MediaQuery.of(context).size.height * .56,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0))),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: (widget.islike ?? true)
                          ? Image.asset(
                              "assets/png/liked_icon.png",
                              width: 26,
                            )
                          : Image.asset(
                              "assets/png/unlike_icon.png",
                              width: 22,
                            )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.likelength?.toString() ?? "0",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: whiteColor),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "assets/png/comment_icon.png",
                      width: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.comments.length}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: whiteColor),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const FormHeadingText(
                      color: Colors.white,
                      headings: "Comments",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              widget.comments.isNotEmpty
                  ? Expanded(
                      //   height: MediaQuery.of(context).size.height * .37,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(4.0),
                        physics: const ScrollPhysics(),
                        itemCount: widget.comments.length,
                        itemBuilder: (context, index) {
                          return PostCommentTile(
                            postuID: widget.postuID,
                            comment: widget.comments[index]!,
                            index: index,
                            postId: widget.postId,
                          );
                        },
                      ),
                    )
                  : const Spacer(),
              Obx(() => commentsController.isCommentingOnPost.value
                  ? const SizedBox()
                  : Container(
                      width: MediaQuery.of(context).size.width * .88,
                      height: 30,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        color: Colors.white60,
                      ),
                      //decoration: const BoxDecoration(borderRadius: BorderRadiusDirectional.horizontal(start: Radius.elliptical(35), end: Radius.circular(35))),
                      alignment: Alignment.bottomCenter,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "replying to ${commentsController.commentOwner.value}",
                            style: const TextStyle(color: Colors.brown),
                          ),
                          IconButton(
                              onPressed: () => setState(() {
                                    commentsController.isCommentingOnPost.value = true;
                                    commentsController.focusNode.unfocus();
                                  }),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 15,
                              ))
                        ],
                      ),
                    )),
              Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 55,
                width: MediaQuery.of(context).size.width * .95,
                child: TextField(
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  textAlignVertical: TextAlignVertical.center,
                  focusNode: commentsController.focusNode,
                  controller: commentsController.controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    hintText: "Type your Comment",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    suffixIcon: Container(
                      padding: const EdgeInsets.all(0),
                      width: 100,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                              end: Alignment.bottomRight,
                              begin: Alignment.topLeft,
                              colors: [Color.fromRGBO(27, 71, 193, 1), Color.fromRGBO(49, 219, 199, 1)])),
                      child: IconButton(
                          onPressed: () async {
                            if (!widget.isStory!) {
                              if (commentsController.isCommentingOnPost.value) {
                                var x = await commentsController.postComment(widget.postId, widget.postuID!);
                                setState(() {
                                  widget.comments.add(x);
                                  widget.update!();
                                  commentsController.controller.clear();
                                });
                              } else {
                                if (commentsController.isPosting.value) {
                                  debugPrint("sending comment");
                                } else {
                                  if (!commentsController.isCommentingOnReply.value) {
                                    Comment x = await commentsController.postReply(
                                      widget.postId,
                                      commentsController.commentId.value,
                                      commentsController.controller.text,
                                      widget.postuID!,
                                      //     commentsController.commentId.value
                                    );
                                    debugPrint("rp------- ${x.sId}");
                                    if (x.sId != null) {
                                      setState(() {
                                        widget.comments[commentsController.commentindex.value]?.comments?.add(x);
                                        commentsController.controller.clear();
                                      });
                                    }
                                  } else {
                                    Comment x = await commentsController.replyonreply(
                                      widget.postId,
                                      commentsController.commentId.value,
                                      commentsController.controller.text,
                                      widget.postuID!,
                                      //    commentsController.commentId.value
                                    );
                                    log("rp ${x.text}");
                                    if (x.sId != null) {
                                      debugPrint("rp ${x.sId}");
                                      setState(() {
                                        widget.comments[commentsController.commentindex.value]
                                            ?.comments?[commentsController.replyindex.value].comments
                                            ?.add(x);
                                        commentsController.controller.clear();
                                      });
                                    } else {
                                      // setState(() {
                                      //   widget.comments[commentsController.commentindex.value]?.comments?[commentsController.replyindex.value].comments
                                      //       ?.add(Comment(text: commentsController.controller.text, userId: jwt.user?.value ?? UserSchema(sId: commentsController.userId), comments: [], sId: commentsController.userId));
                                      //   commentsController.controller.clear();
                                      // });
                                    }
                                  }
                                }
                              }
                            } else {
                              if (commentsController.isCommentingOnPost.value) {
                                String x = await commentsController.commentStory(widget.postId, widget.postuID!);
                                setState(() {
                                  widget.comments.add(Comment(
                                      text: commentsController.controller.text,
                                      userId: constuser ??
                                          UserSchema(
                                              sId: commentsController.userId,
                                              profilePic: constuser?.profilePic,
                                              username: constuser?.username),
                                      comments: [],
                                      sId: x));

                                  commentsController.controller.clear();
                                });
                              } else {
                                commentsController.isPosting.value
                                    ? debugPrint("sending comment")
                                    : commentsController.replyStory(widget.postId, commentsController.commentId.value,
                                        commentsController.controller.text, widget.postuID!);

                                setState(() {
                                  widget.comments[commentsController.commentindex.value]?.comments?.add(Comment(
                                      text: commentsController.controller.text,
                                      userId: constuser ??
                                          UserSchema(
                                              sId: commentsController.userId,
                                              profilePic: constuser?.profilePic,
                                              username: constuser?.username),
                                      comments: [],
                                      sId: commentsController.userId));
                                  commentsController.controller.clear();
                                });
                              }
                            }
                          },
                          icon: commentsController.isPosting.value
                              ? const Icon(
                                  Icons.more_horiz,
                                  color: Colors.blue,
                                )
                              : const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
