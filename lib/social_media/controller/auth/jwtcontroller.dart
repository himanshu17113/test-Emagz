import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/models/user_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class JWTController extends GetxController {
  RxString? token;
  RxString? userId;
  Rx<UserSchema>? currentUser;
  RxBool isAuthorised = false.obs;
  var hiveBox = Hive.box("secretes");

  Future<User> getCurrentUserDetail() async {
    Dio dio = Dio();
    var userToken = await getAuthToken();
    var id = await getUserId();
    dio.options.headers["Authorization"] =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGMyMzBmMGZiNGRhNjZmNDBlZDdkNzEiLCJpYXQiOjE2OTA0NDgxMTJ9.EJ8G32sWR2ZqHg7LJ-IHppNGPVwU3-wn5lN5uFo6DvQ";
    //userToken;
    var response = await dio.get(ApiEndpoint.userInfo(id!));
    print(ApiEndpoint.userInfo(id!));
    print(response.data);
    var userDetails = User.fromJson(response.data);
    return userDetails;
  }

  Future<UserSchema?> getUserDetail(String id) async {
    try {
      Dio dio = Dio();
      var userToken = await getAuthToken();
      dio.options.headers["Authorization"] =userToken??
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGMyMzBmMGZiNGRhNjZmNDBlZDdkNzEiLCJpYXQiOjE2OTA0NDgxMTJ9.EJ8G32sWR2ZqHg7LJ-IHppNGPVwU3-wn5lN5uFo6DvQ";
      //userToken;
      print(ApiEndpoint.userInfo(id!));
      var response = await dio.get(ApiEndpoint.userInfo(id));
      print(response.data);
      var userDetails = UserSchema.fromJson(response.data);
      currentUser ??= userDetails.obs;
      return userDetails;
    } catch (e) {
      print("get Id Error HImanshu");
      print(e);
      return null;
    }
  }

  Future setAuthToken(String? token, String? id) async {
    await hiveBox.put("token", token);
    await hiveBox.put("userId", id);
    var lastToken = await hiveBox.get("token");
    if (lastToken != null) {
      isAuthorised.value = true;
      this.token = RxString(token!);
      this.userId = RxString(id!);
    } else {
      isAuthorised.value = false;
    }
  }

  Future<String?> getAuthToken() async {
    if (token != null) {
      print("done fastly");
      return token!.value;
    }
    print("DONE SLOWLY");
    var lastToken = await hiveBox.get("token");
    if (lastToken != null) {
      isAuthorised.value = true;
    } else {
      isAuthorised.value = false;
      return null;
    }
    return lastToken;
  }

  Future<String?> getUserId() async {
    var userId = await hiveBox.get("userId");
    return userId;
  }

  @override
  void onInit() async {
    super.onInit();
    String? lastAuthToken = await getAuthToken();
    String? userId = await getUserId();
    print(lastAuthToken);
    print(userId);
    if (lastAuthToken == null) {
      print("NO AUTH");
    } else {
      print("AUTH");
      isAuthorised.value = true;
    }
  }
}
