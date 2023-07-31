import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/material.dart';
class CommentReplyTile extends StatelessWidget {
  final Comment comment;
  const CommentReplyTile({super.key,required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: 20),
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
            CircleAvatar(
              radius: 20,
              backgroundImage:
              NetworkImage(templateFiveImage[2]),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                FormHeadingText(
                  headings: "Jenny M",
                  fontSize: 5,
                ),
                FormHeadingText(
                  headings:
                  "${comment.text}",
                  fontSize: 6,
                ),
                FormHeadingText(
                  headings: "Now",
                  fontSize: 6,
                  color: const Color(0xff323232),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 10,
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
