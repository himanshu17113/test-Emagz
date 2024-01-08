import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class PostView extends StatelessWidget {
  VoidCallback update;
  final int index;
  final String myId;
  bool isLiked;
  PostView(
      {super.key,
      required this.update,
      // required this.post,
      required this.isLiked,
      required this.myId,
      required this.index});

  final homePostController =
      Get.find<HomePostsController>(tag: 'HomePostsController');

  @override
  Widget build(BuildContext context) {
    final Post post = homePostController.posts![index];
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      // backgroundColor: socialBack,
      body: Stack(alignment: Alignment.center, fit: StackFit.loose, children: [
        PageView.builder(
          itemCount: homePostController.posts![index].mediaUrl!.length,
          itemBuilder: (context, index) => InteractiveViewer(
            child: Center(
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                //  fit: BoxFit.fill,
                imageUrl: post.mediaUrl![index]!,
                filterQuality: FilterQuality.high,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 180.0, vertical: 200),
                    child: CircularProgressIndicator(
                      //    value: downloadProgress.progress,
                      backgroundColor: Colors.amberAccent,
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ),

                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
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
            child: StatefulBuilder(
              builder: (context, setInnerState) => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (post.isLike!) {
                        homePostController.posts![index].isLike = false;
                        homePostController.posts![index].likeCount =
                            homePostController.posts![index].likeCount! - 1;

                        //    post.likes!.remove(myId);
                        setInnerState(() {});
                        homePostController.likePost(
                            post.sId!, index, false, post.user?.sId ?? "");
                      } else {
                        homePostController.posts![index].isLike = true;
                        homePostController.posts![index].likeCount =
                            homePostController.posts![index].likeCount! + 1;

                        //    post.likes!.add(myId);
                        setInnerState(() {});
                        homePostController.likePost(
                            post.sId!, index, true, post.user?.sId ?? "");
                      }
                      update();
                    },
                    child: homePostController.posts![index].isLike!
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
                    "${post.likeCount}",
                    style: const TextStyle(
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
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: PostCommentsModalBottomSheet(
                                update: update,
                                index: index,
                                islike: post.isLike,
                                likelength: post.likeCount,
                                comments: post.comments!,
                                postId: post.sId!,
                                postuID: post.user?.sId,
                              ),
                            );
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
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: whiteColor),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Share.share("http://emagz.live/Post/${post.sId}"),
                    child: Image.asset(
                      "assets/png/share_icon.png",
                      width: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
