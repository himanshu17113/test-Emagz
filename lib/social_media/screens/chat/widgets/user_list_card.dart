import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/user_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/chat_screen.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/user_online_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserChat extends StatefulWidget {
  bool? isMessage;
  late String senderId;
  late String conversationId;
  UserChat({
    Key? key,
    required this.senderId,
    required this.conversationId,
    this.isMessage = false,
  }) : super(key: key);


  @override
  State<UserChat> createState() => _UserChatState();
}


class _UserChatState extends State<UserChat> {

  var jwtController = Get.put(JWTController());
  User? sender;

  @override
  void initState() {
    super.initState();
    getInitUser();
  }
  Future getInitUser()async{
    print("id in list item : ${widget.senderId}");
    sender = await jwtController.getUserDetail(widget.senderId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        (sender==null) ?Get.snackbar(
          "Loading", "Please wait",) :  Get.to(() => ChatScreen(
          user: sender!,
            conversationId: widget.conversationId
        ));
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
                sender==null ?Text(
                  "loading",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.25),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ) : Text(
                  "${sender?.username}",
                  style: TextStyle(
                      color: blackButtonColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 3,
                ),
                sender == null ? Text(
                  "loading",
                  style: TextStyle(
                      color: blackButtonColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ) : Text(
                  "last text",
                  style: TextStyle(
                      color: blackButtonColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ) ,
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