import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/common/common_appbar.dart';
import 'package:emagz_vendor/social_media/screens/chat/chat_setting_screen.dart';
import 'package:emagz_vendor/social_media/screens/settings/comments/comment_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../live/live_setting.dart';
import '../mention/mention_setting_screen.dart';
import '../personal_page/widgets/setting_common_tile.dart';
import '../post/post_setting_screen.dart';
import '../story/story_setting_screen.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool isActive = false;
  bool cmnt=false;
  bool mess=false;
  bool stor=false;
  bool ment=false;
  bool postb=false;
  bool live=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: socialBack,
      appBar: const SocialMediaSettingAppBar(title: "Setting"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                "Privacy",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                height: 64,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(15)),
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.lock_open_sharp,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Private Account",
                            style: TextStyle(
                                color: blackButtonColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 150,
                            child: Text(
                              "only people who follow can see ur post and message you ",
                              style: TextStyle(
                                  color: signInHeading,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      FlutterSwitch(
                          activeColor: whiteAcent,
                          toggleColor: pendingColor,
                          padding: 2,
                          height: 20,
                          width: 45,
                          value: isActive,
                          onToggle: (val) {
                            setState(() {
                              isActive = val;
                            });
                          }),
                      const SizedBox(
                        width: 25,
                      ),
                    ]),
              ),
              Container(
                height: 64,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(15)),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.admin_panel_settings_outlined,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Change Password",
                          style: TextStyle(
                              color: blackButtonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 150,
                          child: Text(
                            "Change your password form here",
                            style: TextStyle(
                                color: signInHeading,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: blackButtonColor,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Interactions",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              InkWell(
                onTap: () {

                  setState(() {
                    cmnt=true;
                  });
                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {
                      cmnt=false;
                    });


                  });
                  Get.to(() => const CommentSetting());
                },
                child: PreferenceTile(
                  isBlue: cmnt,
                  title: 'Comment',
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    postb=true;
                  });
                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {
                      postb=false;
                    });
                  });
                  Get.to(() => const PostSettingScreen());
                },
                child: PreferenceTile(
                  isBlue:postb,
                  title: 'Posts',
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    ment=true;
                  });
                  Future.delayed(const Duration(milliseconds: 2000), () {
                    setState(() {
                      ment=false;
                    });
                  });
                  Get.to(() => const MentionSettingScreen());
                },
                child: PreferenceTile(
                  isBlue:ment,
                  title: 'Mentions',
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    stor=true;
                  });
                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {
                      stor=false;
                    });


                  });
                  Get.to(() => const StorySettingScreen());
                },
                child: PreferenceTile(
                  isBlue:stor,
                  title: 'Story',
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    live=true;
                  });
                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {
                      live=false;
                    });


                  });
                  Get.to(() => const LiveSettingScreen());
                },
                child: PreferenceTile(
                  isBlue:live,
                  title: 'Live',
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    mess=true;
                  });
                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {
                      mess=false;
                    });


                  });
                  Get.to(() => const ChatSettingScreen());
                },
                child: PreferenceTile(
                  isBlue:mess,
                  title: 'Messages',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
