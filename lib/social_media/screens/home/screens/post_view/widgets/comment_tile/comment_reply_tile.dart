import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';

import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/comment_tile/replytoreply.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentReplyTile extends StatelessWidget {
  final Comment comment;
  final bool last;
  final int index;
  final int commentindex;
  final String? postuID;
  final String? commentuID;

  final String postId;
  CommentReplyTile(
      {super.key,
      required this.comment,
      required this.last,
      required this.index,
      required this.commentindex,
      this.postuID,
      required this.postId,
      this.commentuID});
  static time(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else {
      return '${difference.inDays} days ago';
    }
  }
  final storyController = Get.find<CommentController>();

  final commentController = Get.find<CommentController>();

  @override
  Widget build(BuildContext context) {
    int max = 1;

    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: StatefulBuilder(
        builder: (BuildContext context, setState) => IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: SizedBox(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 2,
                          color: Colors.white30,
                        ),
                        Container(
                          height: 2,
                          color: Colors.white30,
                        ),
                        (!last)
                            ? Expanded(
                                flex: 10,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width: 2,
                                  color: Colors.white30,
                                ),
                              )
                            : const Spacer(
                                flex: 10,
                              )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Stack(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(22),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20 * 2),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                margin: const EdgeInsets.symmetric(vertical: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(33),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundImage:
                                        CachedNetworkImageProvider(comment.userId!.profilePic ?? templateFiveImage[2]),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 12,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${comment.userId?.username}",
                                      style: const TextStyle(color: Colors.white60, fontSize: 10.2),
                                    ),
                                    Flexible(
                                      child: Text(
                                        comment.text ?? "",
                                        maxLines: max,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14.8,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          comment.timestamp == null ? "Now" : time(comment.timestamp!),
                                          style: const TextStyle(color: Color.fromARGB(160, 255, 255, 255), fontSize: 9.5),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (!comment.likes!.contains(globUserId)) {
                                              comment.likes!.add(globUserId);
                                              commentController.likeComment(postId, comment.sId!);
                                            }
                                          },
                                          child: globUserId == comment.userId?.sId || globUserId == commentuID
                                              ? const FormHeadingText(
                                                  headings: "Love Back", fontSize: 10.5, color: Colors.white60)
                                              : const FormHeadingText(headings: "Love", fontSize: 11.5, color: Colors.white60),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: GestureDetector(
                                              onTap: () {
                                                commentController.commentindex.value = commentindex;
                                                commentController.setReplyId(
                                                    comment.sId!, comment.userId?.username ?? "jjk", index);
                                              },
                                              child: const Text(
                                                "Reply",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white70,
                                                    letterSpacing: 0.32,
                                                    fontWeight: FontWeight.w500),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        if (comment.likes?.isNotEmpty ?? false) ...[
                                          Text(
                                            "${comment.likes?.length}+",
                                            style: const TextStyle(
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
                                            child: Image.asset("assets/png/liked_icon.png", color: purpleColor),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        ]
                                      ],
                                    ),
                                    IconButton(
                                      alignment: Alignment.bottomLeft,
                                      icon: Icon(
                                        max == 1 ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (max == 100) {
                                            max = 1;
                                          } else {
                                            max = 100;
                                          }
                                        });
                                      },
                                      color: Colors.white60,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    if (comment.comments != null) ...[
                      Column(
                        children: List.generate(comment.comments!.length, (index) {
                          if (comment.comments!.isNotEmpty) {
                            return ReplyreplyTile(
                              last: comment.comments!.length == index + 1,
                              comment: comment.comments![index],
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                      )
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
