import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommentController extends GetxController {
  Rx<List<Comment>> instantComments = Rx<List<Comment>>([]);

  final jwtController = Get.put(JWTController());
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

  RxBool isPosting = RxBool(false);
  TextEditingController controller = TextEditingController();
  final focusNode = FocusNode();
  RxBool isCommentingOnPost = RxBool(true);
  RxString commentOwner = RxString("");
  RxInt commentindex = RxInt(0);
  RxString commentId = RxString("");
//  RxBool isSending = RxBool(false);
  setCommentId(String id, String commentedBy, int index) {
    commentId.value = id;
    commentOwner.value = commentedBy;
    commentindex.value = index;
    isCommentingOnPost.value = false;
    focusNode.requestFocus();
  }

  setedCommentIdclear() {
    isCommentingOnPost = RxBool(true);
    commentOwner = RxString("");
    commentindex = RxInt(5000000);
    commentId = RxString("");
    isCommentingOnPost.value = true;
    focusNode.unfocus();
  }

  Future<dynamic> postComment(String postId) async {
    var comment = controller.text;
    if (comment == "") {
      Get.snackbar("Invalid Comment", "Cant post Empty Comment");
      return "";
    }
    isPosting.value = true;
    try {
      Dio dio = Dio();
      // var token = await jwtController.getAuthToken();
      // var userId = await jwtController.getUserId();
      dio.options.headers["Authorization"] = token;
      var data = {"userId": userId, "text": comment};
      var resposne = await dio.post(ApiEndpoint.commentPost(postId), data: data);
      debugPrint(ApiEndpoint.commentPost(postId));
      debugPrint(data.toString());
      // print(resposne);
      List<dynamic> list = resposne.data["post"]["Comments"];

      isPosting.value = false;
      final Comment commentx = Comment.fromJson(list.last);
      return commentx;
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
      // var token = await jwtController.getAuthToken();
      // var userId = await jwtController.getUserId();
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

  commentStory(String storyId) async {
    var comment = controller.text;
    if (token == null) {
      token = await jwtController.getAuthToken();
      userId = await jwtController.getUserId();
    }

    debugPrint("story : $storyId");
    final headers = {'Content-Type': 'application/json', "Authorization": token!};
    debugPrint(ApiEndpoint.commentPost(storyId));
    Map body = {"userId": userId, "text": comment};
    http.Response response = await http.post(Uri.parse(ApiEndpoint.commentStroy(storyId)), headers: headers, body: jsonEncode(body));
    debugPrint(response.body);
    List<dynamic> list = jsonDecode(response.body)["stories"]["Comments"];
    // String s = list.last["_id"];
    // String s = list.last["text"];

    print("grrgf ${list.last}");
    isPosting.value = false;
    //  controller.clear();

    isPosting.value = false;
    //final Comment commentx = Comment.fromJson(jsonDecode(list.last));
    //  return commentx;
    return list.last["_id"];
  }

  replyStory(String postId, String commentID, String? comment) async {
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

      return false;
    } catch (e) {
      isPosting.value = false;

      return false;
    }
  }

  Future<dynamic> postReply(String postId, String commentID, String? comment) async {
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
      // var token = await jwtController.getAuthToken();
      // var userId = await jwtController.getUserId();
      debugPrint(token);
      dio.options.headers["Authorization"] = token;
      var data = {"text": comment ?? controller.text};
      var resposne = await dio.post(ApiEndpoint.replyPost(postId, commentID, userId!), data: data);
      debugPrint(resposne.toString());
      isPosting.value = false;
      controller.clear();

      isPosting.value = false;
      final Comment commentx = Comment.fromJson(resposne.data["comment"]);
      //    instantComments.value.add(Comment(text: comment, userId: UserSchema(sId: userId), comments: [], sId: userId));

      //  update();
      return commentx;
    } catch (e) {
      isPosting.value = false;
      //   update();
      return false;
    }
  }
}
