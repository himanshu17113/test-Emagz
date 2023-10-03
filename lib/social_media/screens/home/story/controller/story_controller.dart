import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/model/story_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:http/http.dart' as http;

class GetXStoryController extends GetxController {
  RxInt currentStoryIndex = RxInt(0);
  RxList<Story>? stories = <Story>[].obs;
  List<Stories> mystory = [];
  String? myId;
  RxDouble storyUploadPercentage = RxDouble(0);
  RxBool isUploading = RxBool(false);
  String? token;
  final JWTController jwtController = Get.find<JWTController>();
  @override
  void onInit() {
   // if (jwtController.isAuthorised.value ) {
      getStories();
  //  }

    super.onInit();
  }

  getStories() async {
    //try {
    stories?.clear();

    debugPrint("🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣   getStories");
    debugPrint(ApiEndpoint.story);

    if (jwtController.token == null ||
        jwtController.token!.isEmpty ||
        jwtController.userId == null) {
      token = await jwtController.getAuthToken();
      myId = await jwtController.getUserId();
    }

    await getmyStories();
    //   debugPrint(token);

    final headers = {
      'Content-Type': 'application/json',
      "Authorization": jwtController.token ?? token!
    };

    http.Response response =
        await http.get(Uri.parse(ApiEndpoint.story), headers: headers);
    var body = jsonDecode(response.body);
    // debugPrint(body.toString());
    body.forEach((e) {
      debugPrint('story');
      // stories ??= Map();
      // debugPrint(e.toString());
      var story = Story.fromJson(e);
      // print(story);
      stories?.add(story);
      // if (stories![story.userId!] == null) {
      //   stories![story.userId] = {};
      // }
      // stories![story.userId!]![story.sId!] = story;
    });
    // debugPrint(stories.toString());
    //
    //    return stories!;
    // } catch (e) {
    //   debugPrint('stoey all post errror');
    //   debugPrint(e.toString());
    //   //return null;
    // }
  }

  Future<List<Story?>?> getmyStories() async {
    try {
      //stories?.clear();
      debugPrint("🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣 id");
      // if (myId.value == "" || token == null) {
      debugPrint(ApiEndpoint.story);
      if (jwtController.token == null ||
          jwtController.token!.isEmpty ||
          jwtController.userId == null) {
        token = await jwtController.getAuthToken();
        myId = await jwtController.getUserId();
      }
      debugPrint("TOKEN : $token myId : $myId");
      debugPrint(
          "TOKEN : ${jwtController.token} userId : ${jwtController.userId}");
      final headers = {
        'Content-Type': 'application/json',
        "Authorization": jwtController.token ?? token!
      };
      debugPrint(ApiEndpoint.Storybyid(jwtController.userId?? myId!));
      http.Response response = await http.get(
          Uri.parse(ApiEndpoint.Storybyid(jwtController.userId ?? myId!)),
          headers: headers);
      var body = jsonDecode(response.body);
      //  debugPrint(body.toString());

      //debugPrint('story');
      // stories ??= Map();

      var story = Story.fromJson(body["data"]);
      stories?.add(story);
      // if (stories![story.userId!] == null) {
      //   stories![story.userId] = {};
      // }
      // stories![story.userId!]![story.sId!] = story;

      //   debugPrint(stories.toString());
      return stories!;
    } catch (e) {
      debugPrint('stoey erreoe');
      debugPrint(e.toString());
      return null;
    }
  }
  // Future<List<Stories>> getmymyStories() async {
  //   try {
  //     debugPrint("🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣 id");
  //     // if (myId.value == "" || token == null) {
  //     debugPrint(ApiEndpoint.story);
  //     final token = await jwtController.getAuthToken();
  //     debugPrint(token);
  //     myId.value = (await jwtController.getUserId())!;
  //     //  }
  //     final headers = {'Content-Type': 'application/json', "Authorization": token!};

  //     http.Response response = await http.get(Uri.parse(ApiEndpoint.Storybyid(myId.value)), headers: headers);
  //     var body = jsonDecode(response.body);
  //     debugPrint(body.toString());

  //     debugPrint('story');
  //     // stories ??= Map();

  //     var story = Stories.fromJson(body["data"]["stories"]);
  //     mystory.add(story);
  //     // if (stories![story.userId!] == null) {
  //     //   stories![story.userId] = {};
  //     // }
  //     // stories![story.userId!]![story.sId!] = story;

  //     debugPrint(stories.toString());
  //     return mystory!;
  //   } catch (e) {
  //     debugPrint('stoey');
  //     debugPrint(e.toString());
  //     return mystory;
  //   }
  // }

  likeStory(String storyId) async {
    try {
      var token = await jwtController.getAuthToken();
      var userId = await jwtController.getUserId();
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": token!
      };
      Map body = {"userId": userId};
      http.Response response = await http.post(
          Uri.parse(ApiEndpoint.likeStroy(storyId)),
          headers: headers,
          body: jsonEncode(body));
      if (response.statusCode != 200) {
        CustomSnackbar.show("can't like the story");
      }
    } catch (e) {
      debugPrint(e.toString());
      CustomSnackbar.show("can't like the story");
    }
  }

  commentStory(String text, String storyId) async {
    var token = await jwtController.getAuthToken();
    var userId = await jwtController.getUserId();
    debugPrint("story : $storyId");
    var headers = {'Content-Type': 'application/json', "Authorization": token!};
    Map body = {"userId": userId, "text": text};
    http.Response response = await http.post(
        Uri.parse(ApiEndpoint.commentStroy(storyId)),
        headers: headers,
        body: jsonEncode(body));
    debugPrint(response.body);
  }

  Future<bool> postStory(String type, String filePath) async {
    try {
      storyUploadPercentage.value = 0;
      isUploading.value = true;
      debugPrint(filePath);
      var token = await jwtController.getAuthToken();
      var userId = await jwtController.getUserId();
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;
      var file = MultipartFile.fromFileSync(filePath);
      FormData data = FormData.fromMap({
        "userId": userId,
        "mediaType": type,
        "mediaUrl": file,
      });
      var response = await dio.post(
        options: Options(sendTimeout: const Duration(milliseconds: 4000)),
        ApiEndpoint.addStory,
        data: data,
        onSendProgress: (count, total) {
          storyUploadPercentage.value = (count / total);
        },
      );
      if (response.statusCode != 200) {
        debugPrint("error");
        // Get.back();
        storyUploadPercentage.value = 0;
        CustomSnackbar.show("can't upload story");
        return false;
      }
      if (response.statusCode == 200) {
        Get.back();
        getStories();
        // Get.back();
        storyUploadPercentage.value = 0;
        CustomSnackbar.showSucess("story uploaded");
        return true;
      }
      isUploading.value = false;
    } catch (e) {
      debugPrint("error");
      Get.back();
      debugPrint(e.toString());
      CustomSnackbar.show("can't upload file");
      storyUploadPercentage.value = 0;
      isUploading.value = false;
      return false;
    }
    return false;
  }
}
