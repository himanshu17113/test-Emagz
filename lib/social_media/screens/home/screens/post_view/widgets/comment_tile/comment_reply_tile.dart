import 'dart:ui';

import 'package:emagz_vendor/constant/colors.dart';

import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/material.dart';

class CommentReplyTile extends StatefulWidget {
  final Comment comment;
  final bool last;
  const CommentReplyTile({super.key, required this.comment, required this.last});

  @override
  State<CommentReplyTile> createState() => _CommentReplyTileState();
}

class _CommentReplyTileState extends State<CommentReplyTile> {
  // final GlobalKey _key = GlobalKey();
  // double width = 0;
  // double height = 0;
  @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       RenderBox renderbox = _key.currentContext!.findRenderObject()  as;
//       if (renderbox != null) {
//   width = renderbox..width;

//   height = renderbox!.size!.height;
// }
//       print(height);
//     });
//     super.initState();
//   }

  int max = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: SizedBox(
                  // width: context.width * .1,
                  height: 80,
                  //  height: height == 0 ? 80 : height + 80,
                  child: Column(
                    //  mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 20,
                        child: Container(
                          //    alignment: Alignment.topLeft,
                          // height: height == 0 ? 48 : height + 48,
                          // 38,
                          width: 2,
                          //constraints: const BoxConstraints.expand(),
                          color: Colors.white30,
                        ),
                      ),
                      Container(
                        //    alignment: Alignment.topLeft,
                        //     width: 20,
                        height: 2,
                        color: Colors.white30,
                      ),
                      (!widget.last)
                          ? Expanded(
                              flex: 20,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                //    alignment: Alignment.topLeft,
                                width: 2,
                                //  height: 20,
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
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius:
                        //  BorderRadius.only(
                        //     topLeft: Radius.circular(borderRadius),
                        //     topRight: Radius.circular(borderRadius)),
                        BorderRadius.circular(22),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20 * 2),
                      child: Container(
                        // padding: EdgeInsets.symmetric(vertical: 20),
                        // margin: EdgeInsets.symmetric(vertical: 20),
                        // alignment: alignment ?? Alignment.topLeft,
                        decoration: BoxDecoration(
                          // color: Colors.white30,
                          borderRadius:
                              // BorderRadius.only(
                              //     topLeft: Radius.circular(borderRadius),
                              //     topRight: Radius.circular(borderRadius)),
                              BorderRadius.circular(33),
                          // gradient: linearGradient,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  //        height: 55,
                  // width: context.width * .8,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  // margin: const EdgeInsets.symmetric(horizontal: 5),
                  // padding: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    //    color: const Color(0xffDDE0FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(templateFiveImage[2]),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.comment.userId?.username}",
                            style: const TextStyle(color: Colors.white54, fontSize: 9),
                          ),
                          // SizedBox(
                          //   // height: 20,
                          //   width: 200,
                          //   child: ReadMoreText(
                          //     "${comment.text}",
                          //     trimLines: 1,
                          //     trimLength: 20,
                          //     textDirection: TextDirection.ltr,

                          //     /// trimLength: 20,
                          //     colorClickableText: Colors.white,
                          //     trimMode: TrimMode.Length,
                          //     trimCollapsedText: '.',
                          //     trimExpandedText: '^',
                          //     moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                widget.comment.text ?? "",
                                // key: _key,
                                maxLines: max,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white54, fontSize: 14),
                              ),
                            ),
                          ),
                          Text(
                            "${widget.comment.timestamp}",
                            style: const TextStyle(color: Colors.white54, fontSize: 9),
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
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
