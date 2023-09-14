import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:flutter/material.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:intl/intl.dart';

class MessageView extends StatefulWidget {
  // final List<Message> messages;
  final String? senderId;
  final String? room;
  const MessageView(
      {super.key,
      // required this.messages,
      this.senderId,
      this.room});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  //String? userId;

  bool isReciver(String messageUserId) => !(messageUserId == widget.senderId);

  final socketController = Get.find<SocketController>();
  List<Message> liveMessages = [];
  @override
  initState() {
    //  liveMessages = widget.messages;
    debugPrint(
        "----------------------------------------------------------------------------------------------------------------------------------------------------");

    //  debugPrint(widget.messages);
    super.initState();
  }

  // void connectToServer(String room) {
  //   IO.Socket socket = IO.io(ApiEndpoint.socketUrl, <String, dynamic>{
  //     'transports': ['websocket'],
  //   });
  //   //  socket = io('https://musicbook.co.in/socket_connection', OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

  //   //  socket.connect();

  //   // socket.on('connect', (_) {
  //   //   debugPrint('Connected to server');
  //   // });

  //   socket.onConnect((_) {
  //     debugPrint('connect');
  //     socket.emit("joinRoom", room);
  //     // socket.on("chatHistory", (payload) {
  //     //   //    debugPrint(payload);
  //     //   for (var payloadx in payload) {
  //     //     debugPrint(payloadx);
  //     //     debugPrint(Message.fromJson(jsonDecode(payloadx)));
  //     //     liveMessages.add(Message.fromJson(jsonDecode(payloadx)));

  //     //     //   chatMessages.add(ChatMessage.fromJson(payloadx));
  //     //   }
  //     //   debugPrint(liveMessages);
  //     //   //    messagesStreamController.add(liveMessages);

  //     //   //   //    setState(() {});
  //     // });
  //   });

  //   socket.onDisconnect((_) => debugPrint('disconnect'));

  //   //   socket.on(
  //   //       'message_${widget.room}',
  //   //       (message) => {
  //   //             setState(() {
  //   //               chatMessages.add(ChatMessage(sender: message['sender'], message: message['message']));
  //   //             })
  //   //           });
  //   // }
  //   // socket.on('receive_message_$room', (message) {
  //   //   //    debugPrint(message);
  //   //   return {liveMessages.add(Message.fromJson(jsonDecode(message)))};
  //   // });
  //   socket.on('receive_message_$room', (message) {
  //     debugPrint("88888888888888888888888888888888888");
  //     debugPrint(message);
  //     //  return {liveMessages.add(Message.fromJson(jsonDecode(message)))};
  //   });
  //   socket.on('message_$room', (message) {
  //     debugPrint("777777777777777777777777777777777777777777");
  //     debugPrint(message);
  //     //  return {liveMessages.add(Message.fromJson(jsonDecode(message)))};
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Obx(() {
        // liveMessages.addIf(socketController.liveMessage.value.sender != null,
        //     socketController.liveMessage.value);
        return ListView.builder(
          // controller: socketController.scrollController,
          itemCount: socketController.liveMessages.length,
          // (liveMessages.length ?? -1),
          // widget.messages.length
          //     +

          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            //debugPrint(snapshot.data![0].sender!);
            // debugPrint(snapshot.data![index % 2].sender!);
            final Message data = socketController.liveMessages[index];
            bool isDate = socketController.isDate.value;
            String toPut = socketController.toPut.value;

            if (index >= 1) {
              DateTime prev = DateTime.parse(socketController.liveMessages[index - 1].createdAt!);
              DateTime curr = DateTime.now();
              DateTime msgDate = DateTime.parse(data.createdAt!);
              Duration diff = curr.difference(msgDate);
              Duration diff2 = msgDate.difference(prev);

              if (diff.inDays == 0 && diff2.inDays == 1) {
                isDate = !isDate;
                toPut = 'Today';
              } else if (diff.inDays == 1 && diff2.inDays == 1) {
                isDate = !isDate;
                toPut = 'Yesterday';
              } else if (diff2.inDays == 1) {
                isDate = !isDate;
                toPut = DateFormat('yyyy-MM-dd – kk:mm').format(curr);
              } else {
                isDate = !isDate;
              }
            }
            return Column(
              children: [
                isDate
                    ? Center(
                        child: Container(
                          child: Text(toPut),
                        ),
                      )
                    : const SizedBox.shrink(),
                Container(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: socketController.isUserSender!.value
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
                                color: (socketController.isUserSender!.value ? const Color(0xffAFB6FD).withOpacity(.5) : chipColor),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.text ?? "loading text",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: (socketController.isUserSender!.value ? blackButtonColor : chipColor),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    DateFormat.jm().format(DateTime.parse(data.createdAt!)),
                                    style: TextStyle(fontSize: 7, fontWeight: FontWeight.w700, color: lightBlack),
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
                                color: (socketController.isUserSender!.value ? chatContainer : chipColor),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.text!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: (socketController.isUserSender!.value ? blackButtonColor : whiteColor),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    DateFormat.jm().format(DateTime.parse(data.createdAt!)),
                                    //DateTime dt = DateTime.parse('2020-01-02 03:04:05');
                                    style: TextStyle(fontSize: 7, fontWeight: FontWeight.w700, color: whiteColor.withOpacity(.5)),
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
      })
    ]);
    // StreamBuilder<List<Message>>(
    //   // initialData: widget.messages,
    //   // stream: socketController.messagesStreamController.stream,
    //   initialData: widget.messages,
    //   stream: socketController.messagesStreamController.stream,
    //   builder: (context, snapshot) =>

    // );
  }
}
