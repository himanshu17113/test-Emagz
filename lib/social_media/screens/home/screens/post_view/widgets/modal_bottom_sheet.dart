import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/comment_tile/comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'glass.dart';

class PostCommentsModalBottomSheet extends StatefulWidget {
  final String postId;
  List<Comment?> comments;
  final bool isblurNeeded;
  PostCommentsModalBottomSheet(
      {super.key,
      required this.comments,
      required this.postId,
      this.isblurNeeded = true});

  @override
  State<PostCommentsModalBottomSheet> createState() =>
      _PostCommentsModalBottomSheetState();
}

class _PostCommentsModalBottomSheetState
    extends State<PostCommentsModalBottomSheet> {
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
    bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    // debugPrint(MediaQuery.of(context).viewInsets.bottom);
    // debugPrint(MediaQuery.of(context).size.height);

    return GlassmorphicContainer(
      // borderRadius: 33,
      // blur: 6,
      borderRadius: widget.isblurNeeded ? 33 : 0,
      blur: widget.isblurNeeded ? 6 : 0,
      //  width: MediaQuery.of(context).size.width,
      height: keyboardVisible ? MediaQuery.of(context).size.height : 450,
      child: Column(
        children: [
          const Text(
            "Comments",
            textAlign: TextAlign.center,
            style: TextStyle(height: 2, fontSize: 18, color: Colors.black),
          ),

          ///  Container(width: double.maxFinite, height: 0.5, color: Colors.black),
          SizedBox(
              height: keyboardVisible
                  ? (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).viewInsets.bottom -
                      120)
                  : 320,
              //MediaQuery.of(context).size.height * .7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                // child: ListView(
                //   physics: const ScrollPhysics(),
                //   children: [
                child: widget.comments.isNotEmpty
                    ? ListView.builder(
                        //   shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: widget.comments.length,
                        itemBuilder: (context, index) {
                          return PostCommentTile(
                            comment: widget.comments[index]!,
                            index: index,
                          );
                        },
                      )
                    : const SizedBox(),
              )),
          // Obx(
          //   () => ListView.builder(
          //     shrinkWrap: true,
          //     physics: const ScrollPhysics(),
          //     itemCount:
          //         commentsController.instantComments.value.length,
          //     itemBuilder: (context, index) {
          //       //  debugPrint(commentsController.instantComments.value[index]);
          //       return PostCommentTile(
          //         comment:
          //             commentsController.instantComments.value[index],
          //       );
          //     },
          //   ),
          // ),

          //   ],
          // ),
          Obx(() => commentsController.isCommentingOnPost.value
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 30,
                  //   width: context.width,
                  alignment: Alignment.center,
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
                                commentsController.isCommentingOnPost.value =
                                    true;
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

          SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width - 20,
            child: TextField(
              focusNode: commentsController.focusNode,
              controller: commentsController.controller,
              // controller: textEditingController,
              decoration: InputDecoration(
                hintText: "write comment",
                hintStyle: const TextStyle(color: Colors.white54),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child:
                      //    Obx( () =>
                      IconButton(
                          onPressed: () async {
                            if (commentsController.isCommentingOnPost.value) {
                              //  commentsController.isPosting.value
                              //     ? debugPrint("sending comment")
                              //     :
                              String x = await commentsController
                                  .postComment(widget.postId);
                              setState(() {
                                widget.comments.add(Comment(
                                    text: commentsController.controller.text,
                                    userId: UserSchema(
                                        sId: commentsController.userId),
                                    comments: [],
                                    sId: x));
                                commentsController.controller.clear();
                              });
                            } else {
                              commentsController.isPosting.value
                                  ? debugPrint("sending comment")
                                  : commentsController.postReply(
                                      widget.postId,
                                      commentsController.commentId.value,
                                      commentsController.controller.text);

                              setState(() {
                                widget
                                    .comments[
                                        commentsController.commentindex.value]
                                    ?.comments
                                    ?.add(Comment(
                                        text:
                                            commentsController.controller.text,
                                        userId: UserSchema(
                                            //       username: ,
                                            sId: commentsController.userId),
                                        comments: [],
                                        sId: commentsController.userId));
                                commentsController.controller.clear();
                              });
                            }
                          },
                          icon: commentsController.isPosting.value
                              ? const Icon(
                                  Icons.more_horiz,
                                  color: Colors.blue,
                                )
                              : const Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                )),
                  //   ),
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    borderSide: BorderSide(color: Colors.white, width: 2)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
