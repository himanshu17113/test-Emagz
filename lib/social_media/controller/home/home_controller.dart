import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomePostsController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
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
  RxInt skip = RxInt(-10);

  Future<List<Post>> getPost() async {
    skip.value += 10;

    try {
      Dio dio = Dio();
      // var token = await jwtController.getAuthToken();
      // userId = await jwtController.getUserId();
      dio.options.headers["Authorization"] =
          token ?? await jwtController.getAuthToken();
      debugPrint("lllll🧣🧣🧣🧣🧣🧣🧣🧣🧣lll");
      //  debugPrint(ApiEndpoint.posts(skip.value));
      final String endPoint = ApiEndpoint.posts(skip.value);
      debugPrint("pppppppppppppppp🧣🧣🧣🧣🧣🧣🧣🧣🧣pppppppp");
      print(endPoint);
      var resposne = await dio.get(endPoint);
   //   logger.d(resposne.data);
      if (resposne.data['AllPost'] != null &&
          resposne.data["AllPost"] is List) {
        resposne.data["AllPost"].forEach((e) {
          posts ??= RxList();
          // rating is at 159 post
          var post;
          try {
            post = Post.fromJson(e);
          } catch (err) {
            print('here');
            print(err.toString());
          }
          //debugPrint(post.mediaUrl!);

          if (post.user != null) {
            posts!.insert(0, post);
          }
        });

        return posts!.reversed.toList();
      }
      return [];
    } catch (e) {
      debugPrint('hey get post not working');
      debugPrint(e.toString());
      return [];
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

  Future<bool> likePost(String postId) async {
    try {
      Dio dio = Dio();
      // debugPrint(ApiEndpoint.likePost(postId));
      // var token = await JWTController().getAuthToken();
      // var userId = await JWTController().getUserId();
      dio.options.headers["authorization"] = token;
      var data = {
        "userId": userId,
      };
      var response = await dio.post(ApiEndpoint.likePost(postId), data: data);
      //  debugPrint(response.data);
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
      debugPrint(response.data);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
