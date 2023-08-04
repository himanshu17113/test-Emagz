import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  Rx<List<Comment>> instantComments = Rx<List<Comment>>([]);

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

  Future<bool> postComment(String postId) async {
    var comment = controller.text;
    if (comment == "") {
      Get.snackbar("Invalid Comment", "Cant post Empty Comment");
      return false;
    }
    isPosting.value = true;
    try {
      Dio dio = Dio();
      // var token = await jwtController.getAuthToken();
      // var userId = await jwtController.getUserId();
      dio.options.headers["Authorization"] = token;
      var data = {"userId": userId, "text": comment};
      var resposne = await dio.post(ApiEndpoint.commentPost(postId), data: data);

      isPosting.value = false;
      controller.clear();
      // instantComments.value.add(Comment(
      //     text: comment,
      //     userId: UserSchema(sId: userId),
      //     comments: [],
      //     sId: userId));

      //   update();
      return false;
    } catch (e) {
      isPosting.value = false;
      //   update();
      return false;
    }
  }

  Future<bool> postReply(String postId, String commentID, String? comment) async {
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
      print(token);
      dio.options.headers["Authorization"] = token;
      var data = {"text": comment ?? controller.text};
      var resposne = await dio.post(ApiEndpoint.replyPost(postId, commentID, userId!), data: data);
      print(resposne);
      isPosting.value = false;
      controller.clear();
      //    instantComments.value.add(Comment(text: comment, userId: UserSchema(sId: userId), comments: [], sId: userId));

      //  update();
      return false;
    } catch (e) {
      isPosting.value = false;
      //   update();
      return false;
    }
  }
}
