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
  PostCommentTile({super.key, required this.comment, required this.index});

  //var storyController = Get.put(GetXStoryController());
  final storyController = Get.put(CommentController());

  // @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 5),
          child: GlassmorphicContainer(
            colour: Colors.white30,
            // const Color(0xffDDE0FF),
            height: 75,
            blur: 2,
            //     width: MediaQuery.of(context).size.width,
            borderRadius: 20,
            // margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 4),
            // decoration: BoxDecoration(

            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Row(
              children: [
                (comment.userId?.ProfilePic == null)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(templateFiveImage[0]),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(templateFiveImage[0]),
                        ),
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FormHeadingText(
                      headings: (comment.userId?.displayName == null)
                          ? "loading "
                          : (comment.userId!.displayName!.length > 20)
                              ? "${comment.userId?.displayName?.substring(17)}..."
                              : comment.userId!.displayName!,
                      fontSize: 10,
                    ),
                    Text(
                      "${comment.text}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    // FormHeadingText(
                    //   headings: ,
                    //
                    //   fontSize: 14,
                    // ),
                    Row(
                      children: [
                        FormHeadingText(
                          headings: "4+ Loves",
                          fontSize: 8,
                          color: const Color(0xff323232),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              storyController.setCommentId(comment.sId!,
                                  comment.userId?.username ?? "jjk", index);
                            },
                            child: FormHeadingText(
                              headings: "Reply",
                              fontSize: 10,
                              color: const Color(0xff323232),
                            ),
                          ),
                        ),
                        FormHeadingText(
                          headings: "Love Back",
                          fontSize: 8,
                          color: const Color(0xff323232),
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                FormHeadingText(
                  headings: "3+",
                  fontSize: 12,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
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
            children: List.generate(comment.comments!.length, (index) {
              if (comment.comments!.isNotEmpty) {
                return CommentReplyTile(
                  last: comment.comments!.length == index + 1,
                  comment: comment.comments![index],
                );
              } else {
                return const SizedBox();
              }
            }),
          )
        ]

        // ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: widget.comment.comments!.length,
        //   itemBuilder: (context, index) {
        //   return CommentReplyTile();
        // },)
      ],
    );
  }
}
