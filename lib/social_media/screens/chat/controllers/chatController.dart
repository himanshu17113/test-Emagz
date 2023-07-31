import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/chat_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/message_model.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController{

  Rx<Map<String,Conversation>>? conversations;
  RxList<Message>? messages;

  var jwtController = Get.put(JWTController());


  Future<List<Message>> getMessages(String conversationId) async{
    try {
      var token = await jwtController.getAuthToken();
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      print(ApiEndpoint.getMessages(conversationId));
      var response = await dio.get(ApiEndpoint.getMessages(conversationId));
      print(response.data);
      response.data.forEach((e){
        messages ??= RxList();
        var message = Message.fromJson(e);
        messages!.add(message);
      });
      return messages!.value;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<List<Conversation>> getChatList() async {
    try {
      var userId = await jwtController.getUserId();
      var token = await jwtController.getAuthToken();
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      print(ApiEndpoint.getConversation(userId!));
      var response = await dio.get(ApiEndpoint.getConversation(userId));
      print("Chat list");
      response.data.forEach((e){
        print(e);
        conversations ??= Rx<Map<String,Conversation>>({});
        var conversation = Conversation.fromJson(e);
        conversations!.value.addAll({conversation.sId!:conversation});
      });
      return conversations!.value.values.toList().reversed.toList();
    }catch(e){
      return [];
    }
  }

  Future postChat(String text,String conversationId)async{
    try {
      var userId = await jwtController.getUserId();
      var token = await jwtController.getAuthToken();
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      var body = {
          "conversationId" : conversationId,
          "sender":userId,
          "text":text
      };
      var response = await dio.post(ApiEndpoint.postMessage,data: body);
      print(response.data);
    }catch(e){
      print(e);
    }
  }
}