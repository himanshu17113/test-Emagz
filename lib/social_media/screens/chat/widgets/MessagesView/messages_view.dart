import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:flutter/material.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageView extends StatelessWidget {
  final String? room;
  const MessageView({
    super.key,
    this.room,
  });

  bool isReciver(String messageUserId) => (messageUserId == globUserId);

  @override
  Widget build(BuildContext context) => GetBuilder<SocketController>(
      tag: "notify",
      id: "message",
      init: SocketController(),
      builder: (socketController) => ListView.builder(
            controller: socketController.controller,
            itemCount: socketController.liveMessages.length,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final Message data = socketController.liveMessages[index];
              final bool iscurrent = data.sender == globUserId;
              bool isDayNeeded = true;
              Object dayName =
                  data.createdAt != null ? DateFormat('MMM d, yyyy').format(DateTime.parse(data.createdAt!)) : DateTime.now().day;
              if (index >= 1) {
                DateTime previous =
                    DateTime.parse(socketController.liveMessages[index - 1].createdAt ?? DateTime.now().toString());

                DateTime currentMsg = DateTime.parse(socketController.liveMessages[index].createdAt ?? DateTime.now().toString());

                if (DateUtils.isSameDay(previous, currentMsg)) {
                  isDayNeeded = false;
                }

                if (isDayNeeded == true) {
                  if (DateUtils.isSameDay(currentMsg, DateTime.now())) {
                    dayName = "Today";
                  }
                }
              }

              return Column(
                crossAxisAlignment: iscurrent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (isDayNeeded) ...[
                    Center(
                      child: Text(dayName.toString()),
                    )
                  ],
                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                    child: Container(
                      width: 175,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: const Radius.circular(10),
                            bottomLeft: !iscurrent ? Radius.zero : const Radius.circular(10),
                            bottomRight: iscurrent ? Radius.zero : const Radius.circular(10),
                            topLeft: const Radius.circular(10),
                          ),
                          color: iscurrent ? chipColor : chatContainer),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.text ?? "loading text",
                            style:
                                TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: iscurrent ? whiteAcent : chipColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            data.createdAt == null
                                ? DateFormat.jm().format(DateTime.now())
                                : DateFormat.jm().format(DateTime.parse(data.createdAt!)),
                            style:
                                TextStyle(fontSize: 7, fontWeight: FontWeight.w700, color: iscurrent ? whiteAcent : lightBlack),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ));
}
