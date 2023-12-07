import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:flutter/material.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:intl/intl.dart';

class MessageView extends StatefulWidget {
  final String? senderId;
  final String? room;
  const MessageView({
    super.key,
    this.senderId,
    this.room,
  });

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  bool isReciver(String messageUserId) => !(messageUserId == widget.senderId);
  final socketController = Get.find<SocketController>();
  @override
  initState() {
    socketController.connectToServer(widget.room!);
    debugPrint(
        " ------------------------------------------------------------------------------------------------------------");
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("disconnect To Server initiated");
    socketController.disconnectToServer(widget.room!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: socketController.liveMessages.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          // debugPrint(snapshot.data![index % 2].sender!);
          final Message data = socketController.liveMessages[index];

          bool isDayNeeded=true;
          Object dayName=data.createdAt!=null?
          DateFormat('MMM d, yyyy').format(DateTime.parse(data.createdAt!)):DateTime.now().day;
          if(index>=1)
            {
              DateTime previous= DateTime.parse(
                  socketController.liveMessages[index - 1].createdAt??DateTime.now().toString());

              DateTime currentMsg= DateTime.parse(
                  socketController.liveMessages[index].createdAt??DateTime.now().toString());

              if(DateUtils.isSameDay(previous, currentMsg))
                {
                  isDayNeeded=false;
                }

              if(isDayNeeded==true)
                {

                  if(DateUtils.isSameDay(currentMsg, DateTime.now()))
                  {
                      dayName="Today";
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
                child: // socketController.isUserSender!.value
                    isReciver(data.sender?? 'f')
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
                                    color:
                                        const Color(0xffAFB6FD).withOpacity(.5)
                                    // (socketController.isUserSender!.value
                                    //     ? const Color(0xffAFB6FD).withOpacity(.5)
                                    //     : chipColor),
                                    ),
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
                                        color: (
                                            //socketController.isUserSender!.value
                                            isReciver(data.sender??widget.senderId??'f')
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
                                      //DateTime dt = DateTime.parse('2020-01-02 03:04:05');
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
      );
    });
  }
}
