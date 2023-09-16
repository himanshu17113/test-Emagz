import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/chat/chat_controller.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/user_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../notification/notification_screen.dart';
import '../settings/personal_page/personal_page_setting.dart';
import 'models/chat_model.dart';
import 'models/reuqest_model.dart';

String url =
    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybHN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60";

class MessageRequestScreen extends StatefulWidget {
  const MessageRequestScreen({Key? key}) : super(key: key);

  @override
  State<MessageRequestScreen> createState() => _MessageRequestScreenState();
}

class _MessageRequestScreenState extends State<MessageRequestScreen> {
  String selectedValue = "Latest Request";
  var convController= Get.put(ConversationController());
  final ScrollController scrollController = ScrollController();

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              margin: const EdgeInsets.only(top: 10, right: 30, left: 20),
              child: Row(
                children: [
                  const Text(
                    "Message Request",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
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
                            Get.to(() => const PersonalPageSetting());
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(url),
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
                width: 150,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: chatContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    value: selectedValue.isNotEmpty ? null : selectedValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: ["Latest Request", "Old request"].map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      );
                    }).toList(),
                    hint: FormHeadingText(
                      headings: "Latest Request",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (val) {
                      // setState(() {
                      //   dropdownvalue = newValue!;
                      // });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child:
                    ListView.builder(
                          scrollDirection: Axis.vertical,
                          controller: scrollController,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: convController.req!.length,
                          itemBuilder: (ctx, index) {
                            if(convController.req![index]==null || convController.req![index]!.sender==null)
                              {
                                return SizedBox();
                              }
                            else {
                              return InkWell(
                                onTap: () {
                                  if (selectedIndex == index) {
                                    setState(() {
                                      selectedIndex = null;
                                    });
                                  } else {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    IgnorePointer(child: UserChat(
                                      userData: UserData(
                                          id: convController.req![index]!.sender!.id,
                                          username: convController.req![index]!
                                              .sender!.username,
                                          email: convController.req![index]!.sender!
                                              .email,
                                          profilePic: convController.req![index]!
                                              .sender!.ProfilePic
                                      ),
                                      resentMessage: ResentMessage(
                                          text: convController.req![index]!.sender!
                                              .displayName
                                      ),
                                      conversationId: "Error message _ request Screen 150",
                                      senderId: "Error message _ request Screen 150",)),
                                    selectedIndex == index
                                        ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  vertical: 10),
                                              decoration: BoxDecoration(
                                                color: const Color(0xff4DD74A)
                                                    .withOpacity(.12),
                                              ),
                                              child: FormHeadingText(
                                                headings: "Accept Request",
                                                color: const Color(0xff4DD74A),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  vertical: 10),
                                              decoration: BoxDecoration(
                                                color: const Color(0xffFE5151)
                                                    .withOpacity(.13),
                                              ),
                                              child: FormHeadingText(
                                                headings: "Reject & Block",
                                                color: const Color(0xffFE5151),
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                        : const SizedBox()
                                  ],
                                ),
                              );
                            }
                          }
                          )
                ),
          ]
              ),
      ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: 8,
              //     itemBuilder: (context, index) {
              //       return InkWell(
              //         onTap: () {
              //           if (selectedIndex == index) {
              //             setState(() {
              //               selectedIndex = null;
              //             });
              //           } else {
              //             setState(() {
              //               selectedIndex = index;
              //             });
              //           }
              //         },
              //         child: Column(
              //           children: [
              //             const IgnorePointer(child: UserChat(
              //               conversationId: "Error message _ request Screen 150",
              //               senderId: "Error message _ request Screen 150",)),
              //             selectedIndex == index
              //                 ? Padding(
              //                     padding: const EdgeInsets.only(
              //                         left: 10, right: 10, bottom: 10),
              //                     child: Row(
              //                       children: [
              //                         Expanded(
              //                           child: Container(
              //                             alignment: Alignment.center,
              //                             padding: const EdgeInsets.symmetric(
              //                                 vertical: 10),
              //                             decoration: BoxDecoration(
              //                               color: const Color(0xff4DD74A)
              //                                   .withOpacity(.12),
              //                             ),
              //                             child: FormHeadingText(
              //                               headings: "Accept Request",
              //                               color: const Color(0xff4DD74A),
              //                               fontSize: 12,
              //                             ),
              //                           ),
              //                         ),
              //                         const SizedBox(
              //                           width: 10,
              //                         ),
              //                         Expanded(
              //                           child: Container(
              //                             alignment: Alignment.center,
              //                             padding: const EdgeInsets.symmetric(
              //                                 vertical: 10),
              //                             decoration: BoxDecoration(
              //                               color: const Color(0xffFE5151)
              //                                   .withOpacity(.13),
              //                             ),
              //                             child: FormHeadingText(
              //                               headings: "Reject & Block",
              //                               color: const Color(0xffFE5151),
              //                               fontSize: 12,
              //                             ),
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   )
              //                 : const SizedBox()
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),

          ),
    );
  }
}
