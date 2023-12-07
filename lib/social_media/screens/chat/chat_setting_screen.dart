import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/screens/notification/notification_screen.dart';
import 'package:emagz_vendor/social_media/controller/privacy/privacy_controller.dart';
import 'package:emagz_vendor/social_media/models/user_schema.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
 
import 'package:emagz_vendor/social_media/screens/chat/message_request_screen.dart';
 
import 'package:flutter/material.dart';
 
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../common/title_switch/title_and_switch_widget.dart';
import '../../controller/auth/jwtcontroller.dart';
import '../../models/post_model.dart';
 
String url =
    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybHN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60";

class ChatSettingScreen extends StatefulWidget {
  const ChatSettingScreen({Key? key}) : super(key: key);

  @override
  State<ChatSettingScreen> createState() => _ChatSettingScreenState();
}

class _ChatSettingScreenState extends State<ChatSettingScreen> {
  String selectedValue = "Latest Request";
  int? selectedIndex;
  bool showBox=false;
  bool showSearch=false;

  //var jwtController= JWTController() ;
  var chatController= Get.put(ConversationController());
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

   // user = await jwtController.getCurrentUserDetail();
    youFollow= user!.mess_priv!.yourFollower;

    everyOne= user!.mess_priv!.everyone;
    noone=user!.mess_priv!.noOne;

    setState(() {});
  }
  final privacyController= Get.put(PrivacyController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              margin: const EdgeInsets.only(top: 10, right: 30, left: 30),
              child: Row(
                children: [
                  const Expanded(
                    child: Row(
                      children: [
                        Text(
                          "Chat Setting",
                          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() =>   NotificationScreen());
                        },
                        child: Image.asset(
                          "assets/png/notification_bell.png",
                          width: 22,
                          // color: blackButtonColor,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      InkWell(
                          onTap: () {
                            // Get.to(() => const PersonalPageSetting());
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: CachedNetworkImageProvider(url), fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(5)),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const MessageRequestScreen());
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: chatContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FormHeadingText(
                                headings: "Message Request",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              FormHeadingText(
                                headings: "See who all sent you a request",
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: lightBlack,
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xff3A0DBB)),
                            child: FormHeadingText(
                              headings: "${chatController.req!.length}",
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: FormHeadingText(
                    headings: "Chat Setting",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(18),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: chatContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Control",
                        style: TextStyle(color: toggleInactive, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Allow Message from",
                            style: TextStyle(color: blackButtonColor, fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                onTap:()
                                {
                                  setState(() {
                                    showBox=!showBox;
                                    showSearch=false;
                                  });
                                },
                                child: Text(
                                  "Everyone",
                                  style: TextStyle(color: purpleColor, fontSize: 11, fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(

                                child: Text(
                                  "Block comment from",
                                  style: TextStyle(color: blackButtonColor, fontSize: 11, fontWeight: FontWeight.w600),
                                ),
                                onTap: ()
                                {
                                  setState(() {
                                    showSearch=!showSearch;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const SizedBox(
                                width: 140,
                                child: Text(
                                  "Any message from people you block will not be visible to anyone but them",
                                  style: TextStyle(letterSpacing: .3, color: signInHeading, fontSize: 7, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                "0 people",
                                style: TextStyle(color: purpleColor, fontSize: 11, fontWeight: FontWeight.w600),
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
                      const SizedBox(
                        height: 20,
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
                        "Allow Message Request from",
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
                              value: everyOne?? true,
                              onToggle: (val) {
                                setState(() {
                                  everyOne = val;
                                });
                                privacyController.privacyMessageControl(everyOne!, youFollow!, noone!);
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TitleAndSwitchWidget(
                        title: "People you follow",
                        subTitle: "53 People",
                        isActive: youFollow??false,
                        onToggle: (val)
                        {
                          setState(() {
                            youFollow = val;
                          });
                          privacyController.privacyMessageControl(everyOne!, youFollow!, noone!);

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
                          privacyController.privacyMessageControl(everyOne!, youFollow!, noone!);

                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(18),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: chatContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Block Message from",
                        style: TextStyle(color: toggleInactive, fontSize: 8, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffE6E6E6),
                            border: Border.all(
                              color: const Color(0xffE7E9FE),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        height: 28,
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              isDense: true,
                              hintText: "Search",
                              hintStyle: TextStyle(fontSize: 9, color: lightBlack),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
