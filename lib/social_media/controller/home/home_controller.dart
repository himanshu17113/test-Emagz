import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/model/poll_model.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomePostsController extends GetxController {
  final ScrollController scrollController = ScrollController();
  bool ispostloading = false;
  final socketController = Get.put(SocketController());
  String? token;
  String? userId;
  bool endOfPost = false;
  bool isVisible = true;
  int page = 0;
  List<Post>? posts = [];
  int skip = -10;
  @override
  onInit() async {
    token = globToken;
    userId = globUserId;
    if (token != null) {
      dioheader();
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
          update(['bottom_Nav', 'appbar']);
        }
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isVisible) {
          isVisible = true;
          update(["bottom_Nav", "appbar"]);
        }
      }
      loadMoreData();
    });

    super.onInit();
  }

  final Dio dio = Dio();
  dioheader() => dio.options.headers["Authorization"] = token;
  void pageUpdate(int i) {
    page = i;
    update(['bottom_Nav']);
  }

  loadMoreData() async {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !ispostloading &&
        !endOfPost) {
      await getPost();
    } else if (scrollController.position.pixels ==
        scrollController.position.minScrollExtent - 50) {}
  }

  getPost() async {
    ispostloading = true;

    skip = skip + 10;

    try {
      debugPrint(globToken);
      final String endPoint = ApiEndpoint.posts(skip);
      debugPrint(endPoint.toString());
      var resposne = await dio.get(endPoint);
      int len = posts!.length;
      if (resposne.data['AllPost'] != null &&
          resposne.data["AllPost"] is List) {
        resposne.data["AllPost"].forEach((e) {
          Post? post;
          try {
            post = Post.fromJson(e);
          } catch (err) {
            debugPrint('here');
            debugPrint(err.toString());
            ispostloading = false;
          }

          if (post?.user != null) {
            posts!.add(post!);
          }
        });
        debugPrint(posts?.length.toString());

        if (len + 10 != posts!.length) {
          endOfPost = true;
        }
        update(['HomePosts']);
        ispostloading = false;
      }
    } catch (e) {
      debugPrint('hey get post not working');

      ispostloading = false;
    }
  }

  Future<List<Post>> refreshResent() async {
    skip = -10;
    try {
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

  Future<bool> likePost(
      String postId, int index, bool islike, String uid) async {
    // if (!islike) {
    //   posts![index].likeCount! - 1;
    //   posts![index].isLike = false;
    // } else {
    //   posts![index].likeCount! + 1;
    //   posts![index].isLike = true;
    // }

    if (islike) {
      socketController.sendLikeNotification(
          uid, constuser?.username ?? constuser?.displayName ?? "");
    }
    try {
      var data = {
        "userId": userId,
      };
      var response = await dio.post(ApiEndpoint.likePost(postId), data: data);
      debugPrint(response.data);
      update([index]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Poll?> postPoll(String postId, String vote) async {
    try {
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

  Future<Map<String, String>?> postCustomPoll(
      String postId, String vote) async {
    try {
      debugPrint(ApiEndpoint.doPoll(postId));
      var data = {"vote": vote, "userId": userId};
      var response = await dio.post(ApiEndpoint.doPoll(postId), data: data);
      debugPrint(response.data.toString());
 
      return customPolldetail(postId);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<Poll?> Polldetail(String postId) async {
    try {
      var response = await dio.get(
        ApiEndpoint.pollResults(postId),
      );

      Poll poll = Poll.fromMap(response.data);

      return poll;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<Map<String, String>?> customPolldetail(String postId) async {
    try {
      var response = await dio.get(
        ApiEndpoint.pollResults(postId),
      );

      Poll poll = Poll.fromMap(response.data);
      Map<String, String> map = {
        "isVoted": (poll.isVoted ?? false) ? "True" : "False"
      };
      poll.postx?.customPollData?.forEach((element) {
        debugPrint(response.data["pollCalculation"][element]);
        map.addIf(response.data["pollCalculation"][element] != null, element,
            response.data["pollCalculation"][element]);
      });
     
      return map;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
