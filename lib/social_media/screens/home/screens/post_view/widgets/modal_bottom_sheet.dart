// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/comment_tile/comment_tile.dart';

import '../../../../../../constant/colors.dart';
import '../../../../../../screens/auth/widgets/form_haeding_text.dart';
import 'glass.dart';

class PostCommentsModalBottomSheet extends StatefulWidget {
  VoidCallback? update;
  final String postId;
  bool? islike;
  int? likelength;
  final int? index;
  List<Comment?> comments;
  final bool isblurNeeded;
  final bool? isStory;
  PostCommentsModalBottomSheet({
    Key? key,
    this.update,
    required this.postId,
    this.islike,
    required this.likelength,
    this.index,
    required this.comments,
    this.isblurNeeded = false,
    this.isStory = false,
  }) : super(key: key);

  @override
  State<PostCommentsModalBottomSheet> createState() => _PostCommentsModalBottomSheetState();
}

class _PostCommentsModalBottomSheetState extends State<PostCommentsModalBottomSheet> {
  final commentsController = Get.put(CommentController());
  final homePostController = Get.find<HomePostsController>();

  //final getXStoryController = Get.find<GetXStoryController>();
  final jwt = Get.find<JWTController>();
  double mainHeight = 450;

  @override
  void dispose() {
    commentsController.setedCommentIdclear();
    debugPrint("👺👺👺👺👺commentsController.setedCommentIdclear();👺👺👺👺👺");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    // debugPrint(MediaQuery.of(context).viewInsets.bottom);
    // debugPrint(MediaQuery.of(context).size.height);

    return GlassmorphicContainer(
        // borderRadius: 33,
        // blur: 6,
        borderRadius: widget.isblurNeeded ? 33 : 0,
        blur: widget.isblurNeeded ? 6 : 0,
        //  width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .56,
        // keyboardVisible ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height * .7,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0))),
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
                      onTap: () {
                        // homePostController.likePost(widget.postId);
                        // setState(() {
                        //   if (widget.islike == true) {
                        //     // widget.post!.likes!.removeLast();
                        //     widget.likelength = widget.likelength! - 1;
                        //     homePostController.posts![widget.index!].likeCount = homePostController.posts![widget.index!].likeCount! - 1;
                        //     homePostController.posts![widget.index!].isLike = false;
                        //     widget.islike = false;
                        //   } else {
                        //     widget.likelength = widget.likelength! + 1;
                        //     // widget.post!.likes!.add(widget.myUserId!);
                        //     homePostController.posts![widget.index!].likeCount = homePostController.posts![widget.index!].likeCount! + 1;
                        //     homePostController.posts![widget.index!].isLike = true;
                        //     widget.islike = true;
                        //   }
                        // });
                      },
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
                    "${widget.comments.length}",
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
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
              ),
              SizedBox(
                  // height:
                  //     //  keyboardVisible
                  //     //     ? (MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom - 180)
                  //     //     : MediaQuery.of(context).size.height * .52,
                  //     MediaQuery.of(context).size.height * .7,
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                // child: ListView(
                //   physics: const ScrollPhysics(),
                //   children: [
                child: widget.comments.isNotEmpty
                    ? SizedBox(
                        // width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .35,
                        child: ListView.builder(
                          //   shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: widget.comments.length,
                          itemBuilder: (context, index) {
                            return PostCommentTile(
                              comment: widget.comments[index]!,
                              index: index,
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
              )),
              const Spacer(),
              Obx(() => commentsController.isCommentingOnPost.value
                  ? const SizedBox()
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 30,
                      //   width: context.width,
                      alignment: Alignment.bottomCenter,
                      color: Colors.white60,
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
                  // controller: textEditingController,
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: Colors.white12,
                    contentPadding: const EdgeInsets.only(left: 10),
                    hintText: "Type your Comment",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    // border: const OutlineInputBorder(
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(8),
                    //     ),
                    //     borderSide: BorderSide(color: Colors.white, width: 2)),
//suffixIconConstraints: BoxConstraints(),
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
                                //  commentsController.isPosting.value
                                //     ? debugPrint("sending comment")
                                //     :
                                var x = await commentsController.postComment(widget.postId);
                                setState(() {
                                  widget.comments.add(x);
                                  widget.update!();
                                  commentsController.controller.clear();
                                });
                              } else {
                                if (commentsController.isPosting.value) {
                                  debugPrint("sending comment");
                                } else {
                                  var x = await commentsController.postReply(
                                      widget.postId, commentsController.commentId.value, commentsController.controller.text);
                                  if (x != false) {
                                    setState(() {
                                      widget.comments[commentsController.commentindex.value]?.comments?.add(x
                                          // Comment(
                                          //   text: commentsController.controller.text,
                                          //   userId: UserSchema(
                                          //       //       username: ,
                                          //       sId: commentsController.userId),
                                          //   comments: [],
                                          //   sId: commentsController.userId)
                                          );
                                      commentsController.controller.clear();
                                    });
                                  }
                                }
                              }
                            } else {
                              if (commentsController.isCommentingOnPost.value) {
                                //  commentsController.isPosting.value
                                //     ? debugPrint("sending comment")
                                //     :
                                String x = await commentsController.commentStory(widget.postId);
                                setState(() {
                                  widget.comments.add(
                                      //x
                                      Comment(
                                          text: commentsController.controller.text,
                                          userId: jwt.user?.value ??
                                              UserSchema(
                                                  sId: commentsController.userId,
                                                  ProfilePic: jwt.user?.value.ProfilePic ?? jwt.profilePic?.value,
                                                  username: jwt.user?.value.username),
                                          comments: [],
                                          sId: x));
                                  commentsController.controller.clear();
                                });
                              } else {
                                commentsController.isPosting.value
                                    ? debugPrint("sending comment")
                                    : commentsController.replyStory(
                                        widget.postId, commentsController.commentId.value, commentsController.controller.text);

                                setState(() {
                                  widget.comments[commentsController.commentindex.value]?.comments?.add(Comment(
                                      text: commentsController.controller.text,
                                      userId: jwt.user?.value ??
                                          UserSchema(
                                              sId: commentsController.userId,
                                              ProfilePic: jwt.user?.value.ProfilePic ?? jwt.profilePic?.value,
                                              username: jwt.user?.value.username),
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
