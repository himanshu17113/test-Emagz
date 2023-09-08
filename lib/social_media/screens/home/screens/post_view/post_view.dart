import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/glass.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../../screens/auth/widgets/form_haeding_text.dart';
import '../../story/widgets/comment_tile/comment_tile.dart';

class PostView extends StatelessWidget {
  final Post post;
  final String myId;
  bool isLiked;
  PostView(
      {super.key,
      required this.post,
      required this.isLiked,
      required this.myId});

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
              imageUrl: post.mediaUrl!,
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
                StatefulBuilder(
                  builder: (context, setInnerState) => InkWell(
                    onTap: () {
                      if (isLiked) {
                        isLiked = !isLiked;
                        post.likes!.remove(myId);
                        setInnerState(() {});
                      } else {
                        isLiked = !isLiked;
                        post.likes!.add(myId);
                        setInnerState(() {});
                      }
                    },
                    child: isLiked
                        ? Image.asset(
                            "assets/png/liked_icon.png",
                            width: 22,
                          )
                        : Image.asset(
                            "assets/png/unlike_icon.png",
                            width: 22,
                          ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${post.likes?.length.toString()}",
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
                    if (post.comments != null) {
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
                              comments: post.comments!,
                              postId: post.sId!,
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
                  "${post.comments?.length.toString()}",
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
