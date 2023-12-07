import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/models/user_schema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../common/common_appbar.dart';
import '../../../common/title_switch/title_and_switch_widget.dart';
 import '../../../controller/privacy/privacy_controller.dart';
 
class MentionSettingScreen extends StatefulWidget {
  const MentionSettingScreen({Key? key}) : super(key: key);

  @override
  State<MentionSettingScreen> createState() => _MentionSettingScreenState();
}

class _MentionSettingScreenState extends State<MentionSettingScreen> {

   UserSchema? user;
  bool? youFollow ;
  bool? everyOne;
  bool? noone;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  asyncInit() async {

    user = await HiveDB.getCurrentUserDetail();
    youFollow= user!.ment_priv!.yourFollower;

    everyOne= user!.ment_priv!.everyone;
    noone=user!.ment_priv!.noOne;

    setState(() {});
  }
  final privacyController= Get.put(PrivacyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: socialBack,
      appBar: const SocialMediaSettingAppBar(title: "Setting"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "Mentions Setting",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(15),
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
                  Text(
                    "Allow Like And View from",
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
                      Text(
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
                          value: everyOne??true,
                          onToggle: (val) {
                            setState(() {
                              everyOne = val;
                            });
                            privacyController.privacyMentionControl(everyOne!, youFollow!, noone!);
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleAndSwitchWidget(
                    title: "People you follow",
                    subTitle: "53 People",
                    isActive: youFollow??true,
                    onToggle: (val)
                    {
                      setState(() {
                        youFollow = val;
                      });
                      privacyController.privacyMentionControl(everyOne!, youFollow!, noone!);

                    },

                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TitleAndSwitchWidget(
                    title: "No One Except Specific Profiles",
                    subTitle: "",
                    isActive: noone??false,
                    onToggle: (val)
                    {
                      setState(() {
                        noone = val;
                      });
                      privacyController.privacyMentionControl(everyOne!, youFollow!, noone!);

                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
