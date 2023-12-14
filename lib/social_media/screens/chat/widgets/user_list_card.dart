import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/screens/chat/chat_screen.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/user_online_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user_schema.dart';
import '../models/chat_model.dart';

class UserChat extends StatelessWidget {
  final bool? isMessage;
  final UserData? userData;
  final String senderId;
  final String conversationId;
  final ResentMessage? resentMessage;
    UserChat({
    Key? key,
    required this.senderId,
    required this.conversationId,
    this.userData,
    this.isMessage = false,
    this.resentMessage,
  }) : super(key: key);

   UserSchema? sender;

//   @override
  Future getInitUser() async {
    // debugPrint("id in list item : ${widget.senderId}");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     sender = await HiveDB.getUserDetail(senderId);
   //   setState(() {});
    });
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // if (sender == null) {
        if (userData == null) {
          Get.snackbar(
            "Loading",
            "Please wait",
          );
        } else {
          //   List<Message>? messages = [];
          //  messages = await chatController.getMessages(widget.conversationId);
          Get.to(
              () => ChatScreen(
                    user: userData,
                    conversationId: conversationId,
                    //  messages: messages,
                  ),
           //   duration: const Duration(seconds: 0)
              );
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
            UserOnlineCircle(url: userData!.profilePic),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                userData == null
                    ? Text(
                        "loading",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.25),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      )
                    : Text(
                        "${userData?.username}",
                        style: const TextStyle(
                            color: blackButtonColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                const SizedBox(
                  height: 3,
                ),
                resentMessage == null
                    ? const Text(
                        "loading",
                        style: TextStyle(
                            color: blackButtonColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      )
                    : Text(
                        resentMessage?.text ?? "last text",
                        style: const TextStyle(
                            color: blackButtonColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
              ],
            ),
            const Spacer(),
            isMessage == true
                ? Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
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
                    style: TextStyle(
                        color: Color(0xffA1A1A1),
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
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
