import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/common/common_appbar.dart';
import 'package:emagz_vendor/social_media/controller/privacy/privacy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/data.dart';
import '../../../common/title_switch/title_and_switch_widget.dart';
import '../../../models/user_schema.dart';

class CommentSetting extends StatefulWidget {
  const CommentSetting({super.key});

  @override
  State<CommentSetting> createState() => _CommentSettingState();
}

class _CommentSettingState extends State<CommentSetting> {
//UserSchema? user;
  late String active;
  bool showBox = false;
  bool showSearch = false;
  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  // late final CommentPrivacy commentPrivacy;
  asyncInit() async {
    final CommentPrivacy commentPrivacy = constuser!.commentPrivacy!;

    if (commentPrivacy.everyone ?? false) {
      active = "Everyone >";
    } else if (commentPrivacy.followers ?? false) {
      active = "Followers >";
    }
    // else if (commentPrivacy. ?? false) {
    //   active = "Followers >";
    // }
    else {
      active = "No one >";
    }
    //user = await HiveDB.getCurrentUserDetail();
  }

  final privacyController = Get.put(PrivacyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: socialBack,
      appBar: const SocialMediaSettingAppBar(title: "Setting"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              "Comment Setting",
              style: TextStyle(
                  color: blackButtonColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Card(
            color: whiteColor,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Comments",
                    style: TextStyle(
                        color: blackButtonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 15),
                    child: Text(
                      "Control",
                      style: TextStyle(
                          color: signInHeading,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Allow comments from",
                          style: TextStyle(
                              color: blackButtonColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () {
                          showBox = !showBox;
                          setState(() {
                            showSearch = false;
                          });
                        },
                        child: Text(
                          active,
                          style: const TextStyle(
                              color: purpleColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Block comment from",
                            style: TextStyle(
                                color: blackButtonColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "Any new comment from people you block will not be visible to anyone but them",
                              style: TextStyle(
                                  letterSpacing: .3,
                                  color: signInHeading,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showSearch = !showSearch;
                              setState(() {});
                            },
                            child: const Text(
                              "0 people",
                              style: TextStyle(
                                  color: purpleColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
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
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          showBox
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(15),

                  ///  height: 210,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Allow comments from",
                        style: TextStyle(
                            //   color: signInHeading,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TitleAndSwitchWidget(
                        title: "Everyone",
                        isActive: "Everyone >" == active,
                        onToggle: (val) {
                          if (val) {
                            setState(() {
                              active = "Everyone >";
                            });
                            privacyController.privacyCommentControl(
                                true, false, false, false);
                          } else {
                            setState(() {
                              active = "Followers >";
                            });
                            privacyController.privacyCommentControl(
                                false, true, false, false);
                          }
                        },
                      ),
                      TitleAndSwitchWidget(
                        title: "Your followers",
                        subTitle: constuser!.followers == 0
                            ? null
                            : "${constuser!.followers} People",
                        isActive: active == "Followers >",
                        onToggle: (val) {
                          if (val) {
                            setState(() {
                              active = "Followers >";
                            });
                            privacyController.privacyCommentControl(
                                false, true, false, false);
                          } else {
                            setState(() {
                              active = "No one >";
                            });
                            privacyController.privacyCommentControl(
                                false, false, false, false);
                          }
                        },
                      ),
                      TitleAndSwitchWidget(
                        title: "No one",
                        isActive: active == "No one >",
                        onToggle: (val) {
                          if (val) {
                            setState(() {
                              active = "No one >";
                            });
                            privacyController.privacyCommentControl(
                                false, false, false, false);
                          } else {
                            setState(() {
                              active = "Followers >";
                            });
                            privacyController.privacyCommentControl(
                                false, true, false, false);
                          }
                        },
                      )
                    ],
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 20,
          ),
          showSearch
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(15),
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Block comments from",
                        style: TextStyle(
                            color: signInHeading,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: whiteAcent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: grayColor)),
                        child: const TextField(
                          cursorColor: grayColor,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(color: Colors.black),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              )),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
