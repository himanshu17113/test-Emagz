import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:flutter/material.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../../constant/api_string.dart';

class MessageView extends StatefulWidget {
  final List<Message> messages;
  final String? senderId;
  final String? room;
  const MessageView(
      {super.key, required this.messages, this.senderId, this.room});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  //String? userId;

  bool isReciver(String messageUserId) => !(messageUserId == widget.senderId);

  var socketController = Get.put(SocketController());
  List<Message> liveMessages = [];
  @override
  initState() {
    liveMessages = widget.messages;
    print(
        "----------------------------------------------------------------------------------------------------------------------------------------------------");

    print(widget.messages);
    super.initState();
  }

  // void connectToServer(String room) {
  //   IO.Socket socket = IO.io(ApiEndpoint.socketUrl, <String, dynamic>{
  //     'transports': ['websocket'],
  //   });
  //   //  socket = io('https://musicbook.co.in/socket_connection', OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

  //   //  socket.connect();

  //   // socket.on('connect', (_) {
  //   //   print('Connected to server');
  //   // });

  //   socket.onConnect((_) {
  //     print('connect');
  //     socket.emit("joinRoom", room);
  //     // socket.on("chatHistory", (payload) {
  //     //   //    print(payload);
  //     //   for (var payloadx in payload) {
  //     //     print(payloadx);
  //     //     print(Message.fromJson(jsonDecode(payloadx)));
  //     //     liveMessages.add(Message.fromJson(jsonDecode(payloadx)));

  //     //     //   chatMessages.add(ChatMessage.fromJson(payloadx));
  //     //   }
  //     //   print(liveMessages);
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
  //   //   //    print(message);
  //   //   return {liveMessages.add(Message.fromJson(jsonDecode(message)))};
  //   // });
  //   socket.on('receive_message_$room', (message) {
  //     print("88888888888888888888888888888888888");
  //     print(message);
  //     //  return {liveMessages.add(Message.fromJson(jsonDecode(message)))};
  //   });
  //   socket.on('message_$room', (message) {
  //     print("777777777777777777777777777777777777777777");
  //     print(message);
  //     //  return {liveMessages.add(Message.fromJson(jsonDecode(message)))};
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return
        // StreamBuilder<List<Message>>(
        //   // initialData: widget.messages,
        //   // stream: socketController.messagesStreamController.stream,
        //   initialData: widget.messages,
        //   stream: socketController.messagesStreamController.stream,
        //   builder: (context, snapshot) =>

        Obx(() {
      liveMessages.addIf(socketController.liveMessage.value.sender != null,
          socketController.liveMessage.value);
      return ListView.builder(
        // controller: socketController.scrollController,
        itemCount: (liveMessages.length ?? -1),
        // widget.messages.length
        //     +

        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          //print(snapshot.data![0].sender!);
          // print(snapshot.data![index % 2].sender!);
          final Message data = liveMessages[index];
          return Container(
            padding:
                const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            child: isReciver(data.sender!)
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
                          color: (isReciver(data.sender!)
                              ? const Color(0xffAFB6FD).withOpacity(.5)
                              : chipColor),
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
                                color: (isReciver(data.sender!)
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
                          color: (isReciver(data.sender!)
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
                                color: (isReciver(data.sender!)
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
                                  color: whiteColor.withOpacity(.5)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      );
    });
    // );
  }
}
