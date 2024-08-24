import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/models/user_schema.dart';

import 'package:emagz_vendor/templates/choose_template/choose_template.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import "package:emagz_vendor/constant/api_string.dart";
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';

import '../../../../templates/choose_template/template_model.dart';

class SetupAccount extends GetxController {
  RxString? profilePic;
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();

  RxBool isUserRegiserting = RxBool(false);
  RxList<Template>? templates = <Template>[].obs;
  // List<Template>? templatesB = <Template>[];
  // List<Template>? templatesA = <Template>[];
  // setBusinessLogo

  @override
  onInit() async {
    profilePic?.value = constuser?.profilePic ?? "";
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
    // var headers = {'Content-Type': 'application/json', "": token};
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
      Get.to(() => const ChooseTemplate(
            isReg: true,
            isUser: false,
          ));
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

  setUpPersonalAccount(String userName) async {
    isUserRegiserting.value = true;

    var token = await HiveDB.getAuthToken();
    var id = await HiveDB.getUserID();
    var headers = {'Content-Type': 'application/json', "Authorization": token!};
    Map body = {"_id": id, "displayName": userName, "personalTemplate": ""};
    http.Response response =
        await http.post(Uri.parse(ApiEndpoint.setupPeronalAccount), body: jsonEncode(body), headers: headers);

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      constuser = await HiveDB.getCurrentUserDetail();
      // debugPrint(data.toString());
      isUserRegiserting.value = false;
      //lead to main page
      Get.offAll(() => BottomNavBar(), transition: Transition.rightToLeftWithFade);

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
    debugPrint('${ApiEndpoint.uploadProfilePic}?userId=$globUserId');
    Map<String, String> header = {'Content-type': 'multipart/form-data', "Authorization": globToken!};
 
    var request = http.MultipartRequest('POST', Uri.parse('${ApiEndpoint.uploadProfilePic}?userId=$globUserId'));
    request.headers.addAll(header);

    if (image?.path != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'ProfilePic',
        image!.path,
        filename: image.name,
      ));
    }
    var response = await request.send();
    debugPrint("code${response.statusCode}");

    final res = await http.Response.fromStream(response);
    var data = jsonDecode(res.body);
    if (response.statusCode == 200) {
      //var hiveBox = Hive.box("secretes");
      constuser = UserSchema.fromJson(data['data']);
      //  await hiveBox.put('user', constuser);
      log(data.toString());
      debugPrint(data['data']['ProfilePic'].toString());
      if (constuser?.profilePic != null) {
        HiveDB.upateProfilePic(constuser!.profilePic!);
      }
      //  await jwtController.setProfileImage(data['data']['profilePic']);
      profilePic?.value = data['data']['ProfilePic'];
      return data['data']['ProfilePic'];
    } else {
      return 'https://media.istockphoto.com/photos/smiling-indian-business-man-working-on-laptop-at-home-office-young-picture-id1307615661?b=1&k=20&m=1307615661&s=170667a&w=0&h=Zp9_27RVS_UdlIm2k8sa8PuutX9K3HTs8xdK0UfKmYk=';
    }
  }

  Future<List<Template?>?> getAllTempltes() async {
    templates?.clear();
    try {
      var token = await HiveDB.getAuthToken();
      var headers = {'Content-Type': 'application/json', "Authorization": token!};

      http.Response response = await http.get(Uri.parse('${ApiEndpoint.template}?type=Individual'), headers: headers);
      var body = jsonDecode(response.body);
      debugPrint(body.toString());
      body.forEach((e) {
        var temp = Template.fromJson(e);
        templates?.add(temp);
      });
      // templates!.value = templatesA!;

      return templates;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<List<Template?>?> getAllTempltesforBusiness() async {
    try {
      templates?.clear();
      var token = await HiveDB.getAuthToken();
      var headers = {'Content-Type': 'application/json', "Authorization": token!};

      http.Response response = await http.get(Uri.parse('${ApiEndpoint.template}?type=Business'), headers: headers);
      var body = jsonDecode(response.body);
      debugPrint(body.toString());
      body.forEach((e) {
        var temp = Template.fromJson(e);
        templates?.add(temp);
      });
      //   templates!.value = templatesB!;
      //  return templatesB;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  userTemplate(
    String? templateId,
  ) async {
    var userId = await HiveDB.getUserID();
    var token = await HiveDB.getAuthToken();
    Map body = {"userId": userId, "templateId": templateId, "finalTemplateData": {}};
    var headers = {'Content-Type': 'application/json', "Authorization": token!};
    http.Response response = await http.post(
      Uri.parse(ApiEndpoint.userTemplate),
      headers: headers,
      body: jsonEncode(body),
    );
    // Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      constuser = await HiveDB.setCurrentUserDetail(addinList: true);
      // debugPrint(data.toString());
      isUserRegiserting.value = false;
      //lead to main page
      Get.offAll(() => BottomNavBar(), transition: Transition.rightToLeftWithFade);
    } else {
      Get.back();
    }
    //CustomSnackbar.showSucess('Your persona is set');
  }

  updateBio(String bio) async {
    final headers = {'Content-Type': 'application/json', 'Authorization': globToken!};
    final Map bodymain = {"bio": bio};

    debugPrint(ApiEndpoint.updateUserbio);
    debugPrint(bodymain.toString());
    http.Response response = await http.post(Uri.parse(ApiEndpoint.updateUserbio), body: jsonEncode(bodymain), headers: headers);
    // final Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");
    HiveDB.setCurrentUserDetail();
    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User DOB Updated");
    } else {
      // debugPrint(data.toString());
      //  CustomSnackbar.show(data.toString());
    }
  }
}
