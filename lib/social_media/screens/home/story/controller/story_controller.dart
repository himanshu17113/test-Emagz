import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/screens/home/story/model/story_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../../../constant/data.dart';

class GetXStoryController extends GetxController {
  RxInt currentStoryIndex = RxInt(0);
  List<Story>? stories = <Story>[];
  List<Uint8List> images = [];
  RxBool imagesNotEmpty = RxBool(false);
  List<Stories> mystory = [];
  String? myId;
  RxDouble storyUploadPercentage = RxDouble(0);
  RxBool isUploading = RxBool(false);
  String? token;
  List<String> imagePaths = [];
  @override
  void onInit() {
    getStories();

    super.onInit();
  }

  getStories() async {
    stories?.clear();

    debugPrint(ApiEndpoint.story);

    if (globToken == null || globUserId == null) {
      token = await HiveDB.getAuthToken();
      myId = await HiveDB.getUserID();
    }
    if (globToken != null) {
      await getmyStories();

      final headers = {
        'Content-Type': 'application/json',
        "Authorization": globToken ?? token!
      };

      http.Response response =
          await http.get(Uri.parse(ApiEndpoint.story), headers: headers);
      var body = jsonDecode(response.body);
      debugPrint(body.toString());
      body.forEach((e) {
        debugPrint('story');

        var story = Story.fromJson(e);

        stories?.add(story);
      });
      update(["storylist"]);
    }
  }

  Future<List<Story?>?> getmyStories() async {
    try {
      debugPrint("🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣🧣 id");

      debugPrint(ApiEndpoint.story);
      if (globToken == null || globToken!.isEmpty || globUserId == null) {
        token = await HiveDB.getAuthToken();
        myId = await HiveDB.getUserID();
      }
     
      final headers = {
        'Content-Type': 'application/json',
        "Authorization": globToken ?? token!
      };
      debugPrint(ApiEndpoint.Storybyid(globUserId ?? myId!));
      http.Response response = await http.get(
          Uri.parse(ApiEndpoint.Storybyid(globUserId ?? myId!)),
          headers: headers);
      var body = jsonDecode(response.body);
   //   debugPrint("sto ${body.toString()}");
      var story = Story.fromJson(body["data"]);
      stories?.add(story);

      return stories!;
    } catch (e) {
      debugPrint('stoey erreoe');
      debugPrint(e.toString());
      return null;
    }
  }

  likeStory(String storyId) async {
    try {
      var token = await HiveDB.getAuthToken();
      var userId = await HiveDB.getUserID();
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
    var token = await HiveDB.getAuthToken();
    var userId = await HiveDB.getUserID();
    debugPrint("story : $storyId");
    var headers = {'Content-Type': 'application/json', "Authorization": token!};
    Map body = {"userId": userId, "text": text};
    http.Response response = await http.post(
        Uri.parse(ApiEndpoint.commentStroy(storyId)),
        headers: headers,
        body: jsonEncode(body));
    debugPrint(response.body);
  }

  Future<void> addPost(List<Uint8List> imagex) async {
    imagePaths.clear();
    for (var i = 0; i < imagex.length; i++) {
      final tempDir = await getTemporaryDirectory();
      File imageFile = await File('${tempDir.path}/image$i.jpg').create();
      await imageFile.writeAsBytes(imagex[i]);

      imagePaths.add(imageFile.path);
    }
  }

  Future<bool> postStory(String type, List<Uint8List> filePath) async {
    try {
      await addPost(filePath);
      debugPrint("hhhhhhhhhhhhhhhhhhhhhhh ${imagePaths.toString()}");
      storyUploadPercentage.value = 0;
      isUploading.value = true;

      var token = await HiveDB.getAuthToken();
      var userId = await HiveDB.getUserID();
      Dio dio = Dio();
      dio.options.headers["Authorization"] = token;

      FormData data = FormData.fromMap({
        "userId": userId,
        "mediaType": "image",
        "mediaUrl": List.generate(imagePaths.length,
            (i) => MultipartFile.fromFileSync(imagePaths[i])),
      });
      debugPrint(" b bn bv v   v v");
      var response = await dio.post(
        ApiEndpoint.addStory,
        data: data,
      );
      debugPrint("error");
      debugPrint(response.toString());

      debugPrint(response.statusCode.toString());
      if (response.statusCode != 200) {
        storyUploadPercentage.value = 0;
        CustomSnackbar.show("can't upload story");
        return false;
      }
      if (response.statusCode == 200) {
        Get.back();
        getStories();

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
