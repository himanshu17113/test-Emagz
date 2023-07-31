import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/comment_tile/comment_reply_tile.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:get/get.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';

class PostCommentTile extends StatefulWidget {
  final Comment comment;
  const PostCommentTile({super.key, required this.comment});

  @override
  State<PostCommentTile> createState() => _PostCommentTileState();
}

class _PostCommentTileState extends State<PostCommentTile> {
  var storyController = Get.put(GetXStoryController());
  String? userName;
  String? profileUrl;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  asyncInit() async {
   var user = await storyController.jwtController.getUserDetail(widget.comment.userId!.sId!);
    userName = user!.username!;
    profileUrl = user.sId;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            // height: 75,
            // margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xffDDE0FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                (profileUrl == null)
                    ? CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(templateFiveImage[0]),
                      )
                    : CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(templateFiveImage[0]),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FormHeadingText(
                      headings: (userName == null)
                          ? "loading "
                          : (userName!.length > 20)
                              ? "${userName!.substring(17)}..."
                              : userName!,
                      fontSize: 10,
                    ),
                    Container(
                      width: context.width / 1.7,
                      child: Text(
                        "${widget.comment.text}",
                        style: const TextStyle(fontSize: 14),
                      ),
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
                        const SizedBox(
                          width: 10,
                        ),
                        FormHeadingText(
                          headings: "Reply",
                          fontSize: 8,
                          color: const Color(0xff323232),
                        ),
                        const SizedBox(
                          width: 10,
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
                  child: Image.asset("assets/png/liked_icon.png", color: purpleColor),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
        Column(
          children: List.generate(widget.comment.comments!.length, (index) {
            if (widget.comment.comments!.isNotEmpty) {
              return CommentReplyTile(
                comment: widget.comment.comments![index]!,
              );
            } else {
              return SizedBox();
            }
          }),
        )

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
