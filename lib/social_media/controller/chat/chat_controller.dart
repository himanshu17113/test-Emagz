import 'dart:convert';

import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/constant/api_string.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {

  RxBool isRequestListLoading = false.obs;
  RxBool isAcceptingRequest = false.obs;
  RxBool isBlockingUser = false.obs;
  RxBool isUnBlockingUser = false.obs;



  Future getRequestList() async {
    try {
      isRequestListLoading.value = true;
      http.Response response = await http.get(
        Uri.parse(ApiEndpoint.requestList),
      );
      // Map res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isRequestListLoading.value = false;
        CustomSnackbar.show("message");
      } else {
        isRequestListLoading.value = false;
        CustomSnackbar.show("Failed");
      }
    } catch (e) {
      isRequestListLoading.value = false;
    }
  }

  Future acceptrequest(String userId) async {
    try {
      isAcceptingRequest.value = true;
      http.Response response = await http.post(
        Uri.parse("${ApiEndpoint.requestList}/$userId/accept"),
      );
      // Map res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isAcceptingRequest.value = false;
        CustomSnackbar.show("message");
      } else {
        isAcceptingRequest.value = false;
        CustomSnackbar.show("Failed");
      }
    } catch (e) {
      isAcceptingRequest.value = false;
    }
  }

  Future blockUser(String userId, String victimId) async {
    try {
      isBlockingUser.value = true;
      Map body = {"blockerId": userId, "blockedId": victimId};
      http.Response response = await http.post(
        Uri.parse(ApiEndpoint.blockUser),
        body: jsonEncode(body),
      );
      // Map res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isBlockingUser.value = false;
        CustomSnackbar.show("message");
      } else {
        isBlockingUser.value = false;
        CustomSnackbar.show("Failed");
      }
    } catch (e) {
      isBlockingUser.value = false;
    }
  }

  Future unBlockUser(String userId, String victimId) async {
    try {
      isUnBlockingUser.value = true;
      Map body = {"blockerId": userId, "blockedId": victimId};
      http.Response response = await http.delete(
        Uri.parse("${ApiEndpoint.blockUser}/$userId"),
        body: jsonEncode(body),
      );
      // Map res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isUnBlockingUser.value = false;
        CustomSnackbar.show("message");
      } else {
        isUnBlockingUser.value = false;
        CustomSnackbar.show("Failed");
      }
    } catch (e) {
      isUnBlockingUser.value = false;
    }
  }

   Future getBlockuserList(String userId, String victimId) async {
    try {
      isUnBlockingUser.value = true;
      // Map body = {"blockerId": userId};
      http.Response response = await http.get(
        Uri.parse(ApiEndpoint.blockUser),
        // body: jsonEncode(body),
      );
      // Map res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isUnBlockingUser.value = false;
        CustomSnackbar.show("message");
      } else {
        isUnBlockingUser.value = false;
        CustomSnackbar.show("Failed");
      }
    } catch (e) {
      isUnBlockingUser.value = false;
    }
  }
}
