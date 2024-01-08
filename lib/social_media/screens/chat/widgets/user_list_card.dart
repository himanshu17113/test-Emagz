import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/socketController.dart';
import '../models/chat_model.dart';

class UserChat extends StatelessWidget {
  final bool? isMessage;
  final UserData? userData;
  // final String senderId;
  final String conversationId;
  final ResentMessage? resentMessage;
  const UserChat({
    Key? key,
    //  required this.senderId,
    required this.conversationId,
    this.userData,
    this.isMessage = false,
    this.resentMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (userData != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  user: userData,
                  conversationId: conversationId,
                  //  messages: messages,
                ),
              ));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userData?.profilePic ??
                      'https://media.istockphoto.com/photos/smiling-indian-business-man-working-on-laptop-at-home-office-young-picture-id1307615661?b=1&k=20&m=1307615661&s=170667a&w=0&h=Zp9_27RVS_UdlIm2k8sa8PuutX9K3HTs8xdK0UfKmYk='),
                  maxRadius: 25,
                ),
                GetBuilder<SocketController>(
                  init: SocketController(),
                  tag: "notify",
   id: 'active',
                  //   initState: (_) {},
                  builder: (s) => s.onLineUserIds.contains(userData?.id)
                      ? const Positioned(
                          top: 36,
                          right: 2,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: whiteColor,
                            child: CircleAvatar(
                              radius: 6,
                              backgroundColor: chatOnlineDot,
                            ),
                          ))
                      : const SizedBox.shrink(),
                )
              ],
            ),
            const SizedBox(width: 10),
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
                        " ",
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
                ? const CircleAvatar(
                    radius: 20,
                    backgroundColor: chipColor,
                    child: Text(
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
