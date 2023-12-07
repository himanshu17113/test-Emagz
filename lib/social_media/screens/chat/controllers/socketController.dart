import 'dart:convert';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../models/notification_model.dart';

class SocketController extends GetxController {
  IO.Socket socket = IO.io(ApiEndpoint.socketUrl, <String, dynamic>{
    'transports': ['websocket'],
  });
  static Client client = http.Client();
  String? userId;
  RxBool? isUserSender = false.obs;
  final chatController = Get.put(ConversationController());

  // final jwtController = JWTController();
  String? token;
  // Rx<Message> liveMessage = Message().obs;
  RxList<Message> liveMessages = <Message>[].obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxList<String> timeStamps = <String>[].obs;
  RxString? conversationId;

  void getNotification() {
    socket.connect();

    socket.onConnect((_) {
      socket.emit("notificationHistory", userId);

      socket.on("notificationHistory_$userId", (payload) {
        debugPrint(jsonEncode(payload).toString());
        for (var payloadx in payload) {
          notifications.add(NotificationModel.fromMap(payloadx));
          debugPrint(notifications[0].message.toString());
        }
      });
      socket.on("notifications_$userId", (payload) {
        debugPrint(jsonEncode(payload).toString());

        notifications.insert(0, NotificationModel.fromMap(payload));
        debugPrint(notifications[0].message.toString());
      });
    });
  }

  void disconnectToServer(String room) {
    socket.emit("leaveRoom", room);
    socket.clearListeners();
  }

  void connectToServer(String room) {
    debugPrint("Connect to Server");
//    socket.connect();
    socket.emit("joinRoom", room);
    // socket.onConnect((_) {
    //   debugPrint("socket is connected to the room $room");
    //   socket.emit("joinRoom", room);
    // });

    socket.on("chatHistory", (payload) {
      debugPrint("Getting Chat History");
      debugPrint(payload.toString());
      for (var payloadx in payload) {
        // print(payloadx);
        liveMessages.add(Message.fromJson(payloadx));
      }
    });

    socket.onDisconnect((_) => debugPrint('disconnect'));
    socket.on(
        'receive_message_$room',
        (message) => {
              liveMessages.add(Message(
                sId: message['_id'],
                conversationId: message['conversationId'],
                sender: message['sender'],
                text: message['text'],
                createdAt: message['createdAt'],
              ))
            });
    socket.on('message_$room', (message) {
      // liveMessage.value = Message(
      //   sId: message['_id'],
      //   conversationId: message['conversationId'],
      //   sender: message['sender'],
      //   text: message['text'],
      //   createdAt: message['createdAt'],
      // );

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
      //    await chatController.postChat(message, room);'
      Map<String, dynamic> data = {
        "room": room,
        "sender": userId,
        "message": message,
      };
      socket.emit("chatMessage", data);
      isUserSender = (userId == id).obs;
      //  DateTime curr = DateTime.now();
      //  String formattedTime = DateFormat.jm().format(curr); //05:00Pm
      // liveMessages.add(Message(
      //     conversationId: room,
      //     sender: id,
      //     text: message,
      //     createdAt: curr.toString() //formattedTime
      //     ));
      // liveMessage.value = Message(
      //     conversationId: room,
      //     sender: id,
      //     text: message,
      //     createdAt: curr.toString() //formattedtime
      //     );
    }
  }

  initSocket() async {
    userId = globUserId ?? chatController.userId;
    token = globToken ?? chatController.token;
    userId ??= await HiveDB.getUserID();
    token ??= await HiveDB.getAuthToken();
  }

  void sendLikeNotification(String id, String name) {
    debugPrint("name : $name , userID : $userId , oid : $id");
    Map<String, dynamic> data = {"notification_from": userId!, "notification_to": id, "notification": {}, "title": "Like", "message": "$name liked your post"};
    socket.emit("notification", data);
  }

  void sendShareNotification(String id, String name, bool ispost, String shareLink) {
    Map<String, dynamic> data = {
      "notification_from": userId!,
      "notification_to": id,
      "notification": {"link": shareLink},
      "title": ispost ? "post Shared " : "story Shared ",
      "message": ispost ? "$name Share a post with you" : "$name Shared a story with you",
    };
    socket.emit("notification", data);
  }

  void sendCommentNotification(String id, bool ispost, String? shareLink, bool isReply) {
    Map<String, dynamic> data = {
      "notification_from": userId!,
      "notification_to": id,
      //   "notification": {"link": shareLink},
      "title": "Comment",
      "message": ispost
          ? isReply
              ? "${constuser?.displayName} Replied on your post "
              : "${constuser?.displayName} Commented on your post "
          : isReply
              ? "${constuser?.displayName} Replied on your Story "
              : "${constuser?.displayName} Commented on your Story ",
    };
    socket.emit("notification", data);
  }

  Future<bool> removeSingleNotification(String notificationId) async {
    try {
      //  notifications.removeAt(index);
      Map<String, String> header = {
        'authorization': token!,
      };

      String url = ApiEndpoint.removeSingleNotification(notificationId);

      debugPrint(url);
      http.Response response = await client.get(
        Uri.parse(url),
        headers: header,
      );

      debugPrint(response.toString());
      debugPrint(url);

      debugPrint('Response Code: ${response.body}');
      debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        //   notifications.removeWhere((element) => element.id == NotificationId);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> clearAllNotification() async {
    try {
      Map<String, String> header = {
        'authorization': token!,
      };

      String url = ApiEndpoint.clearAllNotification(userId!);

      debugPrint(url);
      http.Response response = await client.get(
        Uri.parse(url),
        headers: header,
      );

      debugPrint(response.toString());
      debugPrint(url);

      debugPrint('Response Code: ${response.body}');
      debugPrint(response.statusCode.toString());

      if (response.statusCode == 200) {
        notifications.clear();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  void onInit() {
    initSocket();
    getNotification();
    super.onInit();
  }
}
