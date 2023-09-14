import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/model/poll_model.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

//import '../../../model/poll_model.dart';

class HomePostsController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
final  ScrollController scrollController = ScrollController();
  bool ispostloading = false;
  final jwtController = Get.find<JWTController>();
  final socketController = Get.put(SocketController());
  // String? userId;

  @override
  onInit() async {
    await storedData();
    await getPost();
    if (posts!.length < 2) {
      //  postController.audiovideopostList.clear();
      //  print("gggggggggggvvvvvvvvvvvvvv");
      getPost();
      //  setState(() {});
    }
    scrollController.addListener(() {
      loadMoreData();
    });
    //  getPost();
    super.onInit();
  }

  String? token;
  String? userId;
  Future<void> storedData() async {
    token = await jwtController.getAuthToken();
    userId = await jwtController.getUserId();
  }

  loadMoreData() async {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !ispostloading) {
      await getPost();
    } else if (scrollController.position.pixels == scrollController.position.minScrollExtent - 50) {}
  }

  RxList<Post>? posts = <Post>[].obs;
  RxInt skip = RxInt(-10);

  getPost() async {
    ispostloading = true;
    // if (skip.value == -10) {

    // } else {

    // }
    skip.value = skip.value + 10;

    try {
      Dio dio = Dio();
      // var token = await jwtController.getAuthToken();
      // userId = await jwtController.getUserId();
      dio.options.headers["Authorization"] = token ?? await jwtController.getAuthToken();
      debugPrint("lllll🧣🧣🧣🧣🧣🧣🧣🧣🧣lll");
      //  debugPrint(ApiEndpoint.posts(skip.value));
      final String endPoint = ApiEndpoint.posts(skip.value);
      debugPrint("pppppppppppppppp🧣🧣🧣🧣🧣🧣🧣🧣🧣pppppppp");
      print(endPoint);
      var resposne = await dio.get(endPoint);
      // logger.d(resposne.data);
      if (resposne.data['AllPost'] != null && resposne.data["AllPost"] is List) {
        resposne.data["AllPost"].forEach((e) {
          Post? post;
          try {
            post = Post.fromJson(e);
          } catch (err) {
            print('here');
            print(err.toString());
            ispostloading = false;
          }
          //debugPrint(post.mediaUrl!);

          if (post?.user != null) {
            posts!.add(post!);
          }
        });
        ispostloading = false;
        //   return posts!.reversed.toList();
      }
      //   return [];
    } catch (e) {
      debugPrint('hey get post not working');
      //    debugPrint(e.toString());
      //   return [];
      ispostloading = false;
    }
  }

  Future<List<Post>> refreshResent() async {
    skip.value = -10;
    try {
      Dio dio = Dio();
      // var token = await jwtController.getAuthToken();
      // userId = await jwtController.getUserId();
      dio.options.headers["Authorization"] = token;
      //  debugPrint(ApiEndpoint.posts(skip.value));
      var endPoint = ApiEndpoint.posts(0);
      var resposne = await dio.get(endPoint);
      if (resposne.data['AllPost'] != null) {
        resposne.data["AllPost"].forEach((e) {
          posts ??= RxList();
          // rating is at 159 post
          var post = Post.fromJson(e);
          //debugPrint(post.mediaUrl!);

          if (post.user != null) {
            posts!.insert(0, post);
          }
        });

        return posts!.reversed.toList();
      }
      return [];
    } catch (e) {
      debugPrint('GET post error');
      debugPrint(e.toString());
      return [];
    }
    // if (posts == null) {
    // } else {
    //   posts!.value = [];
    // }
    // //  debugPrint(skip.value);
    // try {
    //   Dio dio = Dio();
    //   // var token = await jwtController.getAuthToken();
    //   // userId = await jwtController.getUserId();
    //   dio.options.headers["Authorization"] = token;
    //   //    debugPrint(ApiEndpoint.posts(skip.value));
    //   var endPoint = ApiEndpoint.posts(0);
    //   var resposne = await dio.get(endPoint);
    //
    //   resposne.data["AllPost"].forEach((e) {
    //     posts ??= RxList();
    //     // rating is at 159 post
    //     try {
    //       debugPrint(e);
    //       var post = Post.fromJson(e);
    //       posts!.add(post);
    //     } catch (ee) {
    //       debugPrint('eor');
    //       debugPrint(ee.toString());
    //     }
    //     // debugPrint(post.mediaUrl);
    //   });
    //
    //   return posts!.reversed.toList();
    // } catch (e) {
    //   debugPrint('eroror');
    //   debugPrint(e.toString());
    //   return [];
    // }
  }

  Future<bool> likePost(String postId, bool islike, String uid) async {
      if (islike) {
      socketController.sendLikeNotification(uid, jwtController.user?.value.username ?? jwtController.user?.value.displayName ?? "");
    }
    try {
      Dio dio = Dio();
    
      dio.options.headers["authorization"] = token;
      var data = {
        "userId": userId,
      };
      var response = await dio.post(ApiEndpoint.likePost(postId), data: data);
      debugPrint(response.data);
    
      return true;
    } catch (e) {
      //  debugPrint(e);
      return false;
    }
  }

  Future postPoll(String postId, String vote) async {
    try {
      // var userId = await JWTController().getUserId();
      // var token = await JWTController().getAuthToken();
      Dio dio = Dio();
      debugPrint(ApiEndpoint.doPoll(postId));
      var data = {"vote": vote, "userId": userId};
      dio.options.headers["Authorization"] = token;
      var response = await dio.post(ApiEndpoint.doPoll(postId), data: data);
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        Polldetail(postId);
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future Polldetail(String postId) async {
    try {
      // var userId = await JWTController().getUserId();
      // var token = await JWTController().getAuthToken();
      Dio dio = Dio();
      debugPrint(ApiEndpoint.doPoll(postId));
      // var data = {"vote": vote, "userId": userId};
      dio.options.headers["Authorization"] = token;
      var response = await dio.get(
        ApiEndpoint.pollResults(postId),
      );
      Poll poll = Poll.fromJson(response.data);
      print(json.encode(response.data));
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
