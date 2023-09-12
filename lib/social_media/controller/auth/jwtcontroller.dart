import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class JWTController extends GetxController {
  RxString? token;
  RxString? profilePic = 'https://res.cloudinary.com/dzarrma99/image/upload/v1693398992/ykw3kzomhtuvqy3celpt.jpg'.obs;
  RxString? userId;
  Rx<UserSchema>? currentUser;
  Rx<UserSchema>? user = UserSchema().obs;
  RxBool isAuthorised = false.obs;
  var hiveBox = Hive.box("secretes");

  Future<UserSchema> getCurrentUserDetail() async {
    Dio dio = Dio();
    //  var userToken = await getAuthToken();
    var id = await getUserId();
    dio.options.headers["Authorization"] =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGMyMzBmMGZiNGRhNjZmNDBlZDdkNzEiLCJpYXQiOjE2OTA0NDgxMTJ9.EJ8G32sWR2ZqHg7LJ-IHppNGPVwU3-wn5lN5uFo6DvQ";
    //userToken;
    var response = await dio.get(ApiEndpoint.userInfo(id!));
    debugPrint(ApiEndpoint.userInfo(id));
    // debugPrint(response.data);
    var userDetails = UserSchema.fromJson(response.data);
    user?.value = userDetails;
    return userDetails;
  }

  Future<UserSchema?> getUserDetail(String id) async {
    try {
      Dio dio = Dio();
      var userToken = await getAuthToken();
      dio.options.headers["Authorization"] = userToken ??
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGMyMzBmMGZiNGRhNjZmNDBlZDdkNzEiLCJpYXQiOjE2OTA0NDgxMTJ9.EJ8G32sWR2ZqHg7LJ-IHppNGPVwU3-wn5lN5uFo6DvQ";
      //userToken;
      // debugPrint(ApiEndpoint.userInfo(id!));
      var response = await dio.get(ApiEndpoint.userInfo(id));
      //  debugPrint(response.data);
      var userDetails = UserSchema.fromJson(response.data);
      currentUser ??= userDetails.obs;
      return userDetails;
    } catch (e) {
      debugPrint("get Id Error HImanshu");
      // debugPrint(e);
      return null;
    }
  }

  Future setAuthToken(String? tokenx, String? id) async {
    await hiveBox.put("token", tokenx);
    await hiveBox.put("userId", id);
    // token = RxString(tokenx!);
    // userId?.value = id!;
    if (tokenx != null && id != null) {
      isAuthorised.value = true;
      token = RxString(tokenx);
      userId = RxString(id);
    } else {
      isAuthorised.value = false;
    }
  }

  Future<String?> getAuthToken() async {
    if (token?.value != null) {
      //  debugPrint("done fastly");
      return token!.value;
    }
    //  debugPrint("DONE SLOWLY");
    token?.value = await hiveBox.get("token");
    if (token?.value != null) {
      isAuthorised.value = true;
    } else {
      isAuthorised.value = false;
      return null;
    }
    return token!.value;
  }

  Future<String?> getUserId() async {
    if (userId?.value != null) {
      //  debugPrint("done fastly");
      return userId!.value;
    }
    //

    userId?.value = await hiveBox.get("userId");
    return userId?.value;
  }

  Future setProfileImage(String imageUrl) async {
    await hiveBox.put('ProfilePic', imageUrl);
    profilePic = RxString(imageUrl);
  }

  Future<String> getProfileImage() async {
    var imageUrl = await hiveBox.get('ProfilePic');
    imageUrl ??= 'https://res.cloudinary.com/dzarrma99/image/upload/v1693398992/ykw3kzomhtuvqy3celpt.jpg';
    profilePic = RxString(imageUrl!);
    return imageUrl;
  }

  @override
  void onInit() async {
    super.onInit();
    token?.value = (await getAuthToken())!;
    userId?.value = (await getUserId())!;
    getCurrentUserDetail();
    debugPrint(token?.value);
    debugPrint(userId?.value);
    if (token?.value == null) {
      debugPrint("NO AUTH");
    } else {
      debugPrint("AUTH");
      isAuthorised.value = true;
    }
  }
}
