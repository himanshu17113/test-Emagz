import 'dart:convert';

import 'package:emagz_vendor/constant/api_string.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/models/user_schema.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../common/common_snackbar.dart';
import '../auth/hive_db.dart';

class PrivacyController extends GetxController {
  privacyCommentControl(
      bool everyone, bool follower, bool follow, bool followFollowers) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': globToken!
    };
    Map bodymain = {
      "everyone": everyone,
      "followers": follower,
      "follow": follow,
      "follow_and_followers": followFollowers
    };
    Map body = {"comment_privacy": bodymain};
    debugPrint(ApiEndpoint.commentprivacy);
    debugPrint(body.toString());
    http.Response response = await http.post(
        Uri.parse(ApiEndpoint.commentprivacy),
        body: jsonEncode(body),
        headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");
    final user = UserSchema.fromJson(data["data"]);

    HiveDB.putUserDetail(user, jsonEncode(response.body));
    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Comment Privacy Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  privacyPostControl(bool everyone, bool followers, bool noOne) async {
    var token = await HiveDB.getAuthToken();
    var headers = {'Content-Type': 'application/json', 'Authorization': token!};
    Map bodymain = {
      "everyone": everyone,
      "followers": followers,
      "no_one": noOne,
    };
    Map body = {"post_privacy": bodymain};
    debugPrint(ApiEndpoint.postPrivacy);
    debugPrint(body.toString());
    http.Response response = await http.post(Uri.parse(ApiEndpoint.postPrivacy),
        body: jsonEncode(body), headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");
    final user = UserSchema.fromJson(data["data"]);

    HiveDB.putUserDetail(user, jsonEncode(response.body));
    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Post Privacy Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  privacyMentionControl(bool everyone, bool followers, bool noOne) async {
    var token = await HiveDB.getAuthToken();
    var headers = {'Content-Type': 'application/json', 'Authorization': token!};
    Map bodymain = {
      "everyone": everyone,
      "followers": followers,
      "no_one": noOne,
    };
    Map body = {"mention_privacy": bodymain};
    debugPrint(ApiEndpoint.mentionPrivacy);
    debugPrint(body.toString());
    http.Response response = await http.post(
        Uri.parse(ApiEndpoint.mentionPrivacy),
        body: jsonEncode(body),
        headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");
    final user = UserSchema.fromJson(data["data"]);

    HiveDB.putUserDetail(user, jsonEncode(response.body));
    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Mention Privacy Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  privacyStoryControl(bool everyone, bool closeFriends, bool specific,
      bool noOne, List<String?>? storySpecific) async {
    var token = await HiveDB.getAuthToken();
    var headers = {'Content-Type': 'application/json', 'Authorization': token!};
    Map bodymain = {
      "story_privacy": {
        "everyone": everyone,
        "close_friend": closeFriends,
        "specific": specific,
        "no_one": noOne
      },
      "storySpecific": ["64a519d688f60609a2163cf2"]
    };
    Map body = {"story_privacy": bodymain};
    http.Response response = await http.post(
        Uri.parse(ApiEndpoint.storyPrivacy),
        body: jsonEncode(body),
        headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");
    debugPrint(data.toString());
 
    HiveDB.setCurrentUserDetail();
    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Story Privacy Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  privacyLiveControl(bool everyone, bool followers, bool noone) async {
    var token = await HiveDB.getAuthToken();
    var headers = {'Content-Type': 'application/json', 'Authorization': token!};
    Map bodymain = {
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

    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Live Privacy Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }

  privacyMessageControl(bool everyone, bool followers, bool noOne) async {
    var token = await HiveDB.getAuthToken();
    var headers = {'Content-Type': 'application/json', 'Authorization': token!};
    Map bodymain = {
      "everyone": everyone,
      "followers": followers,
      "no_one": noOne,
    };
    Map body = {"message_privacy": bodymain};

    debugPrint(body.toString());
    http.Response response = await http.post(
        Uri.parse(ApiEndpoint.messagePrivacy),
        body: jsonEncode(body),
        headers: headers);
    Map data = jsonDecode(response.body);
    debugPrint("code${response.statusCode.toString()}");

    if (response.statusCode == 200) {
      CustomSnackbar.showSucess("User Message Privacy Updated");
    } else {
      debugPrint(data.toString());
      CustomSnackbar.show(data.toString());
    }
  }
}
