import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/model/poll_model.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomePostsController extends GetxController {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final ScrollController scrollController = ScrollController();
  bool ispostloading = false;
  final jwtController = Get.put(JWTController());
  final socketController = Get.put(SocketController());
  String? token;
  String? userId;
 // RxBool isVisible = RxBool(true);
  bool isVisible = true;
  int page = 0;
  List<Post>? posts = [];

  RxInt skip = RxInt(-10);
  @override
  onInit() async {
    await storedData();
    if (token != null) {
      await getPost();
      if (posts!.length < 2) {
        getPost();
      }
    }
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible) {
          isVisible = false;
          update();
        }
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isVisible) {
          isVisible = true;
          update();
        }
      }
      loadMoreData();
    });

    super.onInit();
  }

  void pageUpdate(int i) {
    page = i;
    update();
  }

  Future<void> storedData() async {
    token = await jwtController.getAuthToken();
    userId = await jwtController.getUserId();
  }

  loadMoreData() async {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !ispostloading) {
      await getPost();
    } else if (scrollController.position.pixels ==
        scrollController.position.minScrollExtent - 50) {}
  }

  getPost() async {
    ispostloading = true;

    skip.value = skip.value + 10;

    try {
      Dio dio = Dio();

      dio.options.headers["Authorization"] =
          token ?? await jwtController.getAuthToken();
      debugPrint("lllll🧣🧣🧣🧣🧣🧣🧣🧣🧣lll");

      final String endPoint = ApiEndpoint.posts(skip.value);
      debugPrint("pppppppppppppppp🧣🧣🧣🧣🧣🧣🧣🧣🧣pppppppp");
      print(endPoint);
      var resposne = await dio.get(endPoint);

      if (resposne.data['AllPost'] != null &&
          resposne.data["AllPost"] is List) {
        resposne.data["AllPost"].forEach((e) {
          Post? post;
          try {
            post = Post.fromJson(e);
          } catch (err) {
            print('here');
            print(err.toString());
            ispostloading = false;
          }

          if (post?.user != null) {
            posts!.add(post!);
          }
        });
        update();
        ispostloading = false;
      }
    } catch (e) {
      debugPrint('hey get post not working');

      ispostloading = false;
    }
  }

  Future<List<Post>> refreshResent() async {
    skip.value = -10;
    try {
      Dio dio = Dio();

      dio.options.headers["Authorization"] = token;

      var endPoint = ApiEndpoint.posts(0);
      var resposne = await dio.get(endPoint);
      if (resposne.data['AllPost'] != null) {
        resposne.data["AllPost"].forEach((e) {
          posts ??= RxList();

          var post = Post.fromJson(e);

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
  }

  Future<bool> likePost(String postId, bool islike, String uid) async {
    if (islike) {
      socketController.sendLikeNotification(
          uid,
          jwtController.user?.value.username ??
              jwtController.user?.value.displayName ??
              "");
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
      return false;
    }
  }

  Future<Poll?> postPoll(String postId, String vote) async {
    try {
      Dio dio = Dio();
      debugPrint(ApiEndpoint.doPoll(postId));
      var data = {"vote": vote, "userId": userId};
      dio.options.headers["Authorization"] = token;
      var response = await dio.post(ApiEndpoint.doPoll(postId), data: data);
      debugPrint(response.data.toString());

      return Polldetail(postId);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<Poll?> Polldetail(String postId) async {
    try {
      Dio dio = Dio();

      dio.options.headers["Authorization"] = token;
      var response = await dio.get(
        ApiEndpoint.pollResults(postId),
      );

      Poll poll = Poll.fromMap(jsonDecode(jsonEncode(response.data)));

      return poll;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
