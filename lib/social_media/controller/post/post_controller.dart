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
import '../home/home_controller.dart';

class PostController extends GetxController {
  TextEditingController captionController = TextEditingController();

  TextEditingController button1Controller = TextEditingController();

  TextEditingController button2Controller = TextEditingController();

  TextEditingController button3Controller = TextEditingController();
  TextEditingController button4Controller = TextEditingController();

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

  // RxBool enabledPoll = false.obs;
  RxBool isPosting = RxBool(false);
  final HomePostsController homePostsController =
      Get.put(HomePostsController());
  final jwtController = Get.find<JWTController>();
  final bottomNavController = Get.find<NavController>();
  Future setPost(image, PostType assetTyp) async {
    isSettingImage.value = true;
    if (assetTyp == PostType.text) {
      textPost = image;
    } else {
      imagePath = image;
    }
    assetType = assetTyp;
    isSettingImage.value = false;
    //update();
  }

  // void addPost(Uint8List image) {
  //   imagePaths.add(image);
  // }
  Future<void> addPost(List<Uint8List> imagex) async {
    imagePaths.clear();
    for (var i = 0; i < imagex.length; i++) {
      final tempDir = await getTemporaryDirectory();
      File imageFile = await File('${tempDir.path}/image$i.jpg')
          .create(); // this is the File object with the desired path and extension
      await imageFile.writeAsBytes(imagex[i]);
      // File imageFile = File.fromRawPath(
      //     imageBytes); // this creates a File object from the Uint8List
      imagePaths.add(imageFile.path); // this adds the File object to the List
    }
  }

  // uploadPost(String imagePath) {
  //   images.add(imagePath);
  // }

  Future makePost(bool enablePoll, String tagPrivacy, int? setTimer,
      bool? isCustomPoll, List<Uint8List> images) async {
    isPosting.value = true;
    try {
      await addPost(images);
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
      debugPrint(privacyLikesAndViews.value);
      dio.options.headers["Authorization"] =
          jwtController.token ?? await jwtController.getAuthToken();
      debugPrint(jwtController.token);
      debugPrint(jwtController.userId);
      // final tempDir = await getTemporaryDirectory();
      // File file = await File('${tempDir.path}/image.png').create();
      // if (assetType != PostType.text) {
      //   Uint8List imageInUnit8List = imagePath!;

      //   file.writeAsBytesSync(imageInUnit8List);
      // }

      FormData reqData = FormData.fromMap({
        "userId": jwtController.userId ?? jwtController.getUserId(),
        "mediaType": "image",
        // assetType.toString().split(".")[1].substring(0),
        "mediaUrl":

            /// MultipartFile.fromFileSync(imagePaths[0]),
            List.generate(imagePaths.length,
                (i) => MultipartFile.fromFileSync(imagePaths[i])),

        "Enabledpoll": enablePoll ? true : false,

        //  "setTimer": enablePoll ? setTimer:"",
        "caption": captionController.text,

        "ShowPollResults": true,

        "privacy": '{"everyone": true, "followers": false, "no_one": false}',
        "post_hide": "[]",
        "tag_privacy": '{"everyone":true,"followers":false,"no_one":false}',
        "pollDuration": DateTime.now().add(Duration(days: setTimer ?? 1)),
        // DateTime(2024, 9, 7, 17, 30),
        "tags": "[]",
        "tagPeople": "[]",
        //  "customPollEnabled": isCustomPoll,
        // "customPollData":
        //     "[${button1Controller.text},${button2Controller.text}]"
      });

      var res = await dio.post(
        ApiEndpoint.makePost,
        data: reqData,
        onSendProgress: (count, total) {
          uploadPercentage.value = (count / total);
        },
      );
      //debugPrint(reqData.toString());
      uploadPercentage.value = 0.0;
      print("status : ${res.statusCode}");
      CustomSnackbar.showSucess("Post  successful");
      isPosting.value = false;

      homePostsController.skip.value = -10;

      bottomNavController.page(0);
      homePostsController.posts?.clear();
      homePostsController.getPost();
      Get.offAll(() => BottomNavBar());
    } catch (e) {
      //debugPrint(reqData.toString());
      uploadPercentage.value = 0.0;
      isPosting.value = false;
      Get.snackbar("Cant Post", "Some Internal Error");
      debugPrint("posting video error $e");
    }
  }

  // Future makePost(
  //   bool enablePoll,
  //   String tagPrivacy,
  //   int? setTimer,
  // ) async {
  //   isPosting.value = true;

  //   try {
  //     // if(setTimer == "-1"){
  //     //   CustomSnackbar.show("please setTimer");
  //     //   isPosting.value = false;
  //     //   return;
  //     // }
  //     // if(captionController.text == ""){
  //     //   CustomSnackbar.show("please fill captions");
  //     //   isPosting.value = false;
  //     //   return;
  //     // }

  //     Dio dio = Dio();
  //     debugPrint(privacyLikesAndViews.value);
  //     var token = await jwtController.getAuthToken();
  //     var userId = await jwtController.getUserId();
  //     dio.options.headers["Authorization"] = token;
  //     //todo : Remove The New File Making Process With Filtered File
  //     // final tempDir = await getTemporaryDirectory();
  //     // File file = await File('${tempDir.path}/image.png').create();
  //     // if (assetType != PostType.text) {
  //     //   Uint8List imageInUnit8List = imagePath!;

  //     //   file.writeAsBytesSync(imageInUnit8List);
  //     // }
  //     // debugPrint(
  //     //   file.path.toString(),
  //     // );

  //     FormData reqData = FormData.fromMap({
  //       "userId": userId,
  //       "mediaType": "image",
  //       // assetType.toString().split(".")[1].substring(0),
  //       "mediaUrl": MultipartFile.fromFileSync(imagePaths[0]
  //           // assetType == PostType.text ? textPost! : file.path.toString(),
  //           ),

  //       "Enabledpoll": enablePoll ? true : false,

  //       //  "setTimer": enablePoll ? setTimer:"",
  //       "caption": captionController.text,

  //       "ShowPollResults": true,

  //       "privacy": '{"everyone": false, "followers": true, "no_one": false}',
  //       "post_hide": "[]",
  //       "tag_privacy":
  //           '{"everyone": false, "followers": true, "no_one": false}',
  //       "pollDuration": DateTime.now().add(Duration(days: setTimer ?? 1)),
  //       // DateTime(2024, 9, 7, 17, 30),
  //       "tags": "[]",
  //       "tagPeople": "[]"
  //     });

  //     await dio.post(
  //       ApiEndpoint.makePost,
  //       data: reqData,
  //       onSendProgress: (count, total) {
  //         uploadPercentage.value = (count / total);
  //       },
  //     );
  //     //debugPrint(reqData.toString());
  //     uploadPercentage.value = 0.0;

  //     CustomSnackbar.showSucess("Post  successful");
  //     isPosting.value = false;

  //     homePostsController.skip.value = -10;

  //     //bottomNavController.pageUpdate(0);
  //     homePostsController.posts?.clear();
  //     homePostsController.getPost();
  //     Get.offAll(() => BottomNavBar());
  //   } catch (e) {
  //     //debugPrint(reqData.toString());
  //     uploadPercentage.value = 0.0;
  //     isPosting.value = false;
  //     Get.snackbar("Cant Post", "Some Internal Error");
  //     debugPrint("posting video error $e");
  //   }
  // }
}
