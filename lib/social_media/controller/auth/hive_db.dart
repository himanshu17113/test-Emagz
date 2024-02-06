import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
      final String? token = await hiveBox.get(
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

  static getlistUser() {
    final hiveBox = Hive.box("secretes");
    listUser = hiveBox.get('listUser', defaultValue: []);
   final data = hiveBox.get("idtoken", defaultValue: {});
      idtoken = jsonDecode(data);
    print(idtoken.toString());
  }

  static Future<UserSchema?> getCurrentUserDetail() async {
    //Box hiveBox = await Hive.openBox("secretes");
    if (constuser?.sId != null) {
      return constuser;
    } else {
      final hiveBox = Hive.box("secretes");
      final UserSchema? user = hiveBox.get("user");
      if (user?.sId != null) {
        constuser = user;
        return user;
      } else {
        return setCurrentUserDetail();
      }
    }
  }

  static Future<UserSchema?> setCurrentUserDetail({bool addinList = false}) async {
    debugPrint("Api hiiitiiiiiiiiiiiiiiiiiiiiiiiii");
    //Box hiveBox = await Hive.openBox("secretes");
    final hiveBox = Hive.box("secretes");
    final Dio dio = Dio();
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
        try {
          await hiveBox.put('user', user);
        } on Exception catch (e) {
          debugPrint(e.toString());
        }
        constuser = user;
        await getlistUser();
        if (listUser!.isEmpty) {
          if (addinList) {
            debugPrint("adddingg");
            idtoken.assign(globUserId!, globToken!);

            listUser?.add(jsonEncode(response.data));
            print(listUser.toString());
          }
        } else {
          for (int i = 0; i < listUser!.length; i++) {
            if (jsonDecode(listUser![i]!)['_id'] == user.sId) {
              listUser![i] = jsonEncode(response.data);
            } else {
              if (addinList) {
                debugPrint("adddingg");
                idtoken.addIf(globToken != null, globUserId!, globToken!);
                listUser?.add(jsonEncode(response.data));
              }
            }
          }
        }
        try {
          await hiveBox.put('listUser', listUser);
          await hiveBox.put('idtoken', jsonEncode(idtoken));
        } on Exception catch (e) {
          print(e);
        }
        if (user.profilePic != null) {
          //     profilePic.value = user!.profilePic!;
          globProfilePic = user.profilePic!;
        }

        return user;
      }
    } else {
      return UserSchema();
    }
    return null;
  }

  static Future<UserSchema?> togglePrivate(bool isPrivate) async {
    debugPrint("Api hit togglePrivate");
    final Dio dio = Dio();
    dio.options.headers["Authorization"] = globToken ?? getAuthToken();
    if (globUserId == null) {
      await getUserID();
    }
    if (globUserId != null) {
      var response = await dio.get(ApiEndpoint.makeAccountPrivate(isPrivate));
      debugPrint(ApiEndpoint.makeAccountPrivate(isPrivate));
      if (response.statusCode == 200) {
        final user = UserSchema.fromJson(response.data["data"]);
        constuser = user;
        return user;
      }
    } else {
      return UserSchema();
    }
    return null;
  }

  static putUserDetail(UserSchema user, String formatin) async {
    final hiveBox = Hive.box("secretes");

    await hiveBox.put('user', user);
    constuser = user;
    // if (listUser!.isEmpty) {
    //   // if (addinList) {
    //   debugPrint("adddingg");
    //   listUser?.add(jsonEncode(formatin));
    //   // }
    // } else {
    //   for (var element in listUser!) {
    //     if (jsonDecode(element!)['_id'] == user.sId) {
    //       element = jsonEncode(formatin);
    //     } else {
    //       //    if (addinList) {
    //       debugPrint("adddingg");
    //       listUser?.add(jsonEncode(formatin));
    //       //
    //     }
    //     await hiveBox.put('listUser', listUser);
    //   }
    // }
  }

  static clearDB() {
    final hiveBox = Hive.box("secretes");
    globToken = null;
    globUserId = null;
    constuser = null;
    hiveBox.clear();
  }

  static switchAcc(UserSchema user, String token) {
    globToken = token;
    globUserId = user.sId;
    constuser = user;
    setAuthData(token, user.sId);
    setCurrentUserDetail();
  }

  static upateProfilePic(String pic) async {
    final hiveBox = Hive.box("secretes");
    UserSchema? user = hiveBox.get("user");
    user?.profilePic = pic;
    await hiveBox.put('user', user);
  }

  static Future<UserSchema?> getUserDetail(String id) async {
    debugPrint("Api hit getUserDetail");
    //Box hiveBox = await Hive.openBox("secretes");
    // final hiveBox = Hive.box("secretes");
    final Dio dio = Dio();
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
