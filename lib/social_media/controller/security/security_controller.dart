import 'dart:convert';

import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../common/common_snackbar.dart';
 
class SecurityController extends GetxController {
   updateName(String name) async {
    var token = await HiveDB.getAuthToken();
    var userId = await HiveDB.getUserID();
    var headers = {'Content-Type': 'application/json', 'Authorization': token!};
    Map bodymain = {"username": name};

    debugPrint(ApiEndpoint.updateUserDetails);
    debugPrint('${ApiEndpoint.updateUserDetails}?userId=$userId');
    debugPrint(bodymain.toString());
    http.Response response = await http.put(Uri.parse('${ApiEndpoint.updateUserDetails}?userId=$userId'), body: jsonEncode(bodymain), headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");

    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Name Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  updateDOB(String dob) async {
    var token = await HiveDB.getAuthToken();
    var userId = await HiveDB.getUserID();
    var headers = {'Content-Type': 'application/json', 'Authorization': token!};
    Map bodymain = {"dob": dob};

    debugPrint(ApiEndpoint.updateUserDetails);
    debugPrint('${ApiEndpoint.updateUserDetails}?userId=$userId');
    debugPrint(bodymain.toString());
    http.Response response = await http.put(Uri.parse('${ApiEndpoint.updateUserDetails}?userId=$userId'), body: jsonEncode(bodymain), headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");

    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User DOB Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  updateEmail(String email) async {
    var token = await HiveDB.getAuthToken();
    var userId = await HiveDB.getUserID();
    var headers = {'Content-Type': 'application/json', 'Authorization': token!};
    Map bodymain = {"email": email};

    debugPrint(ApiEndpoint.updateUserDetails);
    debugPrint('${ApiEndpoint.updateUserDetails}?userId=$userId');
    debugPrint(bodymain.toString());
    http.Response response = await http.put(Uri.parse('${ApiEndpoint.updateUserDetails}?userId=$userId'), body: jsonEncode(bodymain), headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");

    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Email Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  updateMobile(String mobile) async {
    var token = await HiveDB.getAuthToken();
    var userId = await HiveDB.getUserID();
    var headers = {'Content-Type': 'application/json', 'Authorization': token!};
    Map bodymain = {"mobile_number": mobile};

    debugPrint(ApiEndpoint.updateUserDetails);
    debugPrint('${ApiEndpoint.updateUserDetails}?userId=$userId');
    debugPrint(bodymain.toString());
    http.Response response = await http.put(Uri.parse('${ApiEndpoint.updateUserDetails}?userId=$userId'), body: jsonEncode(bodymain), headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");

    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Mobile Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  updateAddress(String address) async {}
}
