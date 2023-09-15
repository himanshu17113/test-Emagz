import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/chat/chat_screen.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/user_online_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chatController.dart';
import '../models/chat_model.dart';

class UserChat extends StatefulWidget {
  final bool? isMessage;
  final UserData? userData;
  final String senderId;
  final String conversationId;
  final ResentMessage? resentMessage;
  const UserChat({
    Key? key,
    required this.senderId,
    required this.conversationId,
    this.userData,
    this.isMessage = false,
    this.resentMessage,
  }) : super(key: key);

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  final jwtController = Get.find<JWTController>();
  final chatController = Get.find<ConversationController>();
//  UserSchema? sender;

//   @override
//   void initState() {
//     super.initState();
//  //   getInitUser();
//   }

  Future getInitUser() async {
    debugPrint("id in list item : ${widget.senderId}");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //   sender = await jwtController.getUserDetail(widget.senderId);
      setState(() {});
    });
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // if (sender == null) {
        if (widget.userData == null) {
          Get.snackbar(
            "Loading",
            "Please wait",
          );
        } else {
          //   List<Message>? messages = [];
          //  messages = await chatController.getMessages(widget.conversationId);
          Get.to(() => ChatScreen(
                user: widget.userData,
                conversationId: widget.conversationId,
                //  messages: messages,
              ));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
        padding: const EdgeInsets.symmetric(vertical: 5),
        height: 70,
        decoration: BoxDecoration(
          color: whiteColor,
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
            const UserOnlineCircle(),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.userData == null
                    ? Text(
                        "loading",
                        style: TextStyle(color: Colors.black.withOpacity(0.25), fontSize: 12, fontWeight: FontWeight.w400),
                      )
                    : Text(
                        "${widget.userData?.username}",
                        style: TextStyle(color: blackButtonColor, fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                const SizedBox(
                  height: 3,
                ),
                widget.resentMessage == null
                    ? Text(
                        "loading",
                        style: TextStyle(color: blackButtonColor, fontSize: 12, fontWeight: FontWeight.w600),
                      )
                    : Text(
                        widget.resentMessage?.text ?? "last text",
                        style: TextStyle(color: blackButtonColor, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
              ],
            ),
            const Spacer(),
            widget.isMessage == true
                ? Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: chipColor,
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "1",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : const Text(
                    "",
                    style: TextStyle(color: Color(0xffA1A1A1), fontSize: 10, fontWeight: FontWeight.w600),
                  ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}
