// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/comment/comment_view.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/post_view.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/bottomSheet/share_bottom_sheet.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/videoPlayer/CustomVideoPlayer.dart';
import 'package:emagz_vendor/templates/choose_template/webview.dart';

import '../../../controller/auth/jwtcontroller.dart';

class PostCard extends StatefulWidget {
  // Post? post;

  bool isBorder;
  bool? isLiked;
  String? myUserId;
  String? userImg;
  final int? index;
  PostCard({
    Key? key,
    // this.post,

    this.isBorder = true,
    this.isLiked,
    this.myUserId,
    this.userImg,
    this.index,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isShowPoll = false;
  List chooseOption = ["A. Yes", "B. No"];
  int selectedOption = -1;
  final homePostController = Get.put(HomePostsController());
  final jwtController = Get.put(JWTController());
  final ConversationController chatController = Get.put(ConversationController());
  Post? post;
  @override
  void initState() {
    super.initState();
    post = homePostController.posts?[widget.index!];
  }

  _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //todo change logic
    var yesCount = 0;
    var noCount = 0;
    // var yesCount = post?.pollResults?[0]?.yes ?? 0;
    // var noCount = post?.pollResults?[0]?.no ?? 0;
    late double yesPercentage;
    late double noPercentage;
    if (yesCount + noCount != 0) {
      yesPercentage = (yesCount / (yesCount + noCount)) * 100;
      noPercentage = 100 - yesPercentage;
    } else {
      yesPercentage = 0;
      noPercentage = 0;
    }
    return Container(
      //    height: Get.size.height / 1.6,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.black,
          // shape: BoxShape.circle,
          // image: ,
          // image: DecorationImage(
          //     image: NetworkImage(
          //         "https://picsum.photos/500/500?random=856"),
          //     fit: BoxFit.cover
          // ),
          borderRadius: BorderRadius.circular(20),
          border: widget.isBorder == true ? Border.all(color: const Color(0xff46F2DB), width: 2.2, style: BorderStyle.solid) : null),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(fit: StackFit.loose, children: [
          Builder(builder: (context) {
            if (post!.mediaType == "image" || post!.mediaType == "text") {
              return GestureDetector(
                onTap: () {
                  Get.to(() => PostView(
                        update: _update,
                        index: widget.index!,
                        // post: post!,
                        isLiked: widget.isLiked!,
                        myId: widget.myUserId!,
                      ));
                },
                child: CachedNetworkImage(
                  width: Get.size.width,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.center,
                  // height: 55,
                  imageUrl: widget.url,
                  placeholder: (context, url) => const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 180.0, vertical: 250),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.amberAccent,
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            } else if (post!.mediaType == "video") {
              // var videoUrl = "https://joy1.videvo.net/videvo_files/video/free/2019-09/large_watermarked/190828_07_MarinaBayatNightDrone_UHD_02_preview.mp4";
              return CustomVideoPlayer(
                post: post!,
                // videoUrl: videoUrl,
                videoUrl: post!.mediaUrl!,
                aspectRatio: (Get.size.height / 2.62) / (MediaQuery.of(context).size.width - 10),
              );
            } else {
              return Text("unknown type : ${post!.mediaType}");
            }
          }),

          Positioned(
            top: 15,
            left: 15,
            child: Container(
              height: 55,
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: post!.mediaType == "video"
                        ? const CachedNetworkImageProvider("https://picsum.photos/500/500?random=851")
                        : CachedNetworkImageProvider(widget.userImg!),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // final conversationalId = await chatController
                      //     .conversationId(post!.user!.sId!);
                      // debugPrint("🧣🧣$conversationalId🧣🧣🧣");
                      // if (post!.user != null) {
                      //   //         List<Message>? messages = [];
                      //   //       messages = await chatController.getMessages(conversationalId);
                      //   Get.off(() => ChatScreen(
                      //         user: post!.user!,
                      //         conversationId: conversationalId,
                      //         //  messages: messages ?? [],
                      //       ));
                      // }
                      var tok = await jwtController.getAuthToken();
                      //var userIdd= await jwtController.getUserId();
                      print(tok);

                      print(post!.sId!);
                      String temp = post!.user!.personalTemplate!;
                      if (temp == null) {
                        Get.snackbar('No persona Choosen by this user', 'Hi No persona here');
                      } else {
                        if (temp[0] == 'T') {
                          Get.snackbar('This is a Old account ', 'Persona wont work properly');
                          temp = '64e8f2c3b9b30c1ed4b28bb6';
                        }
                        Get.to(() => WebViewPersona(token: tok!, userId: widget.myUserId!, personaUserId: post!.user!.sId!, templateId: temp));
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${post?.user!.username.toString()}",
                          // "${post!.userId}",
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: whiteColor),
                        ),
                        Text("@${post?.user!.getstatedName.toString()}",
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: whiteColor)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          //const Spacer(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                isShowPoll
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FormHeadingText(
                            headings: "Choose\nyour poll",
                            color: whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              chooseOption.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () {
                                    if (index == selectedOption) {
                                      selectedOption = -1;
                                      setState(() {});
                                      return;
                                    }
                                    setState(() {
                                      selectedOption = index;
                                      homePostController.postPoll(post!.sId!, (index == 0 ? "yes" : "no"));
                                    });
                                  },
                                  child: Stack(alignment: Alignment.centerLeft, children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 52,
                                      width: 100,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: selectedOption == index ? whiteColor : null,
                                        border: Border.all(color: whiteColor),
                                      ),
                                      child: FormHeadingText(
                                        headings: chooseOption[index],
                                        color: selectedOption != index ? whiteColor : Colors.black,
                                      ),
                                    ),
                                    (selectedOption != -1)
                                        ? ((index == 0)
                                            ? Container(
                                                alignment: Alignment.bottomCenter,
                                                child: Container(
                                                  alignment: Alignment.bottomCenter,
                                                  height: 52,
                                                  width: yesPercentage,
                                                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                                                  child: Text("$yesCount", style: const TextStyle(color: Colors.white)),
                                                ),
                                              )
                                            : Container(
                                                alignment: Alignment.bottomCenter,
                                                child: Container(
                                                  alignment: Alignment.bottomCenter,
                                                  height: 52,
                                                  width: noPercentage,
                                                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                                                  child: Text("$noCount", style: const TextStyle(color: Colors.white)),
                                                ),
                                              ))
                                        : const SizedBox()
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                (post!.enabledpoll!)
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isShowPoll = !isShowPoll;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15, bottom: 15),
                            child: Image.asset(
                              "assets/png/poll_icon.png",
                              width: 25,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                InkWell(
                  onTap: () {
                    Get.to(() => CommentViewScreen(
                          post: post!,
                          isLiked: widget.isLiked ?? false,
                          myUserId: widget.myUserId,
                        ));
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFffffff).withOpacity(.15),
                      ),
                      gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                        const Color(0xFFffffff).withOpacity(0.20),
                        const Color(0xFFFFFFFF).withOpacity(0.25),
                      ], stops: const [
                        2,
                        0.1,
                      ]),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child:  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: Get.size.width / 2.5,
                            child: Text("${post!.caption}", style: TextStyle(fontSize: 7, fontWeight: FontWeight.w400, color: whiteColor)),
                          ),
                          //    const Expanded(child: SizedBox()),
                          GestureDetector(
                              onTap: () {
                                homePostController.likePost(post!.sId!);
                                setState(() {
                                  if (homePostController.posts![widget.index!].isLike!) {
                                    homePostController.posts![widget.index!].likeCount = homePostController.posts![widget.index!]!.likeCount! - 1;
                                    //      post!.likes!.removeLast();
                                    homePostController.posts![widget.index!]!.isLike = false;
                                  } else {
                                    homePostController.posts![widget.index!]!.likeCount = homePostController.posts![widget.index!]!.likeCount! + 1;
                                    //  post!.likes!.add(widget.myUserId!);
                                    homePostController.posts![widget.index!]!.isLike = true;
                                  }
                                });
                              },
                              child: (post!.isLike ?? false)
                                  ? Image.asset(
                                      "assets/png/liked_icon.png",
                                      width: 26,
                                    )
                                  : Image.asset(
                                      "assets/png/unlike_icon.png",
                                      width: 22,
                                    )),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${homePostController.posts?[widget.index!].likeCount}",
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: whiteColor),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            "assets/png/comment_icon.png",
                            width: 22,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${post!.comments?.length}",
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: whiteColor),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                shape: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return ShareBottomSheet(post: post!);
                                },
                              );
                            },
                            child: Image.asset(
                              "assets/png/share_icon.png",
                              width: 26,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ])),
                 
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
