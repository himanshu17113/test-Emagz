import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';

import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/comment_tile/replytoreply.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentReplyTile extends StatelessWidget {
  final storyController = Get.find<CommentController>();
  final Comment comment;
  final bool last;
  final int index;
  final int commentindex;
  CommentReplyTile({super.key, required this.comment, required this.last, required this.index, required this.commentindex});
  time(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

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
      // final format = DateFormat('yyyy-MM-dd HH:mm');
      // return format.format(dateTime);
    }
  }

  int max = 1;

  @override
  Widget build(BuildContext context) {
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
                        // Expanded(
                        //    flex: 10,
                        //  child:
                        Container(
                          height: 40,
                          width: 2,
                          color: Colors.white30,
                        ),
                        //    ),
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
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundImage: CachedNetworkImageProvider(comment.userId!.ProfilePic ?? templateFiveImage[2]),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${comment.userId?.username}",
                                      style: const TextStyle(color: Colors.white60, fontSize: 10.2),
                                    ),
                                    // Row(
                                    //   children: [
                                    Flexible(
                                      // child: Padding(
                                      //   padding: const EdgeInsets.only(right: 0),
                                      child: Text(
                                        comment.text ?? "",
                                        maxLines: max,
                                        //     softWrap: true,
                                        //overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14.8,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    //     ),
                                    //   const Spacer(),
                                    //   ],
                                    // ),
                                    Row(
                                      children: [
                                        Text(
                                          comment.timestamp == null ? "Now" : time(comment.timestamp!),
                                          //  "${comment.timestamp}",
                                          style: const TextStyle(color: Color.fromARGB(160, 255, 255, 255), fontSize: 9),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: GestureDetector(
                                              onTap: () {
                                                storyController.commentindex.value = commentindex;
                                                storyController.setReplyId(comment.sId!, comment.userId?.username ?? "jjk", index);
                                              },
                                              child: const Text(
                                                "Reply",
                                                style: TextStyle(fontSize: 11.5, color: Colors.white70, letterSpacing: 0.32, fontWeight: FontWeight.w500),
                                              )),
                                        ),
                                      ],
                                    ),
                                    // Expanded(
                                    //   child:
                                    //  ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  alignment: Alignment.topLeft,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
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
                            return ReplyReplyTile(
                              last: comment.comments!.length == index + 1,
                              comment: comment.comments![index],
                              //  index: index,
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
