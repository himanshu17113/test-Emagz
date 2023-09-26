import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';

import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReplyReplyTile extends StatelessWidget {
  final storyController = Get.find<CommentController>();
  final Comment comment;
  final bool last;
  ReplyReplyTile({super.key, required this.comment, required this.last});
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
                        Expanded(
                          flex: 10,
                          child: Container(
                            width: 2,
                            color: Colors.white30,
                          ),
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
                child: Padding(
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
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            margin: const EdgeInsets.symmetric(vertical: 10),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: CachedNetworkImageProvider(comment.userId!.ProfilePic ?? templateFiveImage[2]),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${comment.userId?.username}",
                                style: const TextStyle(color: Colors.white60, fontSize: 10.2),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: SizedBox(
                                  width: 130,
                                  child: Text(
                                    comment.text ?? "",
                                    maxLines: max,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white70, fontSize: 14.8),
                                  ),
                                ),
                              ),
                              Text(
                                comment.timestamp == null ? "Now" : time(comment.timestamp!),
                                //  "${comment.timestamp}",
                                style: const TextStyle(color: Colors.white60, fontSize: 9),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (max == 10) {
                                  max = 1;
                                } else {
                                  max = 10;
                                }
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                                color: Colors.white60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
