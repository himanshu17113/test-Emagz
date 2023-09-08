import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/chat/chat_setting_screen.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/UserChats/user_chats.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/user_online_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../notification/notification_screen.dart';

String url =
    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybHN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60";

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  String? userId;
  bool isSearch = false;
  String searchQuery = 'XXXXXXX';
  TextEditingController QueryControl = TextEditingController();
  @override
  void initState() {
    asyncInit();
    super.initState();
  }

  asyncInit() async {
    userId = await Get.put(JWTController()).getUserId();
    debugPrint(userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE7E9FE),
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
                          "Chat",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => const SocialNotificationScreen());
                        },
                        child: Image.asset(
                          "assets/png/notification_bell.png",
                          width: 22,
                          color: blackButtonColor,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      InkWell(
                          onTap: () {
                            debugPrint("Profile ICon");
                            // Get.to(() => const PersonalPageSetting());
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(url),
                                    fit: BoxFit.cover),
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      // margin: EdgeInsets.symmetric(),
                      height: 42,
                      decoration: BoxDecoration(
                          color: const Color(0xffF0F0F0),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: QueryControl,
                        onSubmitted: (value) {
                          debugPrint('uefibdjv');

                          setState(() {
                            isSearch = true;
                            searchQuery = QueryControl.text;
                          });
                        },
                        onTapOutside: (p)
                        {
                          setState(() {
                            isSearch=false;
                          });
                        },
                        showCursor: false,
                        decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                                fontSize: 13, color: blackButtonColor),
                            contentPadding:
                                const EdgeInsets.only(left: 10, top: 5),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 20,
                            ),
                            border: InputBorder.none),
                      ),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const ChatSettingScreen());
                      },
                      child: Container(
                          padding: const EdgeInsets.all(12),
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xffF0F0F0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            "assets/svg/setting.svg",
                            // width: 20,
                            // height: 10,
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Online",
                  style: TextStyle(
                      color: blackButtonColor,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: const Row(
                  children: [
                    UserOnlineCircle(),
                    SizedBox(
                      width: 10,
                    ),
                    // UserOnlineCircle(),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // UserOnlineCircle(),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // UserOnlineCircle(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                height: 37,
                // width: 45,
                decoration: BoxDecoration(
                  color: const Color(0xffF0F0F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FormHeadingText(
                  headings: "DIRECT MESSAGE",
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              (userId == null)
                  ? const CircularProgressIndicator()
                  : (isSearch)
                      ? UserChatsWithSearch(
                          userId: userId!,
                          senderName: searchQuery,
                        )
                      : UserChats(
                          userId: userId!,
                        )
            ],
          ),
        ),
      ),
    );
  }
}
