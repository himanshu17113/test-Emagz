import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/common/common_appbar.dart';
import 'package:emagz_vendor/social_media/models/user_schema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../common/title_switch/title_and_switch_widget.dart';
import '../../../controller/privacy/privacy_controller.dart';

class PostSettingScreen extends StatefulWidget {
  const PostSettingScreen({Key? key}) : super(key: key);

  @override
  State<PostSettingScreen> createState() => _PostSettingScreenState();
}

class _PostSettingScreenState extends State<PostSettingScreen> {
  late String active;

  // UserSchema? user;
  bool? youFollow;
  bool? everyOne;
  bool? noone;
  bool showBox1 = false;
  bool showBox22 = false;
  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  asyncInit() async {
    final Privacy postPrivacy = constuser!.postPrivacy!;

    if (postPrivacy.everyone ?? false) {
      active = "Everyone >";
    } else if (postPrivacy.followers ?? false) {
      active = "Followers >";
    }
    // else if (commentPrivacy. ?? false) {
    //   active = "Followers >";
    // }
    else if (postPrivacy.noOne ?? false) {
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
              "Post Setting",
              style: TextStyle(
                  color: blackButtonColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
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
                    "Post",
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
                      const Text("Likes & View",
                          style: TextStyle(
                              color: blackButtonColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showBox1 = !showBox1;

                            showBox22 = false;
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Hide like & views control",
                  //           style: TextStyle(
                  //               color: blackButtonColor,
                  //               fontSize: 11,
                  //               fontWeight: FontWeight.w600),
                  //         ),
                  //         SizedBox(
                  //           height: 2,
                  //         ),
                  //         SizedBox(
                  //           width: 200,
                  //           child: Text(
                  //             "Manage your likes and view on your post",
                  //             style: TextStyle(
                  //                 letterSpacing: .3,
                  //                 color: signInHeading,
                  //                 fontSize: 9,
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     Row(
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () {
                  //             setState(() {
                  //               showBox22 = !showBox22;
                  //               showBox1 = false;
                  //             });
                  //           },
                  //           child: const Text(
                  //             "0 people",
                  //             style: TextStyle(
                  //                 color: purpleColor,
                  //                 fontSize: 11,
                  //                 fontWeight: FontWeight.w600),
                  //           ),
                  //         ),
                  //         const SizedBox(
                  //           width: 8,
                  //         ),
                  //         const Icon(
                  //           Icons.arrow_forward_ios,
                  //           size: 10,
                  //         )
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (showBox1) ...[
            Container(
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
                    "Allow Like And View from",
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
                        privacyController.privacyPostControl(
                            true, false, false);
                      } else {
                        setState(() {
                          active = "Followers >";
                        });
                        privacyController.privacyPostControl(
                            false, true, false);
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
                        privacyController.privacyPostControl(
                            false, true, false);
                      } else {
                        setState(() {
                          active = "No one >";
                        });
                        privacyController.privacyPostControl(
                            false, false, true);
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
                        privacyController.privacyPostControl(
                            false, false, true);
                      } else {
                        setState(() {
                          active = "Followers >";
                        });
                        privacyController.privacyPostControl(
                          false,
                          true,
                          false,
                        );
                      }
                    },
                  )
                ],
              ),
            )
          ],
          const SizedBox(
            height: 20,
          ),
          showBox22
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  // height: 175,
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
                        "Allow Post Sharing from",
                        style: TextStyle(
                            color: toggleInactive,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Everyone",
                            style: TextStyle(
                                color: blackButtonColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          FlutterSwitch(
                              activeColor: whiteAcent,
                              toggleColor: blueColor,
                              padding: 0,
                              height: 15,
                              width: 40,
                              inactiveColor: lightgrayColor,
                              inactiveToggleColor: toggleInactive,
                              value: everyOne ?? true,
                              onToggle: (val) {
                                setState(() {
                                  everyOne = val;
                                });
                                privacyController.privacyPostControl(
                                    everyOne!, youFollow!, noone!);
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TitleAndSwitchWidget(
                        title: "People you follow",
                        subTitle: "53 People",
                        isActive: youFollow ?? true,
                        onToggle: (val) {
                          setState(() {
                            youFollow = val;
                          });

                          privacyController.privacyPostControl(
                              everyOne!, youFollow!, noone!);
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TitleAndSwitchWidget(
                        title: "No One Except Specific Profiles",
                        subTitle: "",
                        isActive: noone ?? true,
                        onToggle: (val) {
                          setState(() {
                            noone = val;
                          });

                          privacyController.privacyPostControl(
                              everyOne!, youFollow!, noone!);
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
