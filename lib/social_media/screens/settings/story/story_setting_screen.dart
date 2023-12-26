import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/models/user_schema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../common/common_appbar.dart';
import '../../../common/title_switch/title_and_switch_widget.dart';
import '../../../controller/privacy/privacy_controller.dart';

class StorySettingScreen extends StatefulWidget {
  const StorySettingScreen({Key? key}) : super(key: key);

  @override
  State<StorySettingScreen> createState() => _StorySettingScreenState();
}

class _StorySettingScreenState extends State<StorySettingScreen> {
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
    final StoryPrivacy storyPrivacy = constuser!.storyPrivacy!;

    if (storyPrivacy.everyone ?? false) {
      active = "Everyone";
    } else if (storyPrivacy.closeFriend ?? false) {
      active = "closeFriend";
    } else if (storyPrivacy.noOne ?? false) {
      active = "noOne";
    } else {
      active = "specific";
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
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(
              "Story Setting",
              style: TextStyle(
                  color: blackButtonColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Story",
                    style: TextStyle(
                        color: blackButtonColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Hide your stories from",
                    style: TextStyle(
                        color: signInHeading,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleAndSwitchWidget(
                    title: "Everyone",
                    isActive: "Everyone" == active,
                    onToggle: (val) {
                      if (val) {
                        setState(() {
                          active = "Everyone";
                        });
                        privacyController
                            .privacyStoryControl(true, false, false, false, []);
                      }
                      //else {
                      //   setState(() {
                      //     active = "Followers >";
                      //   });
                      //   privacyController.privacyCommentControl(
                      //       false, true, false, false);
                      // }
                    },
                  ),
                  TitleAndSwitchWidget(
                    title: "Close Friends",
                    subTitle: constuser!.followers == 0
                        ? null
                        : "${constuser!.followers} People",
                    isActive: active == "closeFriend",
                    onToggle: (val) {
                      if (val) {
                        setState(() {
                          active = "closeFriend";
                        });
                        privacyController
                            .privacyStoryControl(false, true, false, false, []);
                      }
                      // else {
                      //   setState(() {
                      //     active = "No one >";
                      //   });
                      //   privacyController.privacyCommentControl(
                      //       false, false, false, false);
                      // }
                    },
                  ),
                  TitleAndSwitchWidget(
                    title: "No one",
                    isActive: active == "noOne",
                    onToggle: (val) {
                      if (val) {
                        setState(() {
                          active = "noOne";
                        });
                        privacyController
                            .privacyStoryControl(false, false, false, true, []);
                      }
                      //  else {
                      //   setState(() {
                      //     active = "Followers >";
                      //   });
                      //   privacyController.privacyCommentControl(
                      //       false, true, false, false);
                      // }
                    },
                  ),
                  const Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Specific Person",
                        style: TextStyle(
                            color: blackButtonColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
