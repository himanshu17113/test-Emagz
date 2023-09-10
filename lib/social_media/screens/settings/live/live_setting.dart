import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../common/common_appbar.dart';
import '../../../common/title_switch/title_and_switch_widget.dart';
import '../../../controller/privacy/privacy_controller.dart';

class LiveSettingScreen extends StatefulWidget {
  LiveSettingScreen({Key? key}) : super(key: key);

  @override
  State<LiveSettingScreen> createState() => _LiveSettingScreenState();
}

class _LiveSettingScreenState extends State<LiveSettingScreen> {
  bool youFollow = false;

  bool everyOne = true;

  bool yourFollower = false;

  bool followAndFollowerNoone = false;
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
                "Live Setting",
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
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Live",
                    style: TextStyle(
                        color: blackButtonColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hide your stories from",
                    style: TextStyle(
                        color: signInHeading,
                        fontSize: 11,
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
                          padding: 1,
                          height: 20,
                          width: 50,
                          inactiveColor: lightgrayColor,
                          inactiveToggleColor: toggleInactive,
                          value: everyOne,
                          onToggle: (val) {
                            setState(() {
                              everyOne=val;
                            });
                            privacyController.privacyLiveControl(everyOne, yourFollower, followAndFollowerNoone);

                            // setState(() {
                            //   everyOne = val;
                            // });
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Followers",
                        style: TextStyle(
                            color: blackButtonColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      FlutterSwitch(
                          activeColor: whiteAcent,
                          toggleColor: blueColor,
                          padding: 1,
                          height: 20,
                          width: 50,
                          inactiveColor: lightgrayColor,
                          inactiveToggleColor: toggleInactive,
                          value: yourFollower,
                          onToggle: (val) {
                            setState(() {
                              yourFollower=val;
                            });
                            privacyController.privacyLiveControl(everyOne, yourFollower, followAndFollowerNoone);

                            // setState(() {
                            //   everyOne = val;
                            // });
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Noone",
                        style: TextStyle(
                            color: blackButtonColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      FlutterSwitch(
                          activeColor: whiteAcent,
                          toggleColor: blueColor,
                          padding: 1,
                          height: 20,
                          width: 50,
                          inactiveColor: lightgrayColor,
                          inactiveToggleColor: toggleInactive,
                          value: followAndFollowerNoone,
                          onToggle: (val) {
                            setState(() {
                              followAndFollowerNoone=val;
                            });
                            privacyController.privacyLiveControl(everyOne, yourFollower, followAndFollowerNoone);

                            // setState(() {
                            //   everyOne = val;
                            // });
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleAndSwitchWidget(
                    title: "Close Friends",
                    subTitle: "53 People",
                    isActive: youFollow,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Specific Person",
                        style: TextStyle(
                            color: blackButtonColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
