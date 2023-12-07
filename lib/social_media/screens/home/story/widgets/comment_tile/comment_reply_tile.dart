import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';
class CommentReplyTile extends StatelessWidget {
  const CommentReplyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Column(
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
                "Yea they are really good   4+ Loves",
                fontSize: 6,
              ),
              FormHeadingText(
                headings: "Now",
                fontSize: 6,
                color: Color(0xff323232),
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
    );
  }
}
