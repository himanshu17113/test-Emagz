import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/comment/comment_view.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/post_view.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/bottomSheet/share_bottom_sheet.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/videoPlayer/CustomVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../chat/chat_screen.dart';

class PostCard extends StatefulWidget {
  Post? post;
  bool isBorder;
  bool? isLiked;
  String? myUserId;
  PostCard({
    Key? key,
    this.post,
    this.isLiked,
    this.myUserId,
    required this.url,
    this.isBorder = false,
  }) : super(key: key);

  final String url;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isShowPoll = false;
  List chooseOption = ["A. Yes", "B. No"];
  int selectedOption = -1;
  var homePostController = Get.put(HomePostsController());
  // var jwtController = Get.put(JWTController());
final  ConversationController chatController = Get.put(ConversationController());
  @override
  void initState() {
    super.initState();
    debugPrint("post : ${widget.post}");
  }

  @override
  Widget build(BuildContext context) {
    //todo change logic
    var yesCount = widget.post!.pollResults!.yes ?? 0;
    var noCount = widget.post!.pollResults!.no ?? 0;
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
      height: Get.size.height / 1.6,
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
          border: widget.isBorder == true ? Border.all(color: const Color(0xff46F2DB), width: 1.5, style: BorderStyle.solid) : null),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(fit: StackFit.expand, children: [
          Builder(builder: (context) {
            if (widget.post!.mediaType == "image" || widget.post!.mediaType == "text") {
              return GestureDetector(
                onTap: () {
                  Get.to(() => PostView(
                        post: widget.post!,
                        isLiked: widget.isLiked!,
                        myId: widget.myUserId!,
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: CachedNetworkImageProvider(widget.url), fit: BoxFit.cover),
                  ),
                ),
              );
            } else if (widget.post!.mediaType == "video") {
              // var videoUrl = "https://joy1.videvo.net/videvo_files/video/free/2019-09/large_watermarked/190828_07_MarinaBayatNightDrone_UHD_02_preview.mp4";
              return CustomVideoPlayer(
                post: widget.post!,
                // videoUrl: videoUrl,
                videoUrl: widget.post!.mediaUrl!,
                aspectRatio: (Get.size.height / 2.62) / (MediaQuery.of(context).size.width - 10),
              );
            } else {
              return Text("unknown type : ${widget.post!.mediaType}");
            }
          }),
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: widget.post!.mediaType == "video"
                          ? const CachedNetworkImageProvider("https://picsum.photos/500/500?random=851")
                          : CachedNetworkImageProvider(widget.url),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final conversationalId = await chatController.conversationId(widget.post!.user!.sId!);
                        debugPrint("🧣🧣$conversationalId🧣🧣🧣");
                        if (widget.post!.user != null) {
                 //         List<Message>? messages = [];
                   //       messages = await chatController.getMessages(conversationalId);
                          Get.off(() => ChatScreen(
                                user: widget.post!.user!,
                                conversationId: conversationalId,
                              //  messages: messages ?? [],
                              ));
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.post?.user!.username.toString()}",
                            // "${widget.post!.userId}",
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: whiteColor),
                          ),
                          Text("@${widget.post?.user!.getstatedName.toString()}",
                              style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: whiteColor)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
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
                                    homePostController.postPoll(widget.post!.sId!, (index == 0 ? "yes" : "no"));
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
                                      : Container()
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              (widget.post!.enabledpoll!)
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
                  : Container(),
              InkWell(
                onTap: () {
                  Get.to(() => CommentViewScreen(
                        post: widget.post!,
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
                  child: Row(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: Get.size.width / 2.5,
                      child: Text("${widget.post!.caption}", style: TextStyle(fontSize: 7, fontWeight: FontWeight.w400, color: whiteColor)),
                    ),
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                        onTap: () {
                          homePostController.likePost(widget.post!.sId!);
                          setState(() {
                            if (widget.isLiked == true) {
                              widget.post!.likes!.removeLast();
                              widget.isLiked = false;
                            } else {
                              widget.post!.likes!.add(widget.myUserId!);
                              widget.isLiked = true;
                            }
                          });
                        },
                        child: (widget.isLiked ?? false)
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
                      "${widget.post!.likes!.length}",
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
                      "${widget.post!.comments?.length}",
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: whiteColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape:
                              const OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return ShareBottomSheet(post: widget.post!);
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
                  ]),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
