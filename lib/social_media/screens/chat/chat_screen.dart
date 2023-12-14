import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/screens/notification/notification_screen.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/MessagesView/messages_view.dart';
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
    socketController.liveMessages.clear();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            margin: const EdgeInsets.only(top: 10, right: 30, left: 30),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Chat",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => const NotificationScreen()),
                      child: GetBuilder<SocketController>(
                        init: SocketController(),
                        tag: "notify",
                        id: "dot",
                        builder: (socketController) =>
                            Stack(alignment: Alignment.topRight, children: [
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
                                      socketController.notifications.length
                                          .toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ))
                                : const SizedBox.shrink(),
                          )
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 5),
                      child: InkWell(
                        onTap: () {},
                        child: CachedNetworkImage(
                          imageUrl: constuser?.ProfilePic ?? url,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
              padding: const EdgeInsets.symmetric(vertical: 3),
              height: 68,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffAFB6FD),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(user?.profilePic ?? url),
                    maxRadius: 20,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${user?.username}",
                        style: const TextStyle(
                            color: blackButtonColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                      const Text(
                        "Online",
                        style: TextStyle(
                            color: chatOnlineDot,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
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
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                    padding: const EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    width: 120.0,
                                    height: 42.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200
                                            .withOpacity(0.5)),
                                    child: Text('Report User',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    const Color(0xff323232))))),
                          ),
                        ),
                        PopupMenuItem(
                          value: '/hello',
                          child: ClipRRect(
                            child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                    padding: const EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    width: 120.0,
                                    height: 42.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200
                                            .withOpacity(0.5)),
                                    child: Text('Block User',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    const Color(0xff323232))))),
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
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Expanded(
                        child: MessageView(
                      room: conversationId,
                    )),
                    TextField(
                      cursorColor: grayColor,
                      controller: inputTextController,
                      maxLines: 10,
                      minLines: 1,
                      decoration: InputDecoration(
                          fillColor: const Color(0xffE8E7E7),
                          filled: true,
                          prefixIconConstraints:
                              const BoxConstraints.tightFor(width: 50),
                          prefixIcon: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 2,
                              ),
                              Icon(
                                Icons.emoji_emotions_outlined,
                                size: 22,
                                color: Color(
                                  0xff909090,
                                ),
                              ),
                              Icon(
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
                                socketController.sendMessage(
                                    inputTextController.text,
                                    conversationId,
                                    receiverId!);

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
                          suffixIconConstraints:
                              const BoxConstraints.tightFor(width: 45),
                          isDense: true,
                          hintText: "Type something ",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 2, top: 12, bottom: 12),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.circular(15))),
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
