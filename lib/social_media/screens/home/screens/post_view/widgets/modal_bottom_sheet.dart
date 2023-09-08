import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/comment_tile/comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constant/colors.dart';
import '../../../../../../screens/auth/widgets/form_haeding_text.dart';
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
                  "${widget.comments.length}",
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
              height: 5,
            ),

            ///  Container(width: double.maxFinite, height: 0.5, color: Colors.black),
            SizedBox(
                height: keyboardVisible
                    ? (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).viewInsets.bottom -
                        140)
                    : 270,
                //MediaQuery.of(context).size.height * .7,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
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

            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(160, 160, 160, 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 55,
              width: MediaQuery.of(context).size.width - 20,
              child: TextField(
                textAlign: TextAlign.left,
                cursorColor: grayColor,
                focusNode: commentsController.focusNode,
                controller: commentsController.controller,
                // controller: textEditingController,
                decoration: InputDecoration(
                  hintText: "Type your Comment",
                  hintStyle: const TextStyle(color: Colors.white54),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child:
                        //    Obx( () =>
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
                                      color: Colors.white,
                                    )),
                        ),
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
      ),
    );
  }
}
