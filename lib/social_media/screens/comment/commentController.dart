import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentController extends GetxController{

  Rx<List<Comment>> instantComments = Rx<List<Comment>>([]);

  var jwtController = Get.put(JWTController());

  RxBool isPosting = RxBool(false);
  TextEditingController controller = TextEditingController();
  Future<bool> postComment(String postId)async{
    var comment = controller.text;
    if(comment == ""){
      Get.snackbar("Invalid Comment", "Cant post Empty Comment");
      return false;
    }
    isPosting.value = true;
    try{
      Dio dio = Dio();
      var token = await jwtController.getAuthToken();
      var userId = await jwtController.getUserId();
      dio.options.headers["Authorization"] = token;
      var data = {
        "userId": userId,
        "text" : comment
      };
      await dio.post(ApiEndpoint.commentPost(postId),data: data);
      isPosting.value = false;
      controller.clear();
      instantComments.value.add(Comment(text: comment,userId: UserSchema(sId: userId) ,comments: [],sId: userId));
      update();
      return false;
    }catch(e){
      isPosting.value = false;
      update();
      return false;
    }
  }
}