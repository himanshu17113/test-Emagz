


import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePostsController extends GetxController{
  ScrollController scrollController = ScrollController();

  var jwtController = Get.put(JWTController());
 // String? userId;
  
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
  RxList<Post>? posts;
  RxInt skip =RxInt(-10);

  Future<List<Post>> getPost() async{
      skip.value += 10;

      try{
        Dio dio = Dio();
        // var token = await jwtController.getAuthToken();
        // userId = await jwtController.getUserId();
        dio.options.headers["Authorization"] = token;
      //  print(ApiEndpoint.posts(skip.value));
        var endPoint = ApiEndpoint.posts(skip.value);
        var resposne = await dio.get(endPoint);
        if(resposne.data['AllPost']!=null){
          resposne.data["AllPost"].forEach((e) {
            posts ??= RxList();
            // rating is at 159 post
            var post = Post.fromJson(e);
            //print(post.mediaUrl!);

            if(post.user != null){
              posts!.insert(0,post);
            }
          });

          return posts!.reversed.toList();
        }
        return [];
    }catch(e){
        print('hey');
       print(e);
        return [];
      }
  }
 
  Future<List<Post>> refreshResent() async{
      skip.value = -10;
      if(posts==null){

      }
      else
        {
          posts!.value=[];
        }
    //  print(skip.value);
      try{
        Dio dio = Dio();
        // var token = await jwtController.getAuthToken();
        // userId = await jwtController.getUserId();
        dio.options.headers["Authorization"] = token;
    //    print(ApiEndpoint.posts(skip.value));
        var endPoint = ApiEndpoint.posts(0);
        var resposne = await dio.get(endPoint);

        resposne.data["AllPost"].forEach((e) {

          posts ??= RxList();
          // rating is at 159 post
          try {
            print(e);
            var post = Post.fromJson(e);
              posts!.add(post);

          }
          catch(ee)
          {
            print('eor');
            print(ee);
          }
          // print(post.mediaUrl);

        });


        return posts!.reversed.toList();
    }catch(e){
        print('eroror');
        print(e);
        return [];
      }
  }

  Future<bool> likePost(String postId) async{
    try{
      Dio dio = Dio();
      // print(ApiEndpoint.likePost(postId));
      // var token = await JWTController().getAuthToken();
      // var userId = await JWTController().getUserId();
      dio.options.headers["authorization"] = token;
      var data = {
        "userId": userId,
      };
      var response = await dio.post(ApiEndpoint.likePost(postId), data: data);
    //  print(response.data);
      return true;
    }catch(e) {
    //  print(e);
      return false;
    }
  }

  Future postPoll(String postId,String vote) async{
    try{
      // var userId = await JWTController().getUserId();
      // var token = await JWTController().getAuthToken();
      Dio dio = Dio();
      print(ApiEndpoint.doPoll(postId));
      var data = {"vote": vote,"userId":userId};
      dio.options.headers["Authorization"]  = token;
      var response = await dio.post(ApiEndpoint.doPoll(postId), data: data);
      print(response.data);
      return true;
    }catch(e) {
      print(e);
      return false;
    }
  }


}