import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/user_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/MessagesView/messages_view.dart';
import 'package:flutter/material.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:get/get.dart';
import '../notification/notification_screen.dart';
import 'chat_list_screen.dart';

class ChatScreen extends StatefulWidget {
  late String conversationId;
  late User user;
  ChatScreen({Key? key, required this.user, required this.conversationId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var chatController = Get.put(ConversationController());
  var jwtController = Get.put(JWTController());
  var socketController = Get.put(SocketController());
  String? userId;

  List<Message>? messages;
  @override
  void initState() {
    initAsync();
    super.initState();
  }

  TextEditingController inputTextController = TextEditingController();

  void initAsync() async {
    userId = await jwtController.getUserId();
    messages = await chatController.getMessages(widget.conversationId);
    // print(messages);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            margin: const EdgeInsets.only(top: 10, right: 30, left: 30),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: const [
                      Text(
                        "Chat",
                        style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
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
                // color: whiteColor,
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
                    backgroundImage: NetworkImage(url),
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
                        "${widget.user.username}",
                        style: TextStyle(color: blackButtonColor, fontSize: 22, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Online",
                        style: TextStyle(color: chatOnlineDot, fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    // offset: Offset(60, 0),
                    padding: EdgeInsets.zero,
                    elevation: 0.0,
                    color: Colors.transparent,
                    position: PopupMenuPosition.under,
                    onSelected: (value) {
                      // your logic
                    },
                    child: const Icon(Icons.more_vert),
                    itemBuilder: (BuildContext bc) {
                      return [
                        const PopupMenuItem(
                          child: null,
                        ),
                        PopupMenuItem(
                          // padding: EdgeInsets.only(left: 50),
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
                                            .copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff323232))))),
                          ),
                        ),
                        PopupMenuItem(
                          // padding: EdgeInsets.only(left: 50),
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
                                            .copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff323232))))),
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
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20), color: whiteColor),
                child: Column(
                  children: [
                    Expanded(
                        child: (messages == null)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : MessageView(messages: [], senderId: userId!)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E7E7),
                        borderRadius: BorderRadius.circular(10),
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: Colors.black.withOpacity(.1),
                        //       blurRadius: 3,
                        //       spreadRadius: 2)
                        // ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            alignment: Alignment.center,
                            width: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Color(
                                    0xff909090,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.attach_file,
                                  color: Color(
                                    0xff909090,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              cursorColor: grayColor,
                              controller: inputTextController,
                              decoration: const InputDecoration(
                                  isDense: true,
                                  // filled: true,
                                  hintText: "Type something ",
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(
                                      0xff909090,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 2),
                                  border: InputBorder.none),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(5.0),
                          //   child: CircleAvatar(
                          //     radius: 15,
                          //     backgroundColor: chipColor,
                          //     child: Transform.rotate(
                          //       angle: -45,
                          //       child: Icon(
                          //         Icons.send,
                          //         size: 10,
                          //         color: whiteColor,
                          //       ),
                          //     ),
                          //   ),
                          // )
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                var receiverId = widget.user.sId;
                                socketController.sendMessage(receiverId!, inputTextController.text);
                                chatController.postChat(inputTextController.text, widget.conversationId);
                                inputTextController.clear();
                              },
                              child: CircleAvatar(
                                  radius: 16,
                                  // backgroundColor: chipColor,
                                  backgroundImage: const AssetImage(
                                    "assets/png/send_msg_bg.png",
                                  ),
                                  child: Image.asset(
                                    "assets/png/send_msg_icon.png",
                                    width: 12,
                                  )),
                            ),
                          )
                        ],
                      ),
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

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

List<ChatMessage> messages = [
  ChatMessage(messageContent: "Hey, How are you making the post", messageType: "sender"),
  ChatMessage(messageContent: "Hey, Yea by giving the issue", messageType: "receiver"),
  ChatMessage(messageContent: "Oh Great, Thanks For Teaching", messageType: "sender"),
];
