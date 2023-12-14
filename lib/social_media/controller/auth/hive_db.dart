import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import '../../../constant/data.dart';
import '../../models/user_schema.dart';

class HiveDB {
  // Box? hiveBox;
  static setAuthData(String? tokenx, String? id) async {
    globToken = tokenx;
    globUserId = id;
      final hiveBox = await Hive.openBox("secretes");
    await hiveBox.put("token", tokenx);
    await hiveBox.put("userId", id);
  }

  static Future<String?> getAuthToken() async {
    if (globToken != null) {
      return globToken;
    } else {
      //  final hiveBox = await Hive.openBox("secretes");
      final hiveBox = Hive.box("secretes");
      String? token = await hiveBox.get(
        "token",
        // defaultValue:
        //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGMyMzBmMGZiNGRhNjZmNDBlZDdkNzEiLCJpYXQiOjE2OTA0NDgxMTJ9.EJ8G32sWR2ZqHg7LJ-IHppNGPVwU3-wn5lN5uFo6DvQ"
      );

      globToken = token;
      return token;
    }
  }

  static Future<String?> getUserID() async {
    // final hiveBox = await Hive.openBox("secretes");
    if (globUserId != null) {
      return globUserId;
    } else {
      final hiveBox = Hive.box("secretes");
      final userId = await hiveBox.get("userId");
      globUserId = userId;
      return userId;
    }
  }

  static Future<UserSchema?> getCurrentUserDetail() async {
    //Box hiveBox = await Hive.openBox("secretes");
    if (constuser?.sId != null) {
      return constuser;
    } else {
      final hiveBox = Hive.box("secretes");
      UserSchema? user = hiveBox.get("user");
      if (user?.sId != null) {
        constuser = user;
        return user;
      } else {
        return setCurrentUserDetail();
      }
    }
  }

  static Future<UserSchema?> setCurrentUserDetail() async {
    debugPrint("Api hiiitiiiiiiiiiiiiiiiiiiiiiiiii");
    //Box hiveBox = await Hive.openBox("secretes");
    final hiveBox = Hive.box("secretes");
  final  Dio dio = Dio();
    dio.options.headers["Authorization"] = globToken ?? getAuthToken();
    if (globUserId == null) {
      await getUserID();
    }
    if (globUserId != null) {
      var response = await dio.get(ApiEndpoint.userInfo(globUserId!));
      debugPrint(ApiEndpoint.userInfo(globUserId!));
      // debugPrint(response.data);
      if (response.statusCode == 200) {
        final user = UserSchema.fromJson(response.data);
        await hiveBox.put('user', user);
        constuser = user;
        if (user.ProfilePic != null) {
          //     profilePic.value = user!.ProfilePic!;
          globProfilePic = user.ProfilePic!;
        }

        return user;
      }
    } else {
      return UserSchema();
    }
    return null;
  }

  static clearDB() {
    final hiveBox = Hive.box("secretes");
    globToken = null;
    globUserId = null;
    constuser = null;
    hiveBox.clear();
  }

  static upateProfilePic(String pic) async {
    final hiveBox = Hive.box("secretes");
    UserSchema? user = hiveBox.get("user");
    user?.ProfilePic = pic;
    await hiveBox.put('user', user);
  }

  static Future<UserSchema?> getUserDetail(String id) async {
    debugPrint("Api hit getUserDetail");
    //Box hiveBox = await Hive.openBox("secretes");
    // final hiveBox = Hive.box("secretes");
    Dio dio = Dio();
    dio.options.headers["Authorization"] = globToken ?? getAuthToken();
    if (globUserId == null) {
      await getUserID();
    }
    if (globUserId != null) {
      var response = await dio.get(ApiEndpoint.userInfo(id));
      debugPrint(ApiEndpoint.userInfo(globUserId!));
      // debugPrint(response.data);
      if (response.statusCode == 200) {
        final user = UserSchema.fromJson(response.data);
        // await hiveBox.put('user', user);
        // constuser = user;

        return user;
      }
    } else {
      return UserSchema();
    }
    return null;
  }
}
