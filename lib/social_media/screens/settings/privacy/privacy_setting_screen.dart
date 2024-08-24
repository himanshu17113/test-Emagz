import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/common/common_appbar.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/screens/chat/chat_setting_screen.dart';
import 'package:emagz_vendor/social_media/screens/settings/comments/comment_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/user_schema.dart';
import '../live/live_setting.dart';
import '../mention/mention_setting_screen.dart';
import '../personal_page/widgets/setting_common_tile.dart';
import '../post/post_setting_screen.dart';
import '../story/story_setting_screen.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: socialBack,
      appBar: const SocialMediaSettingAppBar(title: "Setting"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Privacy",
              style: TextStyle(
                  color: blackButtonColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              height: 64,
              padding: const EdgeInsets.only(right: 10),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(15)),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.lock_open_sharp,
                        size: 20,
                      ),
                    ),
                    const Expanded(
                      flex: 5,
                      child: Column(
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
                          SizedBox(
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
                    ),
                    Expanded(
                      flex: 1,
                      child: ValueListenableBuilder<Box>(
                          valueListenable: Hive.box("secretes").listenable(),
                          builder: (context, box, widget) {
                            UserSchema user = box.get("user");
                            return FlutterSwitch(
                                activeColor: whiteAcent,
                                toggleColor: pendingColor,
                                padding: 2,
                                height: 20,
                                width: 45,
                                value: user.isPrivate == "Yes" ? true : false,
                                onToggle: (val) {
                                  user.isPrivate = val ? "Yes" : "No";
                                  HiveDB.togglePrivate(val);
                                  box.put('user', user);
                                });
                          }),
                    ),
                  ]),
            ),
            Container(
              height: 64,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(15)),
              child: const Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.admin_panel_settings_outlined,
                    size: 20,
                  ),
                  SizedBox(
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
                      SizedBox(
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
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: blackButtonColor,
                    size: 15,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Interactions",
              style: TextStyle(
                  color: blackButtonColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            PreferenceTile(
              onTap: () => Get.to(() => const CommentSetting()),
              title: 'Comment',
            ),
            PreferenceTile(
                title: 'Posts',
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const PostSettingScreen()))),
            PreferenceTile(
              onTap: () => Get.to(() => const MentionSettingScreen()),
              title: 'Mentions',
            ),
            PreferenceTile(
              onTap: () => Get.to(() => const StorySettingScreen()),
              title: 'Story',
            ),
            PreferenceTile(
              onTap: () => Get.to(() => const LiveSettingScreen()),
              title: 'Live',
            ),
            PreferenceTile(
              onTap: () => Get.to(() => const ChatSettingScreen()),
              title: 'Messages',
            ),
          ],
        ),
      ),
    );
  }
}
