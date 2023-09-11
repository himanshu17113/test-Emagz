import 'dart:convert';

import 'package:emagz_vendor/constant/api_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../common/common_snackbar.dart';
import '../auth/jwtcontroller.dart';
class SecurityController extends GetxController{

  var jwtController = Get.put(JWTController());
  updateName(String name) async
  {
    var token = await jwtController.getAuthToken();
    var userId= await jwtController.getUserId();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token!
    };
    Map bodymain={
      "username":name
    };

    debugPrint(ApiEndpoint.updateUserDetails);
    debugPrint('${ApiEndpoint.updateUserDetails}?userId=${userId}');
    debugPrint(bodymain.toString());
    http.Response response = await http.put(Uri.parse('${ApiEndpoint.updateUserDetails}?userId=${userId}'),
        body: jsonEncode(bodymain), headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");

    if(response.statusCode==200)
    {
      CustomSnackbar.showSucess("User Live Privacy Updated");
    }
    else{
      print(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }
}