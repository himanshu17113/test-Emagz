import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

String? gprofilePic =
    'https://res.cloudinary.com/dzarrma99/image/upload/v1693398992/ykw3kzomhtuvqy3celpt.jpg';

class JWTController extends GetxController {
  String? token;
  RxString? profilePic =
      'https://res.cloudinary.com/dzarrma99/image/upload/v1693398992/ykw3kzomhtuvqy3celpt.jpg'
          .obs;
  String? userId;
  Rx<UserSchema>? currentUser;
  Rx<UserSchema>? user = UserSchema().obs;

  var hiveBox = Hive.box("secretes");

  Future<UserSchema> getCurrentUserDetail() async {
    Dio dio = Dio();
    token ??= (await getAuthToken())!;

    userId ??= (await getUserId())!;
    dio.options.headers["Authorization"] = token ??
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGMyMzBmMGZiNGRhNjZmNDBlZDdkNzEiLCJpYXQiOjE2OTA0NDgxMTJ9.EJ8G32sWR2ZqHg7LJ-IHppNGPVwU3-wn5lN5uFo6DvQ";
    //userToken;
    if (userId != null) {
      var response = await dio.get(ApiEndpoint.userInfo(userId!));
      debugPrint(ApiEndpoint.userInfo(userId!));
      // debugPrint(response.data);
      UserSchema userDetails = UserSchema.fromJson(response.data);
      user?.value = userDetails;
      gprofilePic = userDetails.ProfilePic;
      return userDetails;
    } else {
      return UserSchema();
    }
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
    token = tokenx;
    userId = id;
    if (tokenx != null && id != null) {
      //  isAuthorised.value = true;
      if (token == null || userId == null) {
        token = tokenx;
        userId = id;
      }
    }
    // else {
    //   isAuthorised.value = false;
    // }
  }

  Future<String?> getAuthToken() async {
    if (token != null) {
      //  debugPrint("done fastly");
      return token!;
    }
    //  debugPrint("DONE SLOWLY");
    final t = await hiveBox.get("token");
    token = t;
    // if (token != null) {
    //   isAuthorised.value = true;
    // } else {
    //   isAuthorised.value = false;
    //   return null;
    // }
    return token!;
  }

  Future<String?> getUserId() async {
    if (userId != null) {
      //  debugPrint("done fastly");
      return userId!;
    }
    debugPrint(
        "gettttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttting the user id    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");

    userId = await hiveBox.get("userId");

    return userId;
  }

  Future setProfileImage(String imageUrl) async {
    await hiveBox.put('ProfilePic', imageUrl);
    profilePic = RxString(imageUrl);
  }

  Future<String> getProfileImage() async {
    var imageUrl = await hiveBox.get('ProfilePic');
    imageUrl ??=
        'https://res.cloudinary.com/dzarrma99/image/upload/v1693398992/ykw3kzomhtuvqy3celpt.jpg';
    profilePic = RxString(imageUrl!);
    return imageUrl;
  }

  @override
  void onInit() async {
    super.onInit();
    token ??= await getAuthToken();

    userId ??= await getUserId();
    getCurrentUserDetail();
    debugPrint(token);
    debugPrint(userId);
    if (token == null) {
      debugPrint("NO AUTH");
    } else {
      debugPrint("AUTH");

      update();
    }
  }
}
