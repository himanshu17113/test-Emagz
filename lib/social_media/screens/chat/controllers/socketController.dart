import 'dart:async';

import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController{

  IO.Socket? socket;
  String? userId;
  ScrollController scrollController = ScrollController();
  List<Message> liveMessages = [];
  StreamController<List<Message>> messagesStreamController = StreamController<List<Message>>.broadcast();


  var jwtController = Get.put(JWTController());
  var conversationController = Get.put(ConversationController());

  sendMessage(String receiverId,String text)async{
    if(userId == null) {
      userId = await jwtController.getUserId();
    }
    socket?.emit("sendMessage",
        {
          "senderId":userId,
          "receiverId":receiverId,
          "text":text
        }
      );
    Message message = Message(sender: userId,text: text );
    print("message recived");
    liveMessages.add(message);
    messagesStreamController.add(liveMessages);
  }


  initSocket() async {
    var userId = await jwtController.getUserId();
    socket = IO.io(ApiEndpoint.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
    });
    print("Sockets Touched");
    socket?.connect();
    socket?.onConnect((val) {
      print("CONNECTED ");
      socket?.emit("addUser",userId);
    });
    socket?.onDisconnect((_) => print('Connection Disconnection'));
    socket?.onConnectError((err) => print("connextion error : $err"));
    socket?.onError((err) => print("error : $err"));

    socket?.on("getMessage", (data) {

      var sender = data["senderId"];
      var text = data["text"];
      print(sender);
      print(text);
      print(data);
      Message message = Message(sender: sender,text: text );
      print("message recived");
      // scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 100), curve: Curves.easeIn);
      liveMessages.add(message);
      messagesStreamController.add(liveMessages);
      print(" data : ${data}");
    });
  }
  @override
  void onInit() {
    initSocket();
    super.onInit();
  }
}