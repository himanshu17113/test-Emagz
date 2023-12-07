import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/post/post_controller.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/widgets/modalBottomSheets/FollowingList.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/widgets/modalBottomSheets/LikesAndViewsOptions.dart';
import '../../../../constant/colors.dart';
import '../../../common/title_switch/title_and_switch_widget.dart';
import '../../home/widgets/home_screen_appbar.dart';
import 'custompoll.dart';

enum PostType { text, poll, gallery, camera }

class PrePostScreen extends StatefulWidget {
  final PostType postType;
  final String? image;
  final List<Uint8List>? images;
  const PrePostScreen({
    Key? key,
    required this.postType,
    this.image,
    this.images,
  }) : super(key: key);

  @override
  State<PrePostScreen> createState() => _PrePostScreenState();
}

class _PrePostScreenState extends State<PrePostScreen> {
  List chooseOption = ["A. Yes", "B. No"];
  int selectedOption = -1;

  List timerOptionList = [1, 2, 7];
  int selectedTimer = -1;

  bool isPollEnable = false;
  bool isCustomPoll = false;
  bool isShowAudience = false;

  bool isFollowing = false;

  bool peopleYouFollow = false;
  bool everyOne = true;
  bool noOne = false;
  bool followAndFollower = false;

  // final postController = Get.put(PostController(), tag: "PostController");
  final postController = Get.find<PostController>(tag: "PostController");
  @override
  Widget build(BuildContext context) {
//    print(postController.assetType);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const SocialHomeScreenAppBar(
          isColor: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      if (widget.images != null) ...[
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                          items: List.generate(
                              widget.images!.length,
                              (i) => SizedBox(
                                    child: Image.memory(
                                      widget.images![i],
                                      height: 300,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  )).toList(),
                        )
                      ],
                      if (widget.image != null) ...[
                        SizedBox(
                          child: Image.file(
                            File(widget.image!),
                            height: 300,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ],
                      GestureDetector(
                        onTap: () => Get.close(1),
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          decoration: const BoxDecoration(color: Colors.black),
                          child: const FormHeadingText(
                            headings: "Edit Post",
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (postController.assetType == PostType.poll) ...[
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          chooseOption.length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedOption = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: selectedOption == index ? lightSkyAcent : null,
                                border: Border.all(color: lightSkyAcent),
                              ),
                              child: FormHeadingText(
                                headings: chooseOption[index],
                                color: selectedOption != index ? lightSkyAcent : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const FormHeadingText(headings: "Enable Poll"),
                      const SizedBox(
                        width: 5,
                      ),
                      FlutterSwitch(
                        padding: 0,
                        height: 21,
                        width: 45,
                        activeColor: lightSkyAcent.withOpacity(.8),
                        activeToggleColor: const Color(0xff2E5EE2),
                        onToggle: (bool value) {
                          setState(() {
                            isPollEnable = value;
                          });
                        },
                        value: isPollEnable,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isPollEnable
                      ? SizedBox(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const FormHeadingText(headings: "Custom Poll"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  FlutterSwitch(
                                    padding: 0,
                                    height: 21,
                                    width: 45,
                                    activeColor: lightSkyAcent.withOpacity(.8),
                                    activeToggleColor: const Color(0xff2E5EE2),
                                    onToggle: (bool value) {
                                      setState(() {
                                        isCustomPoll = value;
                                      });
                                      if (value == true) {
                                        Get.to(() => CustomPollSelectScreen(images: widget.images, postType: widget.postType));
                                      }
                                    },
                                    value: isCustomPoll,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const FormHeadingText(headings: "Show Results to audience"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  FlutterSwitch(
                                    padding: 0,
                                    height: 21,
                                    width: 45,
                                    activeColor: lightSkyAcent.withOpacity(.8),
                                    activeToggleColor: const Color(0xff2E5EE2),
                                    onToggle: (bool value) {
                                      setState(() {
                                        isShowAudience = value;
                                      });
                                    },
                                    value: isShowAudience,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    "Set Timer".toUpperCase(),
                    style: GoogleFonts.inter(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 120,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: timerOptionList.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedTimer = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: selectedTimer == index ? lightSkyAcent : null, shape: BoxShape.circle),
                              child: Center(
                                child: FormHeadingText(
                                  headings: "${timerOptionList[index]}D",
                                  color: selectedTimer != index ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2060));
                          TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                          var time = pickedDate!.add(Duration(hours: pickedTime!.hour, minutes: pickedTime.minute));
                          var timeDifference = time.difference(DateTime.now());
                          debugPrint(timeDifference.inDays.toString());
                          timerOptionList.add("${timeDifference.inDays}D");
                          selectedTimer = timerOptionList.length - 1;
                          setState(() {});
                        },
                        child: Text(
                          "Set Custom".toUpperCase(),
                          style: GoogleFonts.inter(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
                Text(
                  "Describe your feeling".toUpperCase(),
                  style: GoogleFonts.inter(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xff28282836).withOpacity(.21), width: 1.5),
                  ),
                  child: TextField(
                    maxLength: 32,
                    controller: postController.captionController,
                    maxLines: 2,
                    decoration: const InputDecoration(isDense: true, border: InputBorder.none, contentPadding: EdgeInsets.all(0)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Post Settings".toUpperCase(),
                  style: GoogleFonts.inter(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 155,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Post",
                        style: TextStyle(color: blackButtonColor, fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Likes & View", style: TextStyle(color: blackButtonColor, fontSize: 10, fontWeight: FontWeight.w600)),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Hide like & views control",
                                style: TextStyle(color: blackButtonColor, fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const SizedBox(
                                width: 140,
                                child: Text(
                                  "Manage your likes and view on your post",
                                  style: TextStyle(letterSpacing: .3, color: signInHeading, fontSize: 9, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: const OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                        context: context,
                                        builder: (context) {
                                          return LikesAndViewsOptions(onTap: (value, showValue) {
                                            postController.privacyLikesAndViewsUI.value = showValue;
                                            postController.privacyLikesAndViews.value = value;
                                          });
                                        },
                                      );
                                    },
                                    child: Obx(
                                      () => Text(
                                        postController.privacyLikesAndViewsUI.value,
                                        style: TextStyle(color: purpleColor, fontSize: 11, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: const OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                        context: context,
                                        builder: (context) {
                                          return const FollowingList();
                                        },
                                      );
                                    },
                                    child: Text(
                                      "0 people",
                                      style: TextStyle(color: purpleColor, fontSize: 11, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
                                height: 30,
                                child: Text(
                                  "",
                                  style: TextStyle(letterSpacing: .3, color: signInHeading, fontSize: 9, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 190,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Allow Tag from",
                        style: TextStyle(color: signInHeading, fontSize: 11, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TitleAndSwitchWidget(
                        title: "Everyone",
                        subTitle: "",
                        isActive: everyOne,
                        onToggle: (active) {
                          setState(() {
                            everyOne = true;
                            noOne = false;
                            peopleYouFollow = false;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TitleAndSwitchWidget(
                        title: "People you follow",
                        subTitle: "53 People",
                        isActive: peopleYouFollow,
                        onToggle: (active) {
                          setState(() {
                            peopleYouFollow = true;
                            noOne = false;
                            everyOne = false;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TitleAndSwitchWidget(
                        title: "No One",
                        subTitle: "",
                        isActive: noOne,
                        onToggle: (isActive) {
                          setState(() {
                            noOne = true;
                            peopleYouFollow = false;
                            everyOne = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () => postController.makePost(
              isPollEnable,
              everyOne
                  ? "everyone"
                  : (peopleYouFollow
                      ? "peopleYouFollow"
                      : noOne
                          ? "noOne"
                          : "everyone"),
              isPollEnable
                  ? selectedTimer == -1
                      ? null
                      : timerOptionList[selectedTimer]
                  : null,
              isCustomPoll,
              widget.images ?? []),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            alignment: Alignment.center,
            height: 51,
            decoration: BoxDecoration(
              color: const Color(0xff1B47C1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(
              () => postController.isPosting.value
                  ? Obx(() => Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(value: postController.uploadPercentage.value, color: Colors.white),
                            Text(
                              "${(postController.uploadPercentage.value * 100).toInt().toString()}%",
                              style: const TextStyle(color: Colors.white, fontSize: 10),
                            )
                          ],
                        ),
                      ))
                  : const FormHeadingText(
                      headings: "Upload",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 14,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
