import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:flutter/material.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:get/get.dart';
class MessageView extends StatefulWidget {
  final List<Message> messages;
  final String senderId;
  const MessageView({super.key,required this.messages,required this.senderId});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {

  String? userId;

  bool isReciver(String messageUserId) => !(messageUserId == widget.senderId);

  var socketController = Get.put(SocketController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      initialData: widget.messages,
      stream: socketController.messagesStreamController.stream,
      builder: (context, snapshot) => ListView.builder(
        // controller: socketController.scrollController,
        itemCount:
          // widget.messages.length
          //     +
              (snapshot.data?.length ?? -1),
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          print(snapshot.data![0].sender!);
          // print(snapshot.data![index % 2].sender!);
          return Container(
            padding: const EdgeInsets.only(
                left: 14, right: 14, top: 10, bottom: 10),
            child: isReciver(snapshot.data![index].sender!)
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
                    color: (isReciver(snapshot.data![index].sender!)
                        ? const Color(0xffAFB6FD)
                        .withOpacity(.5)
                        : chipColor),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 8),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data?[index].text ?? "loading text",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: (isReciver(snapshot.data![index].sender!)
                              ? blackButtonColor
                              : chipColor),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "10:00 AM",
                        style: TextStyle(
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
                    color: (isReciver(snapshot.data![index].sender!)
                        ? chatContainer
                        : chipColor),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 8),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data![index].text!,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: (isReciver(snapshot.data![index].sender!)
                              ? blackButtonColor
                              : whiteColor),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "10:00 AM",
                        style: TextStyle(
                            fontSize: 7,
                            fontWeight: FontWeight.w700,
                            color: whiteColor
                                .withOpacity(.5)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
