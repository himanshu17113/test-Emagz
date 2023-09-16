import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/MessagesView/messages_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../notification/notification_screen.dart';
import 'chat_list_screen.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final user;
  //final List<Message>? messages;
  const ChatScreen({
    Key? key,
    required this.user,
    required this.conversationId,
    //  this.messages
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = Get.find<ConversationController>();
  final jwtController = Get.find<JWTController>();
  final socketController = Get.find<SocketController>();
  //  final socketController = Get.find<SocketController>();
  String? userId;

//  List<Message>? messages = [];
  @override
  void initState() {
    initAsync();
    socketController.connectToServer(widget.conversationId);
    super.initState();
  }

  TextEditingController inputTextController = TextEditingController();

  void initAsync() async {
    userId = jwtController.userId;
    if (userId == null) {
      userId = chatController.userId;
      if (userId == null) {
        userId = await jwtController.getUserId();
      }
    }
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
                const Expanded(
                  child: Row(
                    children: [
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
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 5),
                      child: InkWell(
                        onTap: () {},
                        child: CachedNetworkImage(
                          imageUrl: url,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        //  Container(
                        //     height: 30,
                        //     width: 30,
                        //     decoration: BoxDecoration(
                        //         image: DecorationImage(image: CachedNetworkImageProvider(url), fit: BoxFit.cover),
                        //         borderRadius: BorderRadius.circular(5)),
                        //   )
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
                    backgroundImage: CachedNetworkImageProvider(url),
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
                        "${widget.user?.username}",
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
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Expanded(
                        child: MessageView(
                            room: widget.conversationId,
                            // messages: widget.messages ?? [],
                            senderId: userId!)),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xffE8E7E7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            alignment: Alignment.center,
                            width: 55,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if (inputTextController.text.isNotEmpty) {
                                  final receiverId = widget.user!.id;
                                  socketController.sendMessage(inputTextController.text, widget.conversationId, receiverId!);
                                  //    chatController.postChat(inputTextController.text, widget.conversationId);
                                  inputTextController.clear();
                                }
                              },
                              child: CircleAvatar(
                                  radius: 16,
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
