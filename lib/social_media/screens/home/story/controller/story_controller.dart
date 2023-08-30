import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/model/story_model.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:http/http.dart' as http;

class GetXStoryController extends GetxController {
  RxInt currentStoryIndex = RxInt(0);
  List<Story>? stories = [];
  RxString myId = RxString("");
  RxDouble storyUploadPercentage = RxDouble(0);
  RxBool isUploading = RxBool(false);

  var jwtController = Get.put(JWTController());

  Future<List<Story?>?> getStories() async {
    try {
      print(ApiEndpoint.story);
      var token = await jwtController.getAuthToken();
      print(token);
      myId.value = (await jwtController.getUserId())!;
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": token!
      };

      http.Response response =
          await http.get(Uri.parse(ApiEndpoint.story), headers: headers);
      var body = jsonDecode(response.body);
      print(body);
      body.forEach((e) {
        print('story');
        // stories ??= Map();
        print(e);
        var story = Story.fromJson(e);
        stories?.add(story);
        // if (stories![story.userId!] == null) {
        //   stories![story.userId] = {};
        // }
        // stories![story.userId!]![story.sId!] = story;
      });
      print(stories);
      return stories!;
    } catch (e) {
      print('stoey');
      print(e);
      return null;
    }
  }

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
      print(e);
      CustomSnackbar.show("can't like the story");
    }
  }

  commentStory(String text, String storyId) async {
    var token = await jwtController.getAuthToken();
    var userId = await jwtController.getUserId();
    print("story : $storyId");
    var headers = {'Content-Type': 'application/json', "Authorization": token!};
    Map body = {"userId": userId, "text": text};
    http.Response response = await http.post(
        Uri.parse(ApiEndpoint.commentStroy(storyId)),
        headers: headers,
        body: jsonEncode(body));
    print(response.body);
  }

  postStory(String type, String filePath) async {
    try {
      storyUploadPercentage.value = 0;
      isUploading.value = true;
      print(filePath);
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
        print("error");
        Get.back();
        storyUploadPercentage.value = 0;
        CustomSnackbar.show("can't upload story");
      }
      if (response.statusCode == 200) {
        Get.back();
        Get.back();
        storyUploadPercentage.value = 0;
        CustomSnackbar.showSucess("story uploaded");
      }
      isUploading.value = false;
    } catch (e) {
      print("error");
      Get.back();
      print(e);
      CustomSnackbar.show("can't upload file");
      storyUploadPercentage.value = 0;
      isUploading.value = false;
    }
  }
}
