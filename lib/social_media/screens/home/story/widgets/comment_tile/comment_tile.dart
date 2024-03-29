import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:get/get.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';

class StoryCommentTile extends StatefulWidget {
  final String text;
  final String userId;
  const StoryCommentTile({super.key, required this.text, required this.userId});

  @override
  State<StoryCommentTile> createState() => _StoryCommentTileState();
}

class _StoryCommentTileState extends State<StoryCommentTile> {
  var storyController = Get.put(GetXStoryController());
  String? userName;
  String? profileUrl;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  asyncInit() async {
   // var user = HiveDB.getUserDetail(widget.userId);
    // userName = user!.username!;
    // profileUrl = user.sId;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 75,
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(160, 160, 160, 0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            (profileUrl == null)
                ? const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(uselessUrl),
                  )
                : const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(uselessUrl),
                  ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FormHeadingText(
                  color: Colors.white,
                  headings: (userName == null)
                      ? "loading "
                      : (userName!.length > 20)
                          ? "${userName!.substring(17)}..."
                          : userName!,
                  fontSize: 10,
                ),
                FormHeadingText(
                  color: Colors.white,
                  headings: widget.text,
                  fontSize: 14,
                ),
                const Row(
                  children: [
                    FormHeadingText(
                      headings: "4+ Loves",
                      fontSize: 8,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FormHeadingText(
                      headings: "Reply..",
                      fontSize: 8,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FormHeadingText(
                      headings: "Love Back",
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            const FormHeadingText(
              color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
