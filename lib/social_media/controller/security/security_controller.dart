import 'dart:convert';

import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/models/user_schema.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../common/common_snackbar.dart';

class SecurityController extends GetxController {
  updateName(String name) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': globToken!
    };
    final Map bodymain = {"username": name};

    debugPrint('${ApiEndpoint.updateUserDetails}?userId=$globUserId');
    debugPrint(bodymain.toString());
    http.Response response = await http.put(
        Uri.parse('${ApiEndpoint.updateUserDetails}?userId=$globUserId'),
        body: jsonEncode(bodymain),
        headers: headers);
    final Map data = jsonDecode(response.body);

    debugPrint("code${response.statusCode.toString()}");
    final user = UserSchema.fromJson(data["user"]);
    HiveDB.putUserDetail(user);
    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Name Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  updateDOB(String dob) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': globToken!
    };
    final Map bodymain = {"dob": dob};

    debugPrint('${ApiEndpoint.updateUserDetails}?userId=$globUserId');
    debugPrint(bodymain.toString());
    http.Response response = await http.put(
        Uri.parse('${ApiEndpoint.updateUserDetails}?userId=$globUserId'),
        body: jsonEncode(bodymain),
        headers: headers);
    final Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");
    final user = UserSchema.fromJson(data["user"]);
    HiveDB.putUserDetail(user);
    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User DOB Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }



  updateEmail(String email) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': globToken!
    };
    final Map bodymain = {"email": email};

    debugPrint('${ApiEndpoint.updateUserDetails}?userId=$globUserId');
    debugPrint(bodymain.toString());
    http.Response response = await http.put(
        Uri.parse('${ApiEndpoint.updateUserDetails}?userId=$globUserId'),
        body: jsonEncode(bodymain),
        headers: headers);
    final Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");
    final user = UserSchema.fromJson(data["user"]);
    HiveDB.putUserDetail(user);
    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Email Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  updateMobile(String mobile) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': globToken!
    };

    final Map bodymain = {"mobile_number": mobile};

    debugPrint('${ApiEndpoint.updateUserDetails}?userId=$globUserId');
    debugPrint(bodymain.toString());
    http.Response response = await http.put(
        Uri.parse('${ApiEndpoint.updateUserDetails}?userId=$globUserId'),
        body: jsonEncode(bodymain),
        headers: headers);
    final Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");
    final user = UserSchema.fromJson(data["user"]);
    HiveDB.putUserDetail(user);
    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Mobile Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  updateAddress(String address) async {}
}
