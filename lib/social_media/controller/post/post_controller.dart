import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/controller/bottom_nav_controller.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/pre_post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;

import 'package:path_provider/path_provider.dart';

enum PostAssetType { image, video, text }

class PostController extends GetxController {
  TextEditingController captionController = TextEditingController();
  RxDouble uploadPercentage = RxDouble(0);
  RxString privacyLikesAndViews = RxString("hideFromEveryone");
  RxString privacyLikesAndViewsUI = RxString("Everyone");
  PostAssetType? assetType;
  Uint8List? imagePath;
  String? textPost;
  Rx<PostType>? currentType;
  RxBool isSettingImage = false.obs;
  RxString likeAndView = "Everyone".obs;
  // RxList<String>
  RxString mediaType = "".obs;
  RxString imagePathUpload = "".obs;
  // RxBool enabledPoll = false.obs;
  RxBool isPosting = RxBool(false);

  var jwtController = Get.put(JWTController());
  var bottomNavController = Get.put(NavController());

  Future setPost(image, PostAssetType assetType) async {
    isSettingImage.value = true;
    if (assetType == PostAssetType.text) {
      textPost = image;
    } else {
      imagePath = image;
    }
    this.assetType = assetType;
    isSettingImage.value = false;
    //update();
  }

  Future makePost(
    bool enablePoll,
    String tagPrivacy,
    String? setTimer,
  ) async {
    isPosting.value = true;

    try {
      // if(setTimer == "-1"){
      //   CustomSnackbar.show("please setTimer");
      //   isPosting.value = false;
      //   return;
      // }
      // if(captionController.text == ""){
      //   CustomSnackbar.show("please fill captions");
      //   isPosting.value = false;
      //   return;
      // }

      Dio dio = Dio();
      print(privacyLikesAndViews.value);
      var token = await jwtController.getAuthToken();
      var userId = await jwtController.getUserId();
      dio.options.headers["Authorization"] = token;
      //todo : Remove The New File Making Process With Filtered File
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.png').create();
      if (assetType != PostAssetType.text) {
        Uint8List imageInUnit8List = imagePath!;

        file.writeAsBytesSync(imageInUnit8List);
      }
      print(
        file.path.toString(),
      );

      FormData reqData = FormData.fromMap({
        "userId": userId,
        "mediaType": "image",
        // assetType.toString().split(".")[1].substring(0),
        "mediaUrl": MultipartFile.fromFileSync(
          assetType == PostAssetType.text ? textPost! : file.path.toString(),
        ),

        "Enabledpoll": enablePoll ? true : false,

        //  "setTimer": enablePoll ? setTimer:"",
        "caption": captionController.text,

        "ShowPollResults": true,

        "privacy": '{"everyone": false, "followers": true, "no_one": false}',
        "post_hide": "[]",
        "tag_privacy":
            '{"everyone": false, "followers": true, "no_one": false}',
        "pollDuration": 2,
        "tags": "[]",
        "tagPeople": "[]"
      });

      await dio.post(
        ApiEndpoint.makePost,
        data: reqData,
        onSendProgress: (count, total) {
          uploadPercentage.value = (count / total);
        },
      );
      //print(reqData.toString());
      uploadPercentage.value = 0.0;

      CustomSnackbar.showSucess("Post  successful");
      isPosting.value = false;
      bottomNavController.pageUpdate(0);
      Get.offAll(() => const BottomNavBar());
    } catch (e) {
      //print(reqData.toString());
      uploadPercentage.value = 0.0;
      isPosting.value = false;
      Get.snackbar("Cant Post", "Some Internal Error");
      print("posting video error $e");
    }
  }

  Future makelPost(
    bool enablePoll,
    String tagPrivacy,
    String? setTimer,
  ) async {
    isPosting.value = true;

    try {
      // if(setTimer == "-1"){
      //   CustomSnackbar.show("please setTimer");
      //   isPosting.value = false;
      //   return;
      // }
      // if(captionController.text == ""){
      //   CustomSnackbar.show("please fill captions");
      //   isPosting.value = false;
      //   return;
      // }

      Dio dio = Dio();
      print(privacyLikesAndViews.value);
      var token = await jwtController.getAuthToken();
      var userId = await jwtController.getUserId();
      dio.options.headers["Authorization"] = token;
      //todo : Remove The New File Making Process With Filtered File
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.png').create();
      if (assetType != PostAssetType.text) {
        Uint8List imageInUnit8List = imagePath!;

        file.writeAsBytesSync(imageInUnit8List);
      }

      FormData reqData = FormData.fromMap({
        "userId": userId,
        "mediaType": assetType.toString().split(".")[1].substring(0),
        "mediaUrl": MultipartFile.fromFileSync(
          assetType == PostAssetType.text ? textPost! : file.path.toString(),
        ),
        "Enabledpoll": enablePoll ? "yes" : "no",
        "ShowPollResults": "yes",
        //    "setTimer": enablePoll ? setTimer : "",
        "caption": captionController.text,
        "privacy": {
          "likesAndViews": privacyLikesAndViews.value,
          "hideLikeAndViewsControl": "0"
        },
        "tagPrivacy": tagPrivacy,
        "pollDuration": "0",
      });
      await dio.post(
        ApiEndpoint.makePost,
        data: reqData,
        onSendProgress: (count, total) {
          uploadPercentage.value = (count / total);
        },
      );
      uploadPercentage.value = 0.0;

      CustomSnackbar.showSucess("Post  successful");
      isPosting.value = false;
      bottomNavController.pageUpdate(0);
      Get.offAll(() => const BottomNavBar());
    } catch (e) {
      uploadPercentage.value = 0.0;
      isPosting.value = false;
      Get.snackbar("Cant Post", "Some Internal Error");
      print("posting video error $e");
    }
  }

  // createPost() async {
  //   try {
  //     var headers = {'Content-Type': 'application/json'};
  //     var request =
  //         http.Request('POST', Uri.parse('http://localhost:3000/api/post/'));
  //     request.body = json.encode({
  //       "userId": "646b48233e167cca56acd355",
  //       "mediaType": "image",
  //       "mediaUrl": "family image here",
  //       "Enabledpoll": "yes",
  //       "ShowPollResults": "yes",
  //       "setTimer": "3",
  //       "caption": "it is my first post",
  //       "privacy": {
  //         "likesAndViews": "peopleYouFollow",
  //         "hideLikeAndViewsControl": "0"
  //       },
  //       "tagPrivacy": "noOne",
  //       "pollDuration": "3"
  //     });
  //     request.headers.addAll(headers);
  //
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       print(await response.stream.bytesToString());
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } catch (e) {}
  // }
}
