import 'dart:convert';

import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/screens/support/support_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constant/api_string.dart';
import '../../social_media/controller/auth/jwtcontroller.dart';
class SupportController extends GetxController{
  var jwtController = Get.put(JWTController());

  RxList<SupportMsg>? supports=<SupportMsg>[].obs;
  @override
  onInit() async {
    getAllSupport();
    super.onInit();
  }


  Future<List<SupportMsg?>?> getAllSupport() async
  {
    if(supports!=null)supports!.clear();

      var token = await jwtController.getAuthToken();
      var headers = {'Content-Type': 'application/json', "Authorization": token!};

      http.Response response = await http.get(Uri.parse(ApiEndpoint.getAllSupport), headers: headers);
      var body = jsonDecode(response.body);
      body= body['data'];
      body.forEach((e) {
        var temp = SupportMsg.fromJson(e);
        supports?.add(temp);
      });
      return supports;
  }
  void postSupport(String email,String msg,String reason)async
  {
    var token = await jwtController.getAuthToken();
    var headers = {'Content-Type': 'application/json', "Authorization": token!};
    var body={
      "email":email,
      "reason":reason,
      "message":msg
    };


    http.Response response = await http.post(Uri.parse(ApiEndpoint.createSupport), headers: headers,body: jsonEncode(body));
    if(response.statusCode==200 || response.statusCode==201)
      {
        CustomSnackbar.showSucess('Your request has been accepted');
      }
    else
      {
        CustomSnackbar.show('Your request was not posted . Error');

      }
  }
}