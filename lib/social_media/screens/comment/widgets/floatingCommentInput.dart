import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingCommentInput extends StatelessWidget {
  final String postId;
  final Function(String text) onTapExtra;
  const FloatingCommentInput({Key? key, required this.postId, required this.onTapExtra}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var commentController = Get.put(CommentController());
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.only(bottom: 20),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
          const Color(0xFFffffff).withOpacity(0.30),
          const Color(0xFFFFFFFF).withOpacity(0.25),
        ], stops: const [
          2,
          0.1,
        ]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        // expands: true,
        showCursor: false,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        controller: commentController.controller,
        cursorColor: whiteColor,
        style: const TextStyle(color: Colors.white),
        scrollPadding: EdgeInsets.zero,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: "Add Your Comment",
            hintStyle: TextStyle(color: whiteColor, fontSize: 12),
            isDense: false,

            // filled: true,/
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 10),
            suffixIcon: InkWell(
              onTap: () {
                commentController.postComment(postId);
                onTapExtra(commentController.controller.text);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Obx(() => commentController.isPosting.value
                    ? const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 24,
                      )
                    : const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 24,
                      )),
              ),
            )),
      ),
    );
  }
}
