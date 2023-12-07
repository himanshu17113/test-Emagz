import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommentController extends GetxController {
//  Rx<List<Comment>> instantComments = Rx<List<Comment>>([]);
  final socketController = Get.find<SocketController>();
  //final jwtController = Get.find<JWTController>();
  @override
  onInit() async {
    await storedData();

    super.onInit();
  }

  String? token;
  String? userId;
  Future<void> storedData() async {
    token = await HiveDB.getAuthToken();
    userId = await HiveDB.getUserID();
  }

  RxBool isPosting = RxBool(false);
  TextEditingController controller = TextEditingController();
  final focusNode = FocusNode();
  RxBool isCommentingOnPost = RxBool(true);
  RxBool isCommentingOnReply = RxBool(true);
  RxString commentOwner = RxString("");
  RxInt commentindex = RxInt(0);
  RxInt replyindex = RxInt(0);
  RxString commentId = RxString("");
//  RxBool isSending = RxBool(false);
  setCommentId(String id, String commentedBy, int index) {
    commentId.value = id;
    commentOwner.value = commentedBy;
    commentindex.value = index;
    isCommentingOnPost.value = false;
    isCommentingOnReply.value = false;
    focusNode.requestFocus();
  }

  setReplyId(String id, String commentedBy, int index) {
    focusNode.requestFocus();
    commentId.value = id;
    commentOwner.value = commentedBy;
    replyindex = RxInt(index);
    isCommentingOnReply.value = true;
    isCommentingOnPost.value = false;
  }

  setedCommentIdclear() {
    isCommentingOnReply = RxBool(false);
    isCommentingOnPost = RxBool(true);
    commentOwner = RxString("");
    commentindex = RxInt(5000000);
    commentId = RxString("");
    isCommentingOnPost.value = true;
    focusNode.unfocus();
  }

  Future<dynamic> postComment(String postId, String postuID) async {
    var comment = controller.text;
    if (comment == "") {
      Get.snackbar("Invalid Comment", "Cant post Empty Comment");
      return "";
    }
    isPosting.value = true;
    try {
      Dio dio = Dio();
      // var token =  await HiveDB.getAuthToken();
      // var userId = await HiveDB.getUserID();
      dio.options.headers["Authorization"] = token;
      var data = {"userId": userId, "text": comment};
      var resposne = await dio.post(ApiEndpoint.commentPost(postId), data: data);
      debugPrint(ApiEndpoint.commentPost(postId));
      debugPrint(data.toString());
      // print(resposne);
      if (resposne.statusCode == 200) {
        List<dynamic> list = resposne.data["post"]["Comments"];

        isPosting.value = false;
        socketController.sendCommentNotification(postuID, true, null, false);

        final Comment commentx = Comment.fromJson(list.last);

        return commentx;
      }
    } catch (e) {
      isPosting.value = false;
      //   update();
      return "";
    }
  }

  Future<List<Comment?>> getComment(String postId) async {
    var comment = controller.text;
    if (comment == "") {
      Get.snackbar("Invalid Comment", "Cant post Empty Comment");
      return [];
    }
    isPosting.value = true;
    try {
      Dio dio = Dio();
      // var token =  await HiveDB.getAuthToken();
      // var userId = await HiveDB.getUserID();
      dio.options.headers["Authorization"] = token;

      final resposne = await dio.get(
        ApiEndpoint.getcomment(postId),
      );

      isPosting.value = false;
      controller.clear();
      if (resposne.statusCode == 200) {
        List<Comment?> x = List<Comment?>.from(resposne.data.map((x) => Comment.fromJson(x)));
        return x;
      }

      return [];
    } catch (e) {
      isPosting.value = false;
      //   update();
      return [];
    }
  }

  commentStory(String storyId, String postuID) async {
    var comment = controller.text;
    if (token == null) {
      token = await HiveDB.getAuthToken();
      userId = await HiveDB.getUserID();
    }

    debugPrint("story : $storyId");
    final headers = {'Content-Type': 'application/json', "Authorization": token!};
    debugPrint(ApiEndpoint.commentPost(storyId));
    Map body = {"userId": userId, "text": comment};
    http.Response response = await http.post(Uri.parse(ApiEndpoint.commentStroy(storyId)), headers: headers, body: jsonEncode(body));
    debugPrint(response.body);
    List<dynamic> list = jsonDecode(response.body)["stories"]["Comments"];

    print("grrgf ${list.last}");
    isPosting.value = false;
    //  controller.clear();
    socketController.sendCommentNotification(postuID, false, null, false);
    isPosting.value = false;
    //final Comment commentx = Comment.fromJson(jsonDecode(list.last));
    //  return commentx;
    return list.last["_id"];
  }

  replyStory(String postId, String commentID, String? comment, String postuID) async {
    debugPrint("👾👾👾👾👾👾👾👾");

    debugPrint(ApiEndpoint.replyStory(postId, commentID, userId!));
    //  // var comment = controller.text;
    //   if (comment == "") {
    //     Get.snackbar("Invalid Comment", "Cant post Empty Comment");
    //     return false;
    //   }
    isPosting.value = true;
    try {
      Dio dio = Dio();

      debugPrint(token);
      dio.options.headers["Authorization"] = token;
      var data = {"text": comment ?? controller.text};
      var resposne = await dio.post(ApiEndpoint.replyStory(postId, commentID, userId!), data: data);
      debugPrint(resposne.toString());
      isPosting.value = false;
      controller.clear();
      socketController.sendCommentNotification(postuID, false, null, true);
      return false;
    } catch (e) {
      isPosting.value = false;

      return false;
    }
  }

  Future<Comment> postReply(String postId, String commentID, String? comment, String postuID) async {
    debugPrint("👾👾👾👾👾👾👾👾");

    debugPrint(ApiEndpoint.replyPost(postId, commentID, userId!));
    //  // var comment = controller.text;
    //   if (comment == "") {
    //     Get.snackbar("Invalid Comment", "Cant post Empty Comment");
    //     return false;
    //   }
    isPosting.value = true;
    try {
      Dio dio = Dio();

      debugPrint(token);
      dio.options.headers["Authorization"] = token;
      Map<String, String> data = {"text": comment ?? controller.text};
      var resposne = await dio.post(ApiEndpoint.replyPost(postId, commentID, userId!), data: data);
      log(resposne.toString());
      isPosting.value = false;
      controller.clear();
      //  debugPrint(resposne.data.toString());
      isPosting.value = false;
      final Comment commentx = Comment.fromJson(resposne.data["comment"]);
      socketController.sendCommentNotification(postuID, true, null, true);
      debugPrint(commentx.text);
      return commentx;
    } catch (e) {
      isPosting.value = false;
      //   update();
      return Comment();
    }
  }
}
