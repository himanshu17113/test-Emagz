 import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/screens/notification/notification_screen.dart';
 import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/user_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

 import '../settings/personal_page/personal_page_setting.dart';
import 'models/chat_model.dart';
 
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
                          Get.to(() =>   NotificationScreen());
                        },
                        child: Image.asset(
                          "assets/png/notification_bell.png",
                          width: 22,
                          color: blackButtonColor,
                        ),
                      ),
                      //     Center(
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
                      if(val=="Old request")
                        {
                          convController.req?.clear();
                          setState(() {
                            convController.getAllRequests('old');
                          });
                        }
                      else
                        {
                          convController.req?.clear();
                          setState(() {
                            convController.getAllRequests('new');
                          });
                        }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(() {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: convController.req!.length,
                    itemBuilder: (ctx, index) {
                      bool x = false;
                      if (convController.req![index] == null ||
                          convController.req![index]!.sender == null) {
                        return const SizedBox();
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
                          child: convController.req![index]!.status == "pending"
                              ? Column(
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
                                senderId: convController.req![index]!.sender!
                                    .id!,)),
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
                                        child: GestureDetector(
                                          onTap: () async
                                          {
                                            await convController.acceptreq(
                                                convController.req![index]!.id!,
                                                index);
                                            setState(() {
                                              selectedIndex = null;
                                            });
                                          },

                                          child: FormHeadingText(
                                            headings: "Accept Request",
                                            color: const Color(0xff4DD74A),
                                            fontSize: 12,
                                          ),
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
                                        child: GestureDetector(
                                          onTap: () async
                                          {
                                            await convController.rejectreq(
                                                convController.req![index]!.id!,
                                                index);
                                            setState(() {
                                              selectedIndex = null;
                                            });
                                          },
                                          child: FormHeadingText(
                                            headings: "Reject & Block",
                                            color: const Color(0xffFE5151),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                                  : const SizedBox()
                            ],
                          )
                              : const SizedBox(),
                        );
                      }
                    }
                );
              }
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
