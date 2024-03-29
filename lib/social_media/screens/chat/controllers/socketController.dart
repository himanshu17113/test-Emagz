import 'dart:convert';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/chat_model.dart';
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
  final FocusNode focusNode = FocusNode();
  List<String?> onLineUserIds = [];
  String? prevRoom;
  ScrollController controller = ScrollController();
  static Client client = http.Client();
  static String? userId = globUserId;
  RxBool? isUserSender = false.obs;
  static String? token = globToken;
  List<Message> liveMessages = <Message>[];
  List<NotificationModel> notifications = <NotificationModel>[];
  RxList<String> timeStamps = <String>[].obs;
  String? conversationId;
  RxBool showEmojiBoard = RxBool(false);
  static Map<String, String> header = {
    'authorization': token!,
  };
  void getNotification() {
    socket.connect();
    socket.onConnect((_) {
      socket.emit("notificationHistory", globUserId);
      socket.on("notificationHistory_$globUserId", (payload) {
        debugPrint(jsonEncode(payload).toString());
        for (var payloadx in payload) {
          notifications.add(NotificationModel.fromMap(payloadx));
        }
        update(["dot"]);
      });
      update(["dot"]);
      socket.on("notifications_$globUserId", (payload) {
        debugPrint(jsonEncode(payload).toString());

        notifications.insert(0, NotificationModel.fromMap(payload));
        debugPrint(notifications[0].message.toString());
        update(["dot"]);
      });
      update(["dot"]);
    });
  }

  void disconnectToServer(String room) {
    socket.emit("leaveRoom", room);
    update(["dot"]);
    socket.clearListeners();
  }

  void emoji() {
    showEmojiBoard.value = !showEmojiBoard.value;

    if (showEmojiBoard.value) {
      focusNode.unfocus();
      focusNode.canRequestFocus = true;
    } else {
      focusNode.unfocus();
      focusNode.canRequestFocus = true;
    }
  }

  void iAmActive() => socket.emit("joinLoginRoom", {"userId": globUserId!});

  void iamOffline() => socket.emit("joinLoginRoom", {"userId": globUserId, "activeStatus": false});

  void getActiveUsers() => socket.on("userOnline", (payload) {
        onLineUserIds.clear();

        payload.forEach((element) {
          debugPrint(element.toString());
          onLineUserIds.addIf(element['userId'] != null, element['userId']);
        });
        update(['active']);
      });

  void connectToServer(String room) {
    if (prevRoom != null && prevRoom == room) {
      debugPrint("do nothhing");
    } else {
      if (prevRoom != null && prevRoom != room) {
        disconnectToServer(prevRoom!);
        liveMessages.clear();
      }

      prevRoom = room;

      debugPrint("Connect to Server");

      socket.emit("joinRoom", room);

      socket.on("chatHistory", (payload) {
        debugPrint("Getting Chat History");
        debugPrint(payload.toString());
        for (var payloadx in payload) {
          liveMessages.add(Message.fromJson(payloadx));
        }
        update(["message"]);
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
                )),
                update(["message"])
              });
      socket.on('message_$room', (message) {
        liveMessages.add(Message(
          sId: message['_id'],
          conversationId: message['conversationId'],
          sender: message['sender'],
          text: message['text'],
          createdAt: message['createdAt'],
        ));
        update(["message"]);
      });
    }
  }

  void sendMessage(String message, String room, String id) async {
    if (message.isNotEmpty) {
      Map<String, dynamic> data = {
        "room": room,
        "sender": userId,
        "message": message,
      };
      socket.emit("chatMessage", data);
      controller.jumpTo(controller.position.maxScrollExtent + 100);
      isUserSender = (userId == id).obs;
    }
  }

  void sendLikeNotification(String id, String name) {
    debugPrint("name : $name , userID : $userId , oid : $id");
    Map<String, dynamic> data = {
      "notification_from": userId!,
      "notification_to": id,
      "notification": {},
      "title": "Like",
      "message": "$name liked your post"
    };
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

  Future<bool> removeSingleNotification(String notificationId, int index) async {
    try {
      notifications.removeAt(index);
      update(["dot"]);

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
        update(["dot"]);
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

  Future<void> getChatList() async {
    try {
      print('getChatList');
      debugPrint(ApiEndpoint.getConversation(globUserId ?? userId!));
      var response = await client.get(Uri.parse(ApiEndpoint.getConversation(globUserId ?? userId!)), headers: header);
     
      debugPrint("🧣🧣🧣🧣🧣 Chat list");
      List<Conversation> conversationsx = [];
      jsonDecode(response.body).forEach((e) {
        final conversation = Conversation.fromJson(e);

        conversationsx.add(conversation);
      });

      update(['ChatList']);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    iAmActive();
    getActiveUsers();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showEmojiBoard.value = false;
      }
    });
    getNotification();
    super.onInit();
  }
}
