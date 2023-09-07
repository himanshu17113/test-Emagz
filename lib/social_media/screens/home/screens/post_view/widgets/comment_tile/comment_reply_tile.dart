import 'dart:ui';

import 'package:emagz_vendor/constant/colors.dart';

import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/material.dart';

class CommentReplyTile extends StatelessWidget {
  final Comment comment;
  final bool last;
  CommentReplyTile({super.key, required this.comment, required this.last});

  int max = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
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
                          flex: 20,
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
                                flex: 20,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width: 2,
                                  color: Colors.white30,
                                ),
                              )
                            : const Spacer(
                                flex: 20,
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
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  NetworkImage(templateFiveImage[2]),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${comment.userId?.username}",
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 9),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    comment.text ?? "",
                                    maxLines: max,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white54, fontSize: 14),
                                  ),
                                ),
                              ),
                              Text(
                                "${comment.timestamp}",
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 9),
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
