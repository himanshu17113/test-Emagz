import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/comment_tile/comment_reply_tile.dart';
import 'package:get/get.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';

import '../../../../../comment/commentController.dart';
import '../glass.dart';

class PostCommentTile extends StatelessWidget {
  final Comment comment;
  final int index;
  final String postId;
  const PostCommentTile(
      {super.key,
      required this.comment,
      required this.index,
      required this.postId});

  // final CommentController storyController = Get.find<CommentController>();

  // @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 5, top: 15, bottom: 5),
          child: GlassmorphicContainer(
            colour: Colors.white30,
            // const Color(0xffDDE0FF),
            height: 65,
            blur: 2,
            //  width: MediaQuery.of(context).size.width,
            borderRadius: 20,
            // margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 4),
            // decoration: BoxDecoration(

            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Row(
              children: [
                (comment.userId?.profilePic == null)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              CachedNetworkImageProvider(templateFiveImage[0]),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: CachedNetworkImageProvider(
                              comment.userId!.profilePic!),
                        ),
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (comment.userId?.username == null)
                          ? "loading "
                          : (comment.userId!.username!.length > 20)
                              ? "${comment.userId?.username?.substring(17)}..."
                              : comment.userId!.username!,
                      style: const TextStyle(
                          fontSize: 11.5,
                          color: Colors.white70,
                          letterSpacing: 0.32,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${comment.text}",
                      style: const TextStyle(
                          fontSize: 16.2,
                          color: Colors.white,
                          letterSpacing: 0.32),
                    ),
                    GetBuilder<CommentController>(
                      init: CommentController(),
                      id: "commentlike",
                      builder: (commentController) {
                        return Row(
                          children: [
                            Text(
                              "${comment.likes?.length} Loves",
                              style: const TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.white70,
                                  letterSpacing: 0.32,
                                  fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                  onTap: () {
                                    commentController.setCommentId(
                                        comment.sId!,
                                        comment.userId?.username ?? "jjk",
                                        index);
                                  },
                                  child: const Text(
                                    "Reply",
                                    style: TextStyle(
                                        fontSize: 11.5,
                                        color: Colors.white70,
                                        letterSpacing: 0.32,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            // if (globUserId == comment.userId?.sId) ...[
                            //   const FormHeadingText(
                            //       headings: "Love Back",
                            //       fontSize: 11.5,
                            //       color: Colors.white60)
                            // ],
                            globUserId == comment.userId?.sId
                                ? const FormHeadingText(
                                    headings: "Love Back",
                                    fontSize: 11.5,
                                    color: Colors.white60)
                                : GestureDetector(
                                    onTap: () {
                                      if (!comment.likes!
                                          .contains(globUserId)) {
                                        comment.likes!.add(globUserId);
                                        commentController.likeComment(
                                            postId, comment.sId!);
                                      }
                                    },
                                    child: const FormHeadingText(
                                        headings: "Love",
                                        fontSize: 11.5,
                                        color: Colors.white60),
                                  )
                          ],
                        );
                      },
                    )
                  ],
                ),
                const Spacer(),
                const Text(
                  "3+",
                  style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.white70,
                      letterSpacing: 0.32,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: toggleInactive),
                    ],
                  ),
                  child: Image.asset("assets/png/liked_icon.png",
                      color: purpleColor),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
        if (comment.comments != null) ...[
          Column(
            children: List.generate(comment.comments!.length, (inde) {
              if (comment.comments!.isNotEmpty) {
                return CommentReplyTile(
                  last: comment.comments!.length == inde + 1,
                  comment: comment.comments![inde],
                  index: inde,
                  commentindex: index,
                );
              } else {
                return const SizedBox();
              }
            }),
          )
        ]
      ],
    );
  }
}
