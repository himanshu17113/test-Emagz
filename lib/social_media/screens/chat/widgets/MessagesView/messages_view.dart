import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:flutter/material.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageView extends StatelessWidget {
//  final String? senderId;
  final String? room;
  const MessageView({
    super.key,
    //   this.senderId,
    this.room,
  });

  bool isReciver(String messageUserId) => !(messageUserId == globUserId);

  // final socketController = Get.find<SocketController>(
  //   tag: "notify",
  // );

  @override
  Widget build(BuildContext context) => GetBuilder<SocketController>(
      tag: "notify",
      id: "message",
      init: SocketController(),
      // initState:(socketController)=>    socketController.initState()
      // .controller?.connectToServer (room!),
      //  dispose: (state) =>    socketController.disconnectToServer(room!)

      builder: (socketController) => ListView.builder(
            itemCount: socketController.liveMessages.length,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final Message data = socketController.liveMessages[index];

              bool isDayNeeded = true;
              Object dayName = data.createdAt != null
                  ? DateFormat('MMM d, yyyy')
                      .format(DateTime.parse(data.createdAt!))
                  : DateTime.now().day;
              if (index >= 1) {
                DateTime previous = DateTime.parse(
                    socketController.liveMessages[index - 1].createdAt ??
                        DateTime.now().toString());

                DateTime currentMsg = DateTime.parse(
                    socketController.liveMessages[index].createdAt ??
                        DateTime.now().toString());

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
                children: [
                  isDayNeeded
                      ? Center(
                          child: Text(dayName.toString()),
                        )
                      : const SizedBox.shrink(),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: isReciver(data.sender ?? 'f')
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 175,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                    color: const Color(0xffAFB6FD)
                                        .withOpacity(.5)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.text ?? "loading text",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: (socketController
                                                .isUserSender!.value
                                            ? blackButtonColor
                                            : chipColor),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data.createdAt == null
                                          ? DateFormat.jm()
                                              .format(DateTime.now())
                                          : DateFormat.jm().format(
                                              DateTime.parse(data.createdAt!)),
                                      style: const TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.w700,
                                          color: lightBlack),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 175,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                  color: (socketController.isUserSender!.value
                                      ? chatContainer
                                      : chipColor),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.text!,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: (isReciver(data.sender ??
                                                globUserId ??
                                                'f')
                                            ? blackButtonColor
                                            : whiteColor),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data.createdAt == null
                                          ? DateFormat.jm()
                                              .format(DateTime.now())
                                          : DateFormat.jm().format(
                                              DateTime.parse(data.createdAt!)),
                                      style: TextStyle(
                                          fontSize: 7,
                                          fontWeight: FontWeight.w700,
                                          color: whiteColor.withOpacity(.5)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              );
            },
          ));
}
