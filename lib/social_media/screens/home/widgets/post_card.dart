// ignore_for_file: constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/model/poll_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/comment_view.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/post_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/videoPlayer/CustomVideoPlayer.dart';
import 'package:emagz_vendor/templates/choose_template/webview.dart';

class PostCard extends StatefulWidget {
  // Post? post;

  final bool isBorder;
  final bool? isLiked;
  final String? myUserId;
  final String? userImg;
  final int? index;
  const PostCard({
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

enum reportcharacter { Spam, Misinformation, Harmful, Misleading, Hateful }

class _PostCardState extends State<PostCard> {
  Map<String, String>? map;
  reportcharacter? _character = reportcharacter.Spam;
  bool isShowPoll = false;
  bool isvoted = false;
  Poll? poll;
  List chooseOption = ["A. Yes", "B. No"];
  int selectedOption = -1;
  final homePostController =
      Get.find<HomePostsController>(tag: 'HomePostsController');
  Post? post;
  @override
  void initState() {
    super.initState();
    post = homePostController.posts?[widget.index!];
  }

  _update() {
    setState(() {});
  }

//   ch(){
//  final PollResults? pollResult  =      post!.pollResults.firstWhere((element) => element.id == globUserId)
// }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          border: widget.isBorder == true
              ? Border.all(
                  color: const Color(0xff46F2DB),
                  width: 2.2,
                  style: BorderStyle.solid)
              : null),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(fit: StackFit.loose, children: [
          if (post!.mediaType == "image" || post!.mediaType == "text") ...[
            GestureDetector(
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
                width: width,
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                imageUrl: widget.url,
                placeholder: (context, url) => const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.amberAccent,
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )
          ],
          if (post!.mediaType == "video") ...[
            CustomVideoPlayer(
              post: post!,
              // videoUrl: videoUrl,
              videoUrl: post!.mediaUrl![0]!,
              aspectRatio: (Get.size.height / 2.62) /
                  (MediaQuery.of(context).size.width - 10),
            )
          ],
          Positioned(
            top: 30,
            left: 27,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: post!.mediaType == "video"
                      ? const CachedNetworkImageProvider(
                          "https://picsum.photos/500/500?random=851")
                      : CachedNetworkImageProvider(widget.userImg!),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    //     final tok = globToken ??  await HiveDB.getAuthToken();

                    String? temp = post!.user!.personalTemplate;
                    if (temp == null) {
                      Get.snackbar('No persona Choosen by this user',
                          'Hi No persona here');
                    } else {
                      if (temp.isEmpty || temp[0] == 'T') {
                        Get.snackbar('This is a Old account ',
                            'Persona wont work properly');
                        temp = '64e8f2c3b9b30c1ed4b28bb6';
                      }
                      Get.to(() => OwnWebView(
                            token: homePostController.token!,
                            userId: widget.myUserId!,
                            personaUserId: post!.user!.sId!,
                            templateId: ' ',
                          ));
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${post?.user!.username.toString()}",
                        style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: whiteColor),
                      ),
                      Text("@${post?.user!.getstatedName.toString()}",
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: whiteColor)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Row(
              children: [
                if (post!.mediaUrl!.length > 1) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/png/multimage.png"),
                  ),
                  Text(
                    post!.mediaUrl!.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            backgroundColor: Colors.transparent,
                            iconColor: Colors.amberAccent,
                            content: StatefulBuilder(builder: (
                              BuildContext context,
                              StateSetter setState,
                            ) {
                              return Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.grey,
                                    primaryColor: Colors.amber,
                                    textTheme: Typography.whiteCupertino),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(255, 17, 17, 16),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height:
                                      MediaQuery.of(context).size.height * 0.75,
                                  child: Column(
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text('Report Post',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.center)),
                                      RadioListTile<reportcharacter>(
                                        title: const Text('Spam'),
                                        value: reportcharacter.Spam,
                                        groupValue: _character,
                                        onChanged: (reportcharacter? value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                      RadioListTile<reportcharacter>(
                                        title: const Text('Misinformation'),
                                        value: reportcharacter.Misinformation,
                                        groupValue: _character,
                                        onChanged: (reportcharacter? value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                      RadioListTile<reportcharacter>(
                                        title: const Text('Harmful'),
                                        value: reportcharacter.Harmful,
                                        groupValue: _character,
                                        onChanged: (reportcharacter? value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                      RadioListTile<reportcharacter>(
                                        title: const Text('Misleading'),
                                        value: reportcharacter.Misleading,
                                        groupValue: _character,
                                        onChanged: (reportcharacter? value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                      RadioListTile<reportcharacter>(
                                        title: const Text('Hateful'),
                                        value: reportcharacter.Hateful,
                                        groupValue: _character,
                                        onChanged: (reportcharacter? value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                      const Spacer(),
                                      ButtonBar(
                                        children: <Widget>[
                                          TextButton(
                                            child: const Text('Ok'),
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }));
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.info,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                if (isShowPoll) ...[
                  (post!.customPollEnabled!)
                      ? !(map?["isVoted"] == "True" ? true : false)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FormHeadingText(
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
                                    post!.customPollData!.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        onTap: () async {
                                          if (index == selectedOption) {
                                            selectedOption = -1;
                                            setState(() {});
                                            return;
                                          }
                                          selectedOption = index;
                                          map = await homePostController
                                              .postCustomPoll(post!.sId!,
                                                  post!.customPollData![index]);
                                          //  map?["isVoted"] = "True";
                                          //map[]
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 52,
                                          width: 100,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: selectedOption == index
                                                ? whiteColor
                                                : null,
                                            border:
                                                Border.all(color: whiteColor),
                                          ),
                                          child: FormHeadingText(
                                            headings:
                                                post!.customPollData![index],
                                            color: selectedOption != index
                                                ? whiteColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              width: width * .7,
                              child: Column(
                                children: [
                                  const FormHeadingText(
                                    textAlign: TextAlign.center,
                                    headings: "Poll\nResult",
                                    color: whiteColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Column(
                                      children: List.generate(
                                    post!.customPollData?.length ??
                                        map!.length - 1,
                                    growable: true,
                                    (index) => Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${post!.customPollData![index]} ${map![post!.customPollData![index]]}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 20),
                                          child: SizedBox(
                                            width: width * .7,
                                            child: LinearProgressIndicator(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              minHeight: 10,
                                              value: poll?.pollCalculation
                                                      ?.yesPercentage ??
                                                  (100 -
                                                      (poll?.pollCalculation
                                                              ?.noPercentage ??
                                                          50)),
                                              color: const Color.fromRGBO(
                                                  76, 101, 168, 0.9),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      217, 217, 217, 0.8),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            )
                      : poll?.isVoted ?? false
                          ? SizedBox(
                              width: width * .7,
                              child: Column(
                                children: [
                                  const FormHeadingText(
                                    textAlign: TextAlign.center,
                                    headings: "Poll\nResult",
                                    color: whiteColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Yes ${poll?.pollCalculation?.yesPercentage ?? (100 - (poll?.pollCalculation?.noPercentage ?? 50))}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 20),
                                    child: SizedBox(
                                      width: width * .7,
                                      child: LinearProgressIndicator(
                                        borderRadius: BorderRadius.circular(15),
                                        minHeight: 10,
                                        value: poll?.pollCalculation
                                                ?.yesPercentage ??
                                            (100 -
                                                (poll?.pollCalculation
                                                        ?.noPercentage ??
                                                    50)),
                                        color: const Color.fromRGBO(
                                            76, 101, 168, 0.9),
                                        backgroundColor: const Color.fromRGBO(
                                            217, 217, 217, 0.8),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "No ${poll?.pollCalculation?.noPercentage ?? (100 - (poll?.pollCalculation?.yesPercentage ?? 50))}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 10),
                                    child: SizedBox(
                                      width: width * .7,
                                      child: LinearProgressIndicator(
                                        borderRadius: BorderRadius.circular(15),
                                        minHeight: 10,
                                        value: poll?.pollCalculation
                                                ?.noPercentage ??
                                            (100 -
                                                (poll?.pollCalculation
                                                        ?.yesPercentage ??
                                                    50)),
                                        color: const Color.fromRGBO(
                                            76, 101, 168, 0.9),
                                        backgroundColor: const Color.fromRGBO(
                                            217, 217, 217, 0.8),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FormHeadingText(
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
                                        onTap: () async {
                                          if (index == selectedOption) {
                                            selectedOption = -1;
                                            setState(() {});
                                            return;
                                          }
                                          selectedOption = index;
                                          poll =
                                              await homePostController.postPoll(
                                                  post!.sId!,
                                                  (index == 0 ? "yes" : "no"));

                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 52,
                                          width: 100,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: selectedOption == index
                                                ? whiteColor
                                                : null,
                                            border:
                                                Border.all(color: whiteColor),
                                          ),
                                          child: FormHeadingText(
                                            headings: chooseOption[index],
                                            color: selectedOption != index
                                                ? whiteColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                ],
                if (post!.enabledpoll!) ...[
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () async {
                        if (post!.customPollEnabled!) {
                          map = await homePostController
                              .customPolldetail(post!.sId!);
                          setState(() {
                            isShowPoll = !isShowPoll;
                          });
                        } else {
                          poll =
                              await homePostController.Polldetail(post!.sId!);
                          setState(() {
                            isShowPoll = !isShowPoll;
                            isvoted = poll?.isVoted ?? false;
                          });
                        }
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
                ],
                InkWell(
                  onTap: () {
                    Get.to(() => CommentViewScreen(
                          update: _update,
                          post: post!,
                          isLiked: widget.isLiked ?? false,
                          myUserId: widget.myUserId,
                        ));
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFffffff).withOpacity(.2),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              const Color(0xFFffffff).withOpacity(0.20),
                              const Color(0xFFFFFFFF).withOpacity(0.25),
                            ],
                            stops: const [
                              2,
                              0.1,
                            ]),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: Get.size.width / 2,
                              child: Text("${post!.caption}",
                                  style: const TextStyle(
                                      fontSize: 7,
                                      fontWeight: FontWeight.w400,
                                      color: whiteColor)),
                            ),
                            //    const Expanded(child: SizedBox()),
                            GestureDetector(
                                onTap: () {
                                  if (homePostController
                                      .posts![widget.index!].isLike!) {
                                    setState(() {
                                      homePostController.posts![widget.index!]
                                          .likeCount = homePostController
                                              .posts![widget.index!]
                                              .likeCount! -
                                          1;
                                      //      post!.likes!.removeLast();
                                      homePostController
                                          .posts![widget.index!].isLike = false;
                                    });
                                    homePostController.likePost(post!.sId!,
                                        false, post?.user?.sId ?? "");
                                  } else {
                                    setState(() {
                                      homePostController.posts![widget.index!]
                                          .likeCount = homePostController
                                              .posts![widget.index!]
                                              .likeCount! +
                                          1;
                                      //  post!.likes!.add(widget.myUserId!);
                                      homePostController
                                          .posts![widget.index!].isLike = true;
                                    });
                                    homePostController.likePost(post!.sId!,
                                        true, post?.user?.sId ?? "");
                                  }
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                "${homePostController.posts?[widget.index!].likeCount}",
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: whiteColor),
                              ),
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
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: whiteColor),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Share.share(
                                    "http://emagz.live/Post/${post?.sId}");
                              },
                              child: Image.asset(
                                "assets/png/share_icon.png",
                                width: 26,
                              ),
                            ),
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
