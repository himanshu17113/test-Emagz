import 'dart:convert';

import 'package:emagz_vendor/constant/api_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../common/common_snackbar.dart';
import '../auth/jwtcontroller.dart';
class PrivacyController extends GetxController{
  var jwtController = Get.put(JWTController());


  privacyCommentControl(bool everyone,bool follower, bool follow,bool followFollowers ) async
  {
    var token = await jwtController.getAuthToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token!
    };
    Map bodymain={
      "everyone": everyone,
      "followers": follower,
      "follow": follow,
      "follow_and_followers": followFollowers
    };
    Map body = {"comment_privacy": bodymain};
    debugPrint(ApiEndpoint.commentprivacy);
    debugPrint(body.toString());
    http.Response response = await http.post(Uri.parse(ApiEndpoint.commentprivacy),
        body: jsonEncode(body), headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");

    if(response.statusCode==200)
      {
        CustomSnackbar.showSucess("User Comment Privacy Updated");
      }
    else{
      print(data.toString());
      CustomSnackbar.show(data.toString());
    }

  }
  privacyPostControl(bool everyone,bool followers, bool no_one ) async
  {
    var token = await jwtController.getAuthToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token!
    };
    Map bodymain={
      "everyone": everyone,
      "followers": followers,
      "no_one": no_one,
    };
    Map body = {"post_privacy": bodymain};
    debugPrint(ApiEndpoint.postPrivacy);
    debugPrint(body.toString());
    http.Response response = await http.post(Uri.parse(ApiEndpoint.postPrivacy),
        body: jsonEncode(body), headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");

    if(response.statusCode==200)
    {
      CustomSnackbar.showSucess("User Post Privacy Updated");
    }
    else{
      print(data.toString());
      CustomSnackbar.show(data.toString());
    }

  }
  privacyMentionControl(bool everyone,bool followers, bool no_one ) async
  {
    var token = await jwtController.getAuthToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token!
    };
    Map bodymain={
      "everyone": everyone,
      "followers": followers,
      "no_one": no_one,
    };
    Map body = {"mention_privacy": bodymain};
    debugPrint(ApiEndpoint.mentionPrivacy);
    debugPrint(body.toString());
    http.Response response = await http.post(Uri.parse(ApiEndpoint.mentionPrivacy),
        body: jsonEncode(body), headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");

    if(response.statusCode==200)
    {
      CustomSnackbar.showSucess("User Mention Privacy Updated");
    }
    else{
      print(data.toString());
      CustomSnackbar.show(data.toString());
    }

  }
  privacyStoryControl(bool everyone,bool closeFriends) async
  {
    var token = await jwtController.getAuthToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token!
    };
    Map bodymain={
      "everyone": everyone,
      "close_friend":closeFriends,

    };
    Map body = {"story_privacy": bodymain};
    http.Response response = await http.post(Uri.parse(ApiEndpoint.storyPrivacy),
        body: jsonEncode(body), headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");
    debugPrint(body.toString());
    if(response.statusCode==200)
    {
      CustomSnackbar.showSucess("User Mention Privacy Updated");
    }
    else{
      print(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }
  privacyLiveControl(bool everyone,bool followers,bool noone) async
  {
    var token = await jwtController.getAuthToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token!
    };
    Map bodymain={
      "everyone": everyone,
      "followers": followers,
      "no_one": noone,
    };
    Map body = {"live_privacy": bodymain};
    debugPrint(ApiEndpoint.livePrivacy);
    debugPrint(body.toString());
    http.Response response = await http.post(Uri.parse(ApiEndpoint.livePrivacy),
        body: jsonEncode(body), headers: headers);
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
  privacyMessageControl(bool everyone,bool followers, bool no_one ) async
  {
    var token = await jwtController.getAuthToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token!
    };
    Map bodymain={
      "everyone": everyone,
      "followers": followers,
      "no_one": no_one,
    };
    Map body = {"message_privacy": bodymain};

    debugPrint(body.toString());
    http.Response response = await http.post(Uri.parse(ApiEndpoint.messagePrivacy),
        body: jsonEncode(body), headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");

    if(response.statusCode==200)
    {
      CustomSnackbar.showSucess("User Message Privacy Updated");
    }
    else{
      print(data.toString());
      CustomSnackbar.show(data.toString());
    }

  }
}