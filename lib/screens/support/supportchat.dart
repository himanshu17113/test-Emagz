import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/MessagesView/messages_view.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../social_media/common/common_appbar.dart';

class SupportChat extends StatelessWidget {
  final String conversationId;
  final String userId;
  SupportChat({
    Key? key,
    required this.conversationId,
    required this.userId,
  }) : super(key: key);
  final socketController = Get.find<SocketController>(tag: "notify");
  final TextEditingController inputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    socketController.connectToServer(conversationId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SocialMediaSettingAppBar(
        title: 'Support Chat',
      ),
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
                cursorColor: grayColor,
                controller: inputTextController,
                maxLines: 10,
                minLines: 1,
                decoration: InputDecoration(
                    fillColor: const Color(0xffE8E7E7),
                    filled: true,
                    prefixIconConstraints: const BoxConstraints.tightFor(width: 50),
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
                          socketController.sendMessage(inputTextController.text, conversationId, userId);

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
          ],
        ),
      ),
    );
  }
}
