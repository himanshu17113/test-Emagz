// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/modal_bottom_sheet.dart';

import '../../controller/home/home_controller.dart';

class CommentViewScreen extends StatefulWidget {
  Post post;
  bool isLiked;
  VoidCallback update;
  String? myUserId;
  CommentViewScreen({
    Key? key,
    required this.post,
    required this.isLiked,
    required this.update,
    this.myUserId,
  }) : super(key: key);

  @override
  State<CommentViewScreen> createState() => _CommentViewScreenState();
}

class _CommentViewScreenState extends State<CommentViewScreen> {
  //var jwtController = Get.put(JWTController());

  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  var homePostController = Get.find<HomePostsController>();
  var commentsController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final String url = widget.post.mediaUrl!;

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _changeOpacity();
            },
            child: Container(
              height: Get.size.height,
              decoration: BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(url), fit: BoxFit.cover),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _changeOpacity();
            },
            child: AnimatedOpacity(
              opacity: opacityLevel,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0))),
                  child: SizedBox(
                    width: Get.width,
                    child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(widget.post.caption ?? "bvcfb", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: whiteColor)),
                      ),
                      if (widget.post.comments != null) ...[
                        PostCommentsModalBottomSheet(
                          update: widget.update,
                          islike: widget.post.isLike,
                          likelength: widget.post.likeCount,
                          isblurNeeded: false,
                          comments: widget.post.comments!,
                          postId: widget.post.sId!,
                          postuID: widget.post.user?.sId,
                        )
                      ]
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;
  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 228,
            child: Text(
              comment.text ?? "",
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xffD2D2D2)),
            ),
          ),
          Text(
            comment.timestamp?.toString() ?? "5:30 PM",
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xffD2D2D2)),
          ),
        ],
      ),
    );
  }
}
