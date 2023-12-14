import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/screens/notification/notification_screen.dart';
import 'package:emagz_vendor/social_media/controller/bottom_nav_controller.dart';
import 'package:emagz_vendor/social_media/screens/chat/chat_setting_screen.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/chat_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/UserChats/user_chats.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/user_online_circle.dart';
import 'package:emagz_vendor/templates/choose_template/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

String url =
    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybHN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60";

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

// final TextEditingController queryControl = TextEditingController();

  // final chatController = Get.put(ConversationController());

  // final nav = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    bool isSearch = false;

    String searchQuery = 'XXXXXXX';
    return Scaffold(
        backgroundColor: const Color(0xffE7E9FE),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 45,
                right: 30,
                left: 30,
              ),
              child: Row(
                children: [
                  const Text(
                    "Chat",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(() => const NotificationScreen());
                    },
                    child: Image.asset(
                      "assets/png/notification_bell.png",
                      width: 22,
                      color: blackButtonColor,
                    ),
                  ),

                  // Center(
                  //   child: GestureDetector(
                  //     onTap: () => Get.to(() => NotificationScreen()),
                  //     child:
                  //         Stack(alignment: Alignment.topRight, children: [
                  //       Image.asset(
                  //         "assets/png/notification_bell.png",
                  //         height: 28,
                  //         width: 28,
                  //       ),
                  //       if (socketController.notifications.isNotEmpty)
                  //         Positioned(
                  //           top: 0,
                  //           right: 0,
                  //           child: CircleAvatar(
                  //             radius: 8,
                  //             backgroundColor: Colors.red,
                  //             child: Obx(() => Text(
                  //                   socketController.notifications.length
                  //                       .toString(),
                  //                   style: const TextStyle(fontSize: 12),
                  //                 )),
                  //           ),
                  //         )
                  //     ]),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const OwnWebView());
                      },
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          constuser?.ProfilePic.toString() ?? "",
                        ),
                        maxRadius: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        body: Stack(alignment: Alignment.topCenter, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: SizedBox(
                  height: 50,
                  width: 5000,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(

                            //   controller: queryControl,
                            onSubmitted: (value) {
                              // setState(() {
                              //   isSearch = true;
                              //   searchQuery = queryControl.text;
                              // });
                            },
                            onTapOutside: (p) {
                              // setState(() {
                              //   isSearch = false;
                              // });
                            },
                            showCursor: false,
                            decoration: InputDecoration(
                                fillColor: const Color(0xffF0F0F0),
                                filled: true,
                                hintText: "Search",
                                hintStyle: const TextStyle(fontSize: 13, color: blackButtonColor),
                                contentPadding: const EdgeInsets.only(left: 10, top: 5),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)))),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const ChatSettingScreen());
                        },
                        child: Container(
                            margin: const EdgeInsets.only(left: 10),
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
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15, bottom: 5),
                child: Text(
                  "Online",
                  style: TextStyle(color: blackButtonColor, fontSize: 15.5, fontWeight: FontWeight.w600),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Row(
                  children: [
                    UserOnlineCircle(),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                height: 37,
                color: const Color(0xffF0F0F0),
                child: const FormHeadingText(
                  headings: "DIRECT MESSAGE",
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              //  (isSearch)
              //         ? UserChatsWithSearch(
              //             userId: userId!,
              //             senderName: searchQuery,
              //           )
              //         :

              const UserChats(),
            ],
          ),
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              //  nav.page.value = 0;
            },
            child: const ColoredBox(
              color: Colors.transparent,
              child: SizedBox(
                height: double.maxFinite,
                width: 60,
              ),
            ),
          ),
        ]));
  }
}
