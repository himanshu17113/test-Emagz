import 'dart:io';
import 'package:dio/dio.dart';
import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/pre_post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:path_provider/path_provider.dart';
import '../home/home_controller.dart';

class PostController extends GetxController {
  final TextEditingController captionController = TextEditingController();

  final TextEditingController button1Controller = TextEditingController();

  final TextEditingController button2Controller = TextEditingController();

  RxDouble uploadPercentage = RxDouble(0);
  RxString privacyLikesAndViews = RxString("hideFromEveryone");
  RxString privacyLikesAndViewsUI = RxString("Everyone");
  PostType? assetType;
  Uint8List? imagePath;
  List<Uint8List> images = [];
  List<String> imagePaths = [];
  String? textPost;
  RxBool isSettingImage = false.obs;
  RxString likeAndView = "Everyone".obs;

  RxBool isPosting = RxBool(false);
  final homePostsController = Get.find<HomePostsController>(tag: 'HomePostsController');

  Future setPost(image, PostType assetTyp) async {
    isSettingImage.value = true;
    if (assetTyp == PostType.text) {
      textPost = image;
    } else {
      imagePath = image;
    }
    assetType = assetTyp;
    isSettingImage.value = false;
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

  Future makePost(bool enablePoll, String tagPrivacy, int? setTimer, bool? isCustomPoll, List<Uint8List> images) async {
    isPosting.value = true;
    try {
      await addPost(images);

      Dio dio = Dio();
      debugPrint(privacyLikesAndViews.value);
      dio.options.headers["Content-Type"] = "application/json";
      dio.options.headers["Authorization"] = globToken ?? await HiveDB.getAuthToken();
      debugPrint(globToken);
      debugPrint(globUserId);

      debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $isCustomPoll");
      FormData reqData = FormData.fromMap({
        "userId": globUserId ?? await HiveDB.getUserID(),
        "mediaType": "image",
        "mediaUrl": List.generate(imagePaths.length, (i) => MultipartFile.fromFileSync(imagePaths[i])),
        "Enabledpoll": enablePoll,
        "caption": captionController.text,
        "ShowPollResults": true,
        "privacy": '{"everyone": true, "followers": false, "no_one": false}',
        "post_hide": "[]",
        "tag_privacy": '{"everyone":true,"followers":false,"no_one":false}',
        "pollDuration": DateTime.now().add(Duration(days: setTimer ?? 1)),
        "tags": "[]",
        "tagPeople": "[]",
        "customPollEnabled": isCustomPoll,
        "customPollData": '["${(button1Controller.text).toString()}", "${(button2Controller.text).toString()}"]'
      });

      var res = await dio.post(
        ApiEndpoint.makePost,
        data: reqData,
        onSendProgress: (count, total) {
          uploadPercentage.value = (count / total);
        },
      );
      debugPrint(res.statusMessage.toString());
      if (res.statusCode == 200) {
        uploadPercentage.value = 0.0;
        debugPrint("status : ${res.statusCode}");
        CustomSnackbar.showSucess("Post  successful");
        isPosting.value = false;
        homePostsController.skip = -10;

        homePostsController.posts?.clear();
        homePostsController.getPost();
        button1Controller.clear();
        button2Controller.clear();
        captionController.clear();
        homePostsController.pageUpdate(0);
        Get.offAll(() => BottomNavBar());
      } else {
        CustomSnackbar.show("Something went wrong :(");
      }
    } catch (e) {
      uploadPercentage.value = 0.0;
      isPosting.value = false;
      Get.snackbar("Cant Post", "Some Internal Error");
      debugPrint("posting video error $e");
    }
  }
}
