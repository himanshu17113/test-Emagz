import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  final Post post;
  final String myId;
  bool isLiked;
  PostView(
      {super.key,
      required this.post,
      required this.isLiked,
      required this.myId});

  @override
  State<PostView> createState() => _PostViewState();
}


class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // backgroundColor: socialBack,
      body: Stack(alignment: Alignment.center, fit: StackFit.loose, children: [
        InteractiveViewer(
          minScale: 0.75,
          maxScale: 4,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: CachedNetworkImage(
              imageUrl: widget.post.mediaUrl!,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        Positioned(
            top: 40,
            left: 0,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:
                    const Icon(color: Colors.white, Icons.arrow_back_rounded))),
        Positioned(
          bottom: 30,
          child: Material(
            type: MaterialType.transparency,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (widget.isLiked) {
                      widget.isLiked = !widget.isLiked;
                      widget.post.likes!.remove(widget.myId);
                      setState(() {});
                    } else {
                      widget.isLiked = !widget.isLiked;
                      widget.post.likes!.add(widget.myId);
                      setState(() {});
                    }
                  },
                  child: widget.isLiked
                      ? Image.asset(
                          "assets/png/liked_icon.png",
                          width: 22,
                        )
                      : Image.asset(
                          "assets/png/unlike_icon.png",
                          width: 22,
                        ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${widget.post.likes?.length.toString()}",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: whiteColor),
                ),
                const SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () {
                    if (widget.post.comments != null) {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        // enableDrag: true,
                        enableDrag: true,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        context: context,
                        builder: (context) {
                          return Wrap(children: [
                            PostCommentsModalBottomSheet(
                              comments: widget.post.comments!,
                              postId: widget.post.sId!,
                            )
                          ]);
                        },
                      );
                    }
                  },
                  child: Image.asset(
                    "assets/png/comment_icon.png",
                    width: 22,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${widget.post.comments?.length.toString()}",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: whiteColor),
                ),
                const SizedBox(
                  width: 30,
                ),
                Image.asset(
                  "assets/png/share_icon.png",
                  width: 26,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
