import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/chat_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/reuqest_model.dart';
import 'package:http/http.dart' as http;

class ConversationController extends GetxController {
  //Rx<Map<String, Conversation>>? conversations;
//  RxList<Message>? messages;

  final jwtController = Get.find<JWTController>();
  RxList<Requests?>? req= <Requests>[].obs;

  String? token;
  String? userId;
  @override
  onInit() async {
    token = jwtController.token;
    userId = jwtController.userId;
    getAllRequests();
    if (token == null || userId == null) {
      await storedData();
    }

    super.onInit();
  }

  Future<void> storedData() async {
    token = await jwtController.getAuthToken();
    userId = await jwtController.getUserId();
  }

  Future<List<Message>> getMessages(String conversationId) async {
    try {
        if (token == null || userId == null) {
        await storedData();
      }
      Dio dio = Dio();
      dio.options.headers["Authorization"] = jwtController.token ?? token;
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
      dio.options.headers["Authorization"] = jwtController.token ?? token;
      debugPrint(ApiEndpoint.getConversation(jwtController.userId ?? userId!));
      var response = await dio
          .get(ApiEndpoint.getConversation(jwtController.userId ?? userId!));
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
      dio.options.headers["Authorization"] = jwtController.token ?? token;
      var body = {
        "conversationId": conversationId,
        "sender": jwtController.userId ?? userId,
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
      dio.options.headers["Authorization"] = jwtController.token ?? token;
      debugPrint(
          ApiEndpoint.getConID(jwtController.userId ?? userId!, receiverId));
      var response = await dio.get(
        ApiEndpoint.getConID(jwtController.userId ?? userId!, receiverId),
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
      dio.options.headers["Authorization"] = jwtController.token ?? token;
      var body = {
        "senderId": jwtController.userId ?? userId,
        "receiverId": receiverId
      };
      var response = await dio.post(ApiEndpoint.strikeFirstCon, data: body);
      //  debugPrint(response.data["_id"].toString());
      //   final conversation = Conversation.fromJson(response.data);
      return response.data["_id"];
    } catch (e) {
      //  debugPrint(e.toString());
      return "";
    }
  }

  Future<bool> acceptreq(String id,int index) async
  {
    debugPrint("🧣🧣🧣🧣🧣 start2");
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    print('${ApiEndpoint.requestList}/${id}/accept');
    var response = await dio.post('${ApiEndpoint.requestList}/${id}/accept');
    if(response.statusCode==200)
      {
        CustomSnackbar.showSucess('Reuqest ');
        req?.removeAt(index);
        return true;
      }
    if(response.statusCode!=200)
      {
        CustomSnackbar.show('Reuqest Not found');
      }
    return false;
  }
  Future<bool> rejectreq(String id,int index) async
  {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;
    var response = await dio.delete('${ApiEndpoint.removeRequest}/${id}');
    if(response.statusCode==200)
    {
      CustomSnackbar.showSucess('Reuqest ');
      req?.removeAt(index);
      return true;
    }
    else
      {
        CustomSnackbar.show('hello');
      }
    return false;
  }
  Future<List<Requests?>?> getAllRequests() async {
    print('😛');
    req?.clear();
    try{
      var token = await jwtController.getAuthToken();
      var headers = {'Content-Type': 'application/json', "Authorization": token!};
      http.Response response = await http.get(Uri.parse('${ApiEndpoint.requestList}'), headers: headers);
      var body = jsonDecode(response.body);
      print(body);
      body.forEach((e) {
        var temp = Requests.fromJson(e);
        req?.add(temp);
      });
      return req;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
