import 'dart:convert';

import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';

import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/notification_model.dart';

class SocketController extends GetxController {
  IO.Socket socket = IO.io(ApiEndpoint.socketUrl, <String, dynamic>{
    'transports': ['websocket'],
  });

  String? userId;
  RxBool? isUserSender = false.obs;
  final chatController = Get.put(ConversationController());

  final jwtController = Get.find<JWTController>();
  Rx<Message> liveMessage = Message().obs;
  RxList<Message> liveMessages = <Message>[].obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxList<String> timeStamps = <String>[].obs;
  RxString? conversationId;
  RxBool isDate = false.obs;
  RxString toPut = ''.obs;

  void getNotification() {
    socket.connect();

    socket.onConnect((_) {
      socket.emit("notificationHistory", userId);

      socket.on("notificationHistory_$userId", (payload) {
        print(jsonEncode(payload));
        for (var payloadx in payload) {
          notifications.add(NotificationModel.fromMap(payloadx));
          debugPrint(notifications[0].message.toString());
        }
      });
      socket.on("notifications_$userId", (payload) {
        print(jsonEncode(payload));

        notifications.insert(0, NotificationModel.fromMap(payload));
        debugPrint(notifications[0].message.toString());
      });
    });
  }

  void connectToServer(String room) {
    socket.onConnect((_) {
      socket.emit("joinRoom", room);
    });
    socket.on("chatHistory", (payload) {
      for (var payloadx in payload) {
        liveMessages.add(Message.fromJson(payloadx));
      }
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
      liveMessages.add(Message(
        sId: message['_id'],
        conversationId: message['conversationId'],
        sender: message['sender'],
        text: message['text'],
        createdAt: message['createdAt'],
      ));
    });
  }

  void sendMessage(String message, String room, String id) async {
    if (message.isNotEmpty) {
      await chatController.postChat(message, room);
      isUserSender = (userId == id).obs;
      DateTime curr = DateTime.now();
      String formattedTime = DateFormat.jm().format(curr); //05:00Pm
      liveMessages.add(Message(conversationId: room, sender: id, text: message, createdAt: curr.toString() //formattedTime
          ));
      liveMessage.value = Message(conversationId: room, sender: id, text: message, createdAt: curr.toString() //formattedtime
          );
    }
  }

  initSocket() async {
    userId = jwtController.userId ?? chatController.userId;
    if (userId == null) {
      userId = await jwtController.getUserId();
    }
  }

  @override
  void onInit() {
    initSocket();
    getNotification();
    super.onInit();
  }
}
