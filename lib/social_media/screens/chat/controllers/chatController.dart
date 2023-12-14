import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/chat_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../constant/data.dart';
import '../models/reuqest_model.dart';
import 'package:http/http.dart' as http;

class ConversationController extends GetxController {
  final Dio dio = Dio();
  RxList<Requests?>? req = <Requests>[].obs;
  static String? token = globToken;
  static String? userId = userId;
  @override
  onInit() async {
    token = globToken;
    userId = globUserId;
    dio.options.headers["Authorization"] = globToken;
    getAllRequests('new');
    if (token == null || userId == null) {
      await storedData();
    }

    super.onInit();
  }

  Future<void> storedData() async {
    token = await HiveDB.getAuthToken();
    userId = await HiveDB.getUserID();
  }

  Future<List<Message>> getMessages(String conversationId) async {
    try {
      if (token == null || userId == null) {
        await storedData();
      }

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
      if (token == null || userId == null) {
        await storedData();
      }
      debugPrint(ApiEndpoint.getConversation(globUserId ?? userId!));
      var response =
          await dio.get(ApiEndpoint.getConversation(globUserId ?? userId!));
      debugPrint("Chat list");
      debugPrint("🧣🧣🧣🧣🧣 start");
      List<Conversation> conversationsx = [];
      response.data.forEach((e) {
        final conversation = Conversation.fromJson(e);

        conversationsx.add(conversation);
      });

      return conversationsx;
    } catch (e) {
      return [];
    }
  }

  Future postChat(String text, String conversationId) async {
    try {
      var body = {
        "conversationId": conversationId,
        "sender": globUserId ?? userId,
        "text": text
      };

      await dio.post(ApiEndpoint.postMessage, data: body);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> conversationId(String receiverId) async {
    try {
      debugPrint("🧣🧣🧣🧣🧣 start");
      debugPrint(ApiEndpoint.getConID(globUserId ?? userId!, receiverId));
      var response = await dio.get(
        ApiEndpoint.getConID(globUserId ?? userId!, receiverId),
      );

      debugPrint(response.data);

      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 && response.data != null) {
        debugPrint(response.data);
        debugPrint(response.data["_id"]);

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
      var body = {"senderId": globUserId ?? userId, "receiverId": receiverId};
      var response = await dio.post(ApiEndpoint.strikeFirstCon, data: body);

      return response.data["_id"];
    } catch (e) {
      return "";
    }
  }

  Future<bool> acceptreq(String id, int index, String recieverId) async {
    debugPrint("🧣🧣🧣🧣🧣 start2");
    debugPrint('${ApiEndpoint.requestList}/$id/accept');
    var response = await dio.post('${ApiEndpoint.requestList}/$id/accept');
    if (response.statusCode == 200) {
      req?.removeAt(index);
      var body = {"senderId": globUserId ?? userId, "receiverId": recieverId};
      var x = body;
      debugPrint(x.toString());

      var respose;
      try {
        respose = await dio.post(ApiEndpoint.strikeFirstCon, data: body);
        debugPrint(respose.toString());
      } catch (e) {
        if (respose == null) {
          CustomSnackbar.show('You have already chat with this person');
          return true;
        }
        if (respose.statusCode != 200) {
          CustomSnackbar.show('You have already chat with this person');
          return true;
        }
      }
      CustomSnackbar.showSucess('Reuqest ');
      return true;
    }

    if (response.statusCode != 200) {
      CustomSnackbar.show('Reuqest Not found');
    }
    return false;
  }

  Future<bool> rejectreq(String id, int index) async {
    var response = await dio.delete('${ApiEndpoint.removeRequest}/$id');
    if (response.statusCode == 200) {
      CustomSnackbar.showSucess('Reuqest ');
      req?.removeAt(index);
      return true;
    } else {
      CustomSnackbar.show('hello');
    }
    return false;
  }

  Future<List<Requests?>?> getAllRequests(String filter) async {
    req?.clear();
    try {
      debugPrint('${ApiEndpoint.requestList}?filter=$filter');
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": token!
      };
      http.Response response = await http.get(
          Uri.parse('${ApiEndpoint.requestList}?filter=$filter'),
          headers: headers);
      var body = jsonDecode(response.body);
     Requests? temp ;
      body.forEach((e) {
    temp   = Requests.fromJson(e);
        req?.add(temp);
          debugPrint("jl ${temp!.sender?.username .toString()}");
            debugPrint("jl reci ${temp!.reciever?.username.toString()}");
      });
      return req;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
