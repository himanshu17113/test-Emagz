import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/models/user_schema.dart';

import 'package:emagz_vendor/social_media/screens/account/business_account_confirmation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import "package:emagz_vendor/constant/api_string.dart";
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';

import '../../../../templates/choose_template/template_model.dart';

class SetupAccount extends GetxController {
  RxString? profilepic;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();

  RxBool isUserRegiserting = RxBool(false);
  RxList<Template>? templates = <Template>[].obs;
  // setBusinessLogo

  @override
  onInit() async {
    getAllTempltes();
    profilepic?.value = constuser?.ProfilePic ?? "";
    super.onInit();
  }

  checkUserName() async {
    // will recive api
    return false;
  }

  setUpProfessionalAccount(XFile imageFile) async {
    isUserRegiserting.value = true;
    var token = await HiveDB.getAuthToken();
    var id = await HiveDB.getUserID();
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token!;
    var headers = {'Content-Type': 'application/json', "": token};
    FormData body = FormData.fromMap({
      "_id": id,
      //todo implement multipart file upload when backend is ready
      "businessLogo": MultipartFile.fromFileSync(imageFile.path),
      "businessName": businessNameController.text,
      "businessType": businessTypeController.text,
      "personalTemplate": "https://example.com/personal-template.html"
    });
    var response = await dio.post(ApiEndpoint.setupProfessionalAccount, data: body);

    var data = response.data;
    if (response.statusCode == 200) {
      isUserRegiserting.value = false;
      Get.to(() => const BusinessAccountConfirmationScreen());
      return true;
    } else if (response.statusCode == 401) {
      CustomSnackbar.show(data['error']);
      isUserRegiserting.value = false;
      return false;
    } else if (response.statusCode == 400) {
      CustomSnackbar.show(data['error']);
      isUserRegiserting.value = false;
      return false;
    } else {
      CustomSnackbar.show("User Registration Failed ! Try again later");
      isUserRegiserting.value = false;
      return false;
    }
  }

  setUpPersonalAccount() async {
    isUserRegiserting.value = true;

    var token = await HiveDB.getAuthToken();
    var id = await HiveDB.getUserID();
    var headers = {'Content-Type': 'application/json', "Authorization": token!};
    Map body = {"_id": id, "displayName": displayNameController.text, "personalTemplate": ""};
    http.Response response = await http.post(Uri.parse(ApiEndpoint.setupPeronalAccount), body: jsonEncode(body), headers: headers);

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      constuser = await HiveDB.getCurrentUserDetail();
      // debugPrint(data.toString());
      isUserRegiserting.value = false;
      //lead to main page

      Get.to(() => BottomNavBar(), transition: Transition.rightToLeftWithFade);
      return true;
    } else if (response.statusCode == 401) {
      CustomSnackbar.show(data['error']);
      isUserRegiserting.value = false;
      return false;
    } else if (response.statusCode == 400) {
      CustomSnackbar.show(data['error']);
      isUserRegiserting.value = false;
      return false;
    } else {
      CustomSnackbar.show("User Registration Failed ! Try again later");
      isUserRegiserting.value = false;
      return false;
    }
  }

  Future<String> uploadProfilePic(XFile? image) async {
    Map<String, String> header = {'Content-type': 'multipart/form-data'};
    Map<String, String> header2 = {"Authorization": globToken!};
    var request = http.MultipartRequest('POST', Uri.parse('${ApiEndpoint.uploadProfilePic}?userId=$globUserId'));
    request.headers.addAll(header);
    request.headers.addAll(header2);
    if (image?.path != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'ProfilePic',
        image!.path,
        filename: image.name,
      ));
    }
    var response = await request.send();
    debugPrint("code${response.statusCode}");
    debugPrint("stream${response.stream}");
    final res = await http.Response.fromStream(response);
    var data = jsonDecode(res.body);
    if (response.statusCode == 200) {
      //var hiveBox = Hive.box("secretes");
      constuser = UserSchema.fromJson(data);
      //  await hiveBox.put('user', constuser);
      debugPrint(data.toString());
      debugPrint(data['data']['ProfilePic'].toString());
      HiveDB.upateProfilePic(data['data']['ProfilePic']);
      //  await jwtController.setProfileImage(data['data']['ProfilePic']);
      profilepic?.value = data['data']['ProfilePic'];
      return data['data']['ProfilePic'];
    } else {
      return 'https://media.istockphoto.com/photos/smiling-indian-business-man-working-on-laptop-at-home-office-young-picture-id1307615661?b=1&k=20&m=1307615661&s=170667a&w=0&h=Zp9_27RVS_UdlIm2k8sa8PuutX9K3HTs8xdK0UfKmYk=';
    }
  }

  Future<List<Template?>?> getAllTempltes() async {
    if (templates != null) templates!.clear();
    try {
      var token = await HiveDB.getAuthToken();
      var headers = {'Content-Type': 'application/json', "Authorization": token!};

      http.Response response = await http.get(Uri.parse(ApiEndpoint.template), headers: headers);
      var body = jsonDecode(response.body);
      debugPrint(body.toString());
      body.forEach((e) {
        var temp = Template.fromJson(e);
        templates?.add(temp);
      });
      return templates;
    } catch (e) {
      print(e);
    }
    return null;
  }

  userTemplate(String? templateId) async {
    var userId = await HiveDB.getUserID();
    var token = await HiveDB.getAuthToken();
    Map body = {"userId": userId, "templateId": templateId, "finalTemplateData": {}};
    var headers = {'Content-Type': 'application/json', "Authorization": token!};
    http.Response response = await http.post(
      Uri.parse(ApiEndpoint.userTemplate),
      headers: headers,
      body: jsonEncode(body),
    );
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //CustomSnackbar.showSucess('Your persona is set');
      Get.back();
    } else {
      print('expected error');
      Get.back();
    }
  }
}
