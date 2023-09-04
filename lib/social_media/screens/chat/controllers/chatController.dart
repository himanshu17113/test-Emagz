import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/chat_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  //Rx<Map<String, Conversation>>? conversations;
//  RxList<Message>? messages;

  var jwtController = Get.put(JWTController());

  @override
  onInit() async {
    await storedData();

    super.onInit();
  }

  String? token;
  String? userId;
  Future<void> storedData() async {
    token = await jwtController.getAuthToken();
    userId = await jwtController.getUserId();
  }

  Future<List<Message>> getMessages(String conversationId) async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      debugPrint(ApiEndpoint.getMessages(conversationId));
      var response = await dio.get(ApiEndpoint.getMessages(conversationId));
      debugPrint(response.data);
      List<Message>? messages = [];
      response.data.forEach((e) {
        var message = Message.fromJson(e);
        messages.add(message);
      });
      return messages;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Conversation>> getChatList() async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      debugPrint(ApiEndpoint.getConversation(userId!));
      var response = await dio.get(ApiEndpoint.getConversation(userId!));
      debugPrint("Chat list");
      debugPrint("🧣🧣🧣🧣🧣 start");
      List<Conversation> conversationsx = [];
      response.data.forEach((e) {
        // debugPrint(jsonEncode(e));
        //   conversations ??= Rx<Map<String, Conversation>>({});
        final conversation = Conversation.fromJson(e);
        //debugPrint("🧣🧣🧣🧣🧣m ${conversation.data?.members}");
        conversationsx.add(conversation);
        //     conversations?.value.addAll({conversation.data!.id!: conversation});
        //     debugPrint("🧣🧣🧣🧣🧣v  ${conversations?.value.toString()}");
      });

      //  debugPrint("🧣🧣🧣🧣🧣jkkkkkkkk  ${conversations?.value.values.toString()}");
      return conversationsx;
      //  return conversations!.value.values.toList().reversed.toList();
    } catch (e) {
      return [];
    }
  }

  Future postChat(String text, String conversationId) async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      var body = {
        "conversationId": conversationId,
        "sender": userId,
        "text": text
      };
      var response = await dio.post(ApiEndpoint.postMessage, data: body);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> conversationId(String receiverId) async {
    try {
      debugPrint("🧣🧣🧣🧣🧣 start");
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      debugPrint(ApiEndpoint.getConID(userId!, receiverId));
      var response = await dio.get(
        ApiEndpoint.getConID(userId!, receiverId),
      );
      //   debugPrint("🧣🧣🧣🧣🧣 hit");
      debugPrint(response.data);
      // debugPrint("🧣🧣🧣🧣🧣 get");
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 && response.data != null) {
        debugPrint(response.data);
        debugPrint(response.data["_id"]);
        //  final conversation = Conversation.fromJson(response.data);
        return response.data["_id"];
      } else {
        debugPrint("🧣🧣🧣🧣🧣 else");
        final cId = await startConversationId(receiverId);
        debugPrint("🧣🧣🧣🧣🧣 $cId");
        return cId;
      }
    } catch (e) {
      final cId = await startConversationId(receiverId);
      debugPrint("🧣🧣🧣🧣🧣 error");
      debugPrint(e.toString());
      return cId;
    }
  }

  Future<String> startConversationId(String receiverId) async {
    try {
      debugPrint("🧣🧣🧣🧣🧣 start2");
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      var body = {"senderId": userId, "receiverId": receiverId};
      var response = await dio.post(ApiEndpoint.strikeFirstCon, data: body);
    //  debugPrint(response.data["_id"].toString());
      //   final conversation = Conversation.fromJson(response.data);
      return response.data["_id"];
    } catch (e) {
    //  debugPrint(e.toString());
      return "";
    }
  }
}
