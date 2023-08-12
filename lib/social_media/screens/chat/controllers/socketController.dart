import 'package:emagz_vendor/constant/api_string.dart';

import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  IO.Socket socket = IO.io(ApiEndpoint.socketUrl, <String, dynamic>{
    'transports': ['websocket'],
  });

  String? userId;

  Rx<Message> liveMessage = Message().obs;

  RxString? conversationId;

  void connectToServer(String room) {
    socket.onConnect((_) {
      socket.emit("joinRoom", room);
    });

    socket.onDisconnect((_) => debugPrint('disconnect'));

    socket.on('message_$room', (message) {
      liveMessage.value = Message(
        sId: message['_id'],
        conversationId: message['conversationId'],
        sender: message['sender'],
        text: message['text'],
        createdAt: message['createdAt'],
      );
    });
  }

  void sendMessage(String message, String room, String id) {
    if (message.isNotEmpty) {
      Map<String, dynamic> data = {
        "room": room,
        "sender": id,
        "message": message,
      };
      print("9999999999999999999");
      print(data);

      socket.emit('chatMessage', data);
      liveMessage.value = Message(
        conversationId: room,
        sender: id,
        text: message,
      );
    }
  }

  initSocket() async {
    socket.connect();
  }

  @override
  void onInit() {
    initSocket();

    super.onInit();
  }
}
