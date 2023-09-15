
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/common/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../common/title_switch/title_and_switch_widget.dart';
import '../../../controller/auth/jwtcontroller.dart';
import '../../../controller/privacy/privacy_controller.dart';
import '../../../models/post_model.dart';

class PostSettingScreen extends StatefulWidget {
  const PostSettingScreen({Key? key}) : super(key: key);

  @override
  State<PostSettingScreen> createState() => _PostSettingScreenState();
}

class _PostSettingScreenState extends State<PostSettingScreen> {
  var jwtController= Get.put(JWTController());
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

    user = await jwtController.getCurrentUserDetail();
    youFollow= user!.post_priv!.yourFollower;

    everyOne= user!.post_priv!.everyone;
    noone=user!.post_priv!.noOne;

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
                "Post Setting",
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
                    style: TextStyle(
                        color: blackButtonColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Likes & View",
                              style: TextStyle(
                                  color: blackButtonColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Hide like & views control",
                            style: TextStyle(
                                color: blackButtonColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          SizedBox(
                            width: 140,
                            child: Text(
                              "Manage your likes and view on your post",
                              style: TextStyle(
                                  letterSpacing: .3,
                                  color: signInHeading,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Everyone",
                                style: TextStyle(
                                    color: purpleColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600),
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
                              Text(
                                "0 people",
                                style: TextStyle(
                                    color: purpleColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600),
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
                              style: TextStyle(
                                  letterSpacing: .3,
                                  color: signInHeading,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500),
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
                          value: everyOne!,
                          onToggle: (val) {
                            setState(() {
                              everyOne = val;
                            });
                            privacyController.privacyPostControl(everyOne!, youFollow!, noone!);
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleAndSwitchWidget(
                    title: "People you follow",
                    subTitle: "53 People",
                    isActive: youFollow!,
                    onToggle: (val)
                    {
                      setState(() {
                        youFollow = val;
                      });
                      privacyController.privacyPostControl(everyOne!, youFollow!, noone!);

                    },

                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TitleAndSwitchWidget(
                    title: "No One Except Specific Profiles",
                    subTitle: "",
                    isActive: noone!,
                    onToggle: (val)
                    {
                      setState(() {
                        noone = val;
                      });
                      privacyController.privacyPostControl(everyOne!, youFollow!, noone!);

                    },
                  ),
                ],
              ),
            ),
          
          
          
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                          value: everyOne!,
                          onToggle: (val) {
                            setState(() {
                              everyOne = val;
                            });
                            privacyController.privacyPostControl(everyOne!, youFollow!, noone!);

                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleAndSwitchWidget(
                    title: "People you follow",
                    subTitle: "53 People",
                    isActive: youFollow!,
                    onToggle: (val){

                      setState(() {
                        youFollow = val;
                      });

                      privacyController.privacyPostControl(everyOne!, youFollow!, noone!);
                    },

                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TitleAndSwitchWidget(
                    title: "No One Except Specific Profiles",
                    subTitle: "",
                    isActive: noone!,
                    onToggle: (val){

                      setState(() {
                        noone = val;
                      });

                      privacyController.privacyPostControl(everyOne!, youFollow!, noone!);
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
