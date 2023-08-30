
import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/chat_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
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
      print(ApiEndpoint.getMessages(conversationId));
      var response = await dio.get(ApiEndpoint.getMessages(conversationId));
      print(response.data);
      List<Message>? messages = [];
      response.data.forEach((e) {
        var message = Message.fromJson(e);
        messages.add(message);
      });
      return messages;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Conversation>> getChatList() async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      print(ApiEndpoint.getConversation(userId!));
      var response = await dio.get(ApiEndpoint.getConversation(userId!));
      print("Chat list");
      print("🧣🧣🧣🧣🧣 start");
      List<Conversation> conversationsx = [];
      response.data.forEach((e) {
       
        // print(jsonEncode(e));
        //   conversations ??= Rx<Map<String, Conversation>>({});
        final conversation = Conversation.fromJson(e);
        //print("🧣🧣🧣🧣🧣m ${conversation.data?.members}");
        conversationsx.add(conversation);
   //     conversations?.value.addAll({conversation.data!.id!: conversation});
   //     print("🧣🧣🧣🧣🧣v  ${conversations?.value.toString()}");
      });

    //  print("🧣🧣🧣🧣🧣jkkkkkkkk  ${conversations?.value.values.toString()}");
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
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<String> conversationId(String receiverId) async {
    try {
      print("🧣🧣🧣🧣🧣 start");
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      print(ApiEndpoint.getConID(userId!, receiverId));
      var response = await dio.get(
        ApiEndpoint.getConID(userId!, receiverId),
      );
      //   print("🧣🧣🧣🧣🧣 hit");
      print(response.data);
      // print("🧣🧣🧣🧣🧣 get");
      print(response.statusCode);
      if (response.statusCode == 200 && response.data != null) {
        print(response.data);
        print(response.data["_id"]);
        //  final conversation = Conversation.fromJson(response.data);
        return response.data["_id"];
      } else {
        print("🧣🧣🧣🧣🧣 else");
        final cId = await startConversationId(receiverId);
        print("🧣🧣🧣🧣🧣 $cId");
        return cId;
      }
    } catch (e) {
      final cId = await startConversationId(receiverId);
      print("🧣🧣🧣🧣🧣 error");
      print(e);
      return cId;
    }
  }

  Future<String> startConversationId(String receiverId) async {
    try {
      print("🧣🧣🧣🧣🧣 start2");
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      var body = {"senderId": userId, "receiverId": receiverId};
      var response = await dio.post(ApiEndpoint.strikeFirstCon, data: body);
      print(response.data["_id"]);
      //   final conversation = Conversation.fromJson(response.data);
      return response.data["_id"];
    } catch (e) {
      print(e);
      return "";
    }
  }
}
