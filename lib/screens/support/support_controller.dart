import 'dart:convert';

import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/screens/support/support_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constant/api_string.dart';
import '../../social_media/controller/auth/hive_db.dart';
import 'ticket_modal.dart';

class SupportController extends GetxController {
  RxList<SupportMsg>? supports = <SupportMsg>[].obs;
  List<Ticket> tickets = [];
  List<Ticket> ticketsClosed = [];
  @override
  onInit() {
    getAllTicketbyID();
    //  getAllSupportbyID();
    // getAllSupport();
    super.onInit();
  }

  void getAllSupportbyID() async {
    if (supports != null) supports!.clear();
    String token = (globToken ?? await HiveDB.getAuthToken())!;
    var headers = {'Content-Type': 'application/json', "Authorization": token};

    http.Response response = await http.get(Uri.parse("${ApiEndpoint.getSupportById}/$globUserId"), headers: headers);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      body = body['data'];
      SupportMsg? temp;
      body.forEach((e) {
        temp = SupportMsg.fromJson(e);
        supports?.add(temp!);
      });
    }
  }

  void getAllTicketbyID() async {
    if (tickets.isNotEmpty) tickets.clear();
    String token = (globToken ?? await HiveDB.getAuthToken())!;
    var headers = {'Content-Type': 'application/json', "Authorization": token};

    http.Response response = await http.get(Uri.parse(ApiEndpoint.getTicketbyUserId(globUserId!)), headers: headers);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      body = body['data'];
      Ticket? temp;
      body.forEach((e) {
        temp = Ticket.fromMap(e);
        temp!.ticketStaus! ? tickets.add(temp!) : ticketsClosed.addNonNull(temp!);
      });
      update(["support"]);
    }
  }

  Future<List<SupportMsg?>?> getAllSupport() async {
    if (supports != null) supports!.clear();

    String token = (globToken ?? await HiveDB.getAuthToken())!;
    var headers = {'Content-Type': 'application/json', "Authorization": token};

    http.Response response = await http.get(Uri.parse(ApiEndpoint.getAllSupport), headers: headers);
    var body = jsonDecode(response.body);
    body = body['data'];
    body.forEach((e) {
      var temp = SupportMsg.fromJson(e);
      supports?.add(temp);
    });
    return supports;
  }

  void postSupport(String email, String msg, String reason) async {
    String? token = await HiveDB.getAuthToken();
    var headers = {'Content-Type': 'application/json', "Authorization": token!};
    var body = {"email": email, "reason": reason, "message": msg};

    http.Response response = await http.post(Uri.parse(ApiEndpoint.createSupport), headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      getAllSupportbyID();
      print(response.body.toString());
      CustomSnackbar.showSucess('Your request has been accepted');
    } else {
      CustomSnackbar.show('Your request was not posted . Error');
    }
  }
}
