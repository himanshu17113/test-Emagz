import 'dart:typed_data';

import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/post/post_controller.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/widgets/modalBottomSheets/FollowingList.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/widgets/modalBottomSheets/LikesAndViewsOptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../constant/colors.dart';
import '../../../common/title_switch/title_and_switch_widget.dart';
import '../../home/widgets/home_screen_appbar.dart';

enum PostType { text, poll, gallery, camera }

class PrePostScreen extends StatefulWidget {
  final PostType postType;
  Uint8List? image;
  PrePostScreen({super.key, this.image, required this.postType});

  @override
  State<PrePostScreen> createState() => _PrePostScreenState();
}

class _PrePostScreenState extends State<PrePostScreen> {
  List chooseOption = ["A. Yes", "B. No"];
  int selectedOption = -1;

  List timerOptionList = ["1D", "2D", "7D"];
  int selectedTimer = -1;

  bool isPollEnable = false;

  bool isFollowing = false;

  bool peopleYouFollow = false;
  bool everyOne = true;
  bool noOne = false;
  bool followAndFollower = false;

  var postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 35),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffF8F8F8),
            Color(0xffDCE5FF),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const SocialHomeScreenAppBar(
            isColor: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: 170,
                      //   decoration:
                      //       const BoxDecoration(color: Colors.black),
                      //   child: (widget.postType == PostType.gallery)?Image.memory(widget.image!) : Container(child: const Text("EDITABLE TEXT"),)
                      // ),
                      Container(
                        alignment: Alignment.center,
                        height: 35,
                        decoration: const BoxDecoration(color: Colors.black),
                        child: FormHeadingText(
                          headings: "Edit Post",
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
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
                      FormHeadingText(headings: "Enable Poll"),
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
                              decoration: BoxDecoration(
                                  color: selectedTimer == index ? lightSkyAcent : null,
                                  // border: Border.all(color: lightSkyAcent),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: FormHeadingText(
                                  headings: timerOptionList[index],
                                  color: selectedTimer != index ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Row(
                      //   children: List.generate(
                      //     timerOptionList.length,
                      //     (index) =>
                      //         ,
                      //   ),
                      // ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate =
                              await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2060));
                          TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                          var time = pickedDate!.add(Duration(hours: pickedTime!.hour, minutes: pickedTime.minute));
                          var timeDifference = time.difference(DateTime.now());
                          print(timeDifference.inDays.toString());
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
                                SizedBox(
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
                                          shape: const OutlineInputBorder(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                                          shape: const OutlineInputBorder(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                                SizedBox(
                                  height: 30,
                                  // width: 140,
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
                    // margin: const EdgeInsets.symmetric(horizontal: 8),
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
                        Text(
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Everyone",
                        //       style: TextStyle(
                        //           color: blackButtonColor,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w600),
                        //     ),
                        //     FlutterSwitch(
                        //         activeColor: whiteAcent,
                        //         toggleColor: blueColor,
                        //         padding: 1,
                        //         height: 20,
                        //         width: 50,
                        //         inactiveColor: lightgrayColor,
                        //         inactiveToggleColor: toggleInactive,
                        //         value: everyOne,
                        //         onToggle: (val) {
                        //           setState(() {
                        //             everyOne = val;
                        //           });
                        //         }),
                        //   ],
                        // ),
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
                isPollEnable ? timerOptionList[selectedTimer].toString().split("D")[0] : null),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              alignment: Alignment.center,
              height: 51,
              // width: ,
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
                    : FormHeadingText(
                        headings: "Upload",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 14,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
