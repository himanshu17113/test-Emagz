import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/account/business_account_confirmation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import "package:emagz_vendor/constant/api_string.dart";
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';

import '../../../../templates/choose_template/template_model.dart';

class SetupAccount extends GetxController {

  var jwtController = Get.put(JWTController());

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();

  RxBool isUserRegiserting = RxBool(false);
  RxList<Template>? templates=<Template>[].obs;
  // setBusinessLogo

  @override
  onInit() async {
    getAllTempltes();
    super.onInit();
  }
  checkUserName() async {
    // will recive api
    return false;
  }

  setUpProfessionalAccount(XFile imageFile) async {
    isUserRegiserting.value = true;
    var token = await jwtController.getAuthToken();
    var id = await jwtController.getUserId();
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token!;
    var headers = {'Content-Type': 'application/json',"":token};
    FormData body = FormData.fromMap({
      "_id": id,
      //todo implement multipart file upload when backend is ready
      "businessLogo": MultipartFile.fromFileSync(imageFile.path),
      "businessName": businessNameController.text,
      "businessType": businessTypeController.text,
      "personalTemplate": "https://example.com/personal-template.html"
    });
    var response = await dio.post(
        ApiEndpoint.setupProfessionalAccount,
        data: body);

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

    var token = await jwtController.getAuthToken();
    var id = await jwtController.getUserId();
    var headers = {'Content-Type': 'application/json',"Authorization":token!};
    Map body = {
      "_id": id,
      "displayName": displayNameController.text,
      "personalTemplate": "https://example.com/personal-template.html"
    };
    http.Response response = await http.post(
        Uri.parse(ApiEndpoint.setupPeronalAccount),
        body: jsonEncode(body),
        headers: headers);

    Map data = jsonDecode(response.body);

    if (response.statusCode == 200) {

      isUserRegiserting.value = false;
      //lead to main page

      Get.to(
        () => const BottomNavBar(),
          transition: Transition.rightToLeftWithFade);
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

  Future<String> uploadProfilePic(XFile? image) async{
    var token = await jwtController.getAuthToken();
    var id= await jwtController.getUserId();
    Map<String, String> header = {'Content-type': 'multipart/form-data'};
    Map<String,String> header2={"Authorization":token!};
    var request = http.MultipartRequest('POST', Uri.parse('${ApiEndpoint.uploadProfilePic}?userId=$id'));
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
    if(response.statusCode==200)
      {
        print(data.toString());
        print(data['data']['ProfilePic']);
        await jwtController.setProfileImage(data['data']['ProfilePic']);
        return data['data']['ProfilePic'];
      }
    else
      {
        print('error');
        return 'https://media.istockphoto.com/photos/smiling-indian-business-man-working-on-laptop-at-home-office-young-picture-id1307615661?b=1&k=20&m=1307615661&s=170667a&w=0&h=Zp9_27RVS_UdlIm2k8sa8PuutX9K3HTs8xdK0UfKmYk=';
      }
  }

  Future<List<Template?>?> getAllTempltes() async {
    if(templates!=null)templates!.clear();
    try{
      var token = await jwtController.getAuthToken();
      var headers = {'Content-Type': 'application/json', "Authorization": token!};

      http.Response response = await http.get(Uri.parse(ApiEndpoint.template), headers: headers);
      var body = jsonDecode(response.body);
      print(body);
      body.forEach((e) {
        var temp = Template.fromJson(e);
        templates?.add(temp);
      });
      return templates;
    }
    catch(e)
    {
      print(e);
    }
    return null;

  }

  userTemplate(String? templateId) async
  {
    var userId= await jwtController.getUserId();
    var token = await jwtController.getAuthToken();
    Map body = {
      "userId": userId,
      "templateId": templateId,
      "finalTemplateData": {}
    };
    var headers = {'Content-Type': 'application/json', "Authorization": token!};
    http.Response response = await http.post(Uri.parse(ApiEndpoint.userTemplate), headers: headers,body: jsonEncode(body),);
    Map data= jsonDecode(response.body);
    if(response.statusCode==200)
      {
        //CustomSnackbar.showSucess('Your persona is set');
        Get.back();
      }
    else{
      print('expected error');
      Get.back();
    }

  }
}
