import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/screens/notification/notification_screen.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/MessagesView/messages_view.dart';
import 'package:emagz_vendor/templates/choose_template/webview.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_list_screen.dart';
import 'models/chat_model.dart';

class ChatScreen extends StatelessWidget {
  final String conversationId;
  final UserData? user;

  ChatScreen({
    Key? key,
    required this.user,
    required this.conversationId,
  }) : super(key: key);
  final socketController = Get.find<SocketController>(tag: "notify");
  final TextEditingController inputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     socketController.connectToServer(conversationId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  const Text(
                    "Chat",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.to(() => const NotificationScreen()),
                    child: GetBuilder<SocketController>(
                      init: SocketController(),
                      tag: "notify",
                      id: "dot",
                      builder: (socketController) => Stack(alignment: Alignment.topRight, children: [
                        Image.asset(
                          "assets/png/notification_bell.png",
                          height: 28,
                          width: 28,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: socketController.notifications.isNotEmpty
                              ? CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    socketController.notifications.length.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ))
                              : const SizedBox.shrink(),
                        )
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              padding: const EdgeInsets.symmetric(vertical: 5),
              //   height: 68,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffAFB6FD),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(user?.profilePic ?? url),
                      maxRadius: 20,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${user?.username}",
                        style: const TextStyle(color: blackButtonColor, fontSize: 22, fontWeight: FontWeight.w400),
                      ),
                      const Text(
                        "Onlin",
                        style: TextStyle(color: chatOnlineDot, fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    padding: EdgeInsets.zero,
                    elevation: 0.0,
                    color: Colors.transparent,
                    position: PopupMenuPosition.under,
                    onSelected: (value) {},
                    child: const Icon(Icons.more_vert),
                    itemBuilder: (BuildContext bc) {
                      return [
                        const PopupMenuItem(
                          child: null,
                        ),
                        PopupMenuItem(
                          value: '/hello',
                          child: ClipRRect(
                            child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                    padding: const EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    width: 120.0,
                                    height: 42.0,
                                    decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
                                    child: Text('Report User',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: const Color(0xff323232))))),
                          ),
                        ),
                        PopupMenuItem(
                          value: '/hello',
                          child: ClipRRect(
                            child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                    padding: const EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    width: 120.0,
                                    height: 42.0,
                                    decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
                                    child: Text('Block User',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: const Color(0xff323232))))),
                          ),
                        ),
                      ];
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //  AppBar(
      //   title: const Text(
      //     "Chat",
      //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      //   ),
      //   actions: [
      //     GestureDetector(
      //       onTap: () => Get.to(() => const NotificationScreen()),
      //       child: GetBuilder<SocketController>(
      //         init: SocketController(),
      //         tag: "notify",
      //         id: "dot",
      //         builder: (socketController) =>
      //             Stack(alignment: Alignment.topRight, children: [
      //           Image.asset(
      //             "assets/png/notification_bell.png",
      //             height: 28,
      //             width: 28,
      //           ),
      //           Positioned(
      //             top: 0,
      //             right: 0,
      //             child: socketController.notifications.isNotEmpty
      //                 ? CircleAvatar(
      //                     radius: 8,
      //                     backgroundColor: Colors.red,
      //                     child: Text(
      //                       socketController.notifications.length.toString(),
      //                       style: const TextStyle(fontSize: 12),
      //                     ))
      //                 : const SizedBox.shrink(),
      //           )
      //         ]),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 10),
      //       child: GestureDetector(
      //         onTap: () {
      //           Get.to(() => const OwnWebView());
      //         },
      //         child: CircleAvatar(
      //           backgroundImage: CachedNetworkImageProvider(
      //             constuser?.ProfilePic.toString() ?? "",
      //           ),
      //           maxRadius: 15,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
                child: MessageView(
              room: conversationId,
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextField(
                focusNode: socketController.focusNode,
                cursorColor: grayColor,
                controller: inputTextController,
                maxLines: 10,
                minLines: 1,
                decoration: InputDecoration(
                    fillColor: const Color(0xffE8E7E7),
                    filled: true,
                    prefixIconConstraints: const BoxConstraints.tightFor(width: 50),
                    prefixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 2,
                        ),
                        GestureDetector(
                          onTap: () => socketController.emoji(),
                          child: const Icon(
                            Icons.emoji_emotions_outlined,
                            size: 22,
                            color: Color(
                              0xff909090,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.attach_file,
                          size: 20,
                          color: Color(
                            0xff909090,
                          ),
                        ),
                      ],
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        if (inputTextController.text.isNotEmpty) {
                          final receiverId = user!.id;
                          socketController.sendMessage(inputTextController.text, conversationId, receiverId!);

                          inputTextController.clear();
                        }
                      },
                      child: CircleAvatar(
                          radius: 16,
                          backgroundColor: const Color(0xFF4F1AC1),
                          child: Image.asset(
                            "assets/png/send_msg_icon.png",
                            width: 12,
                          )),
                    ),
                    suffixIconConstraints: const BoxConstraints.tightFor(width: 45),
                    isDense: true,
                    hintText: "Type something ",
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.only(left: 2, top: 12, bottom: 12),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.circular(15))),
                textAlignVertical: TextAlignVertical.top,
                textAlign: TextAlign.start,
              ),
            ),
            Obx(() => SizedBox(
                  child: socketController.showEmojiBoard.value ? emojiPicker() : null,
                ))
          ],
        ),
      ),
    );
  }

  Widget emojiPicker() {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        textEditingController: inputTextController,
        //  onEmojiSelected: (emoji, category) {
        //   setState(() {
        //     _textEditingController.text += emoji.emoji;
        //   });
        // },
      ),
    );
  }
 
}
