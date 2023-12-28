import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/screens/auth/forgot_password/change_password_screen.dart';
import 'package:emagz_vendor/screens/auth/forgot_password/otp_verification_screen.dart';
import 'package:emagz_vendor/screens/auth/signin_screen.dart';
import 'package:emagz_vendor/social_media/screens/account/business_profile_setup.dart';
import 'package:emagz_vendor/social_media/screens/account/personal_account.dart';
import 'package:emagz_vendor/social_media/screens/account/personal_profile_setup.dart';
import 'package:emagz_vendor/social_media/screens/intrest/choose_intrest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../../../common/common_snackbar.dart';
import '../../../constant/api_string.dart';
import 'hive_db.dart';

class AuthController {
  TabController? tabController;
  bool isUserRegiserting = false;
  bool isUserlogging = false;
  String suggestedName = "";
  RxString Otp = RxString("");
  String username = "";
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final forgotPasswordEmailController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String passwordText = '';
  bool isNumber = false;
  bool isUpperText = false;
  bool isLowerText = false;
  bool specialChar = false;
  bool length = false;

  final passWordController = TextEditingController();

  int? selectedChoiseIndex;
  Set<int> selectedChoices = {};
  Set<String> selectedInterest = {};
  appleRegister(
      String email, String password, String imgUrl, String fullName) async {
    try {
      Map<String, String> header = {
        'Content-type': 'application/json; charset=utf-8'
      };

      Map body = {
        "email": email,
        "password": password,
        "username": fullName,
        "dob": imgUrl
      };
      debugPrint(body.toString());
      debugPrint('Apple sign in Started');
      http.Response response = await http.post(
        Uri.parse(ApiEndpoint.register),
        headers: header,
        body: jsonEncode(body),
      );

      debugPrint(response.body);

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        isUserRegiserting = false;
        var token = data["token"];
        var userId = data["userId"];
        debugPrint("TOKEN : $token userId : $userId");
        HiveDB.setAuthData(token, userId);
        Get.off(() => const ChooseIntrestScreen());
        if (data['status'] == true) {
          Get.snackbar("Success", data['message']);
          Get.off(() => const ChooseIntrestScreen());
        }

        return true;
      } else if (response.statusCode == 201) {
        isUserRegiserting = false;
        var token = data["token"];
        var userId = data["userId"];
        debugPrint("TOKEN : $token userId : $userId");
        HiveDB.setAuthData(token, userId);
        if (data['status'] == true) {
          Get.snackbar("Success", data['message']);
          Get.off(() => const ChooseIntrestScreen());
        }

        return true;
      } else {
        Get.snackbar("Error", data['message']);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong! please try again later");
      Get.snackbar('Hey', 'User already existes with that email');
      return false;
    }
  }

  checkPassword(String v) {
    if (v.isEmpty) {
      isLowerText = false;
      isUpperText = false;
      isNumber = false;
      length = false;
      specialChar = false;
    }
    if (RegExp(r'[A-Z]').hasMatch(v)) {
      isUpperText = true;
    } else {
      isUpperText = false;
    }
    if (RegExp(r'[a-z]').hasMatch(v)) {
      isLowerText = true;
    } else {
      isLowerText = false;
    }
    if (RegExp(r'[0-9]').hasMatch(v)) {
      isNumber = true;
    } else {
      isNumber = false;
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(v)) {
      specialChar = true;
    } else {
      specialChar = false;
    }
    if (v.length > 8) {
      length = true;
    } else {
      length = false;
    }
  }

  Future<bool> registerUser() async {
    try {
      isUserRegiserting = true;

      var headers = {'Content-Type': 'application/json'};
      Map body = {
        "username": userNameController.text,
        "email": emailController.text,
        "dob": dobController.text,
        "password": passwordController.text,
        "uniqueName": "ghfhfhg"
      };
      debugPrint(ApiEndpoint.register);
      //debugPrint(body.toString());
      http.Response response = await http.post(Uri.parse(ApiEndpoint.register),
          body: jsonEncode(body), headers: headers);

      debugPrint(response.body);
      Map data = jsonDecode(response.body);
      // debugPrint("code${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        clearValue();
        CustomSnackbar.showSucess("User Registered Successfully");
        isUserRegiserting = false;
        final token = data["token"];
        final userId = data["userId"];
        debugPrint("TOKEN : $token userId : $userId");
        globToken = token;
        globUserId = userId;
        HiveDB.setAuthData(token, userId);

        return true;
      } else if (response.statusCode == 401) {
        CustomSnackbar.show(data['error']);
        isUserRegiserting = false;
        return false;
      } else if (response.statusCode == 400) {
        CustomSnackbar.show(data['error']);
        isUserRegiserting = false;
        return false;
      } else {
        CustomSnackbar.show("User Registration Failed ! Try again later");
        isUserRegiserting = false;
        return false;
      }
    } catch (e) {
      CustomSnackbar.show(e.toString());
      debugPrint(e.toString());
      isUserRegiserting = false;
      return false;
    }
  }

  Future<bool> appleSignIn(String email, String password) async {
    try {
      isUserlogging = true;
      Map body = {
        "email": email,
        "password": password,
      };
      var headers = {'Content-Type': 'application/json'};

      var response = await http.post(Uri.parse(ApiEndpoint.login),
          body: jsonEncode(body), headers: headers);
      var data = jsonDecode(response.body);

      debugPrint(data["data"]["_id"]);
      if (response.statusCode == 200) {
        clearValue();
        CustomSnackbar.showSucess("User Loggedin Successfully");
        await HiveDB.setAuthData(data["token"], data["data"]["_id"]);
        await HiveDB.getCurrentUserDetail();

        globToken = data["token"].toString();
        globUserId = data["data"]["_id"].toString();
        //   jwtController.isAuthorised.value = true;

        isUserlogging = false;
        return true;
      } else if (response.statusCode == 401) {
        CustomSnackbar.show(data['message']);
        isUserlogging = false;
        return false;
      } else if (response.statusCode == 400) {
        CustomSnackbar.show(data['error']);
        isUserlogging = false;
        return false;
      } else {
        CustomSnackbar.show("User Registration Failed ! Try again later");
        isUserlogging = false;
        return false;
      }
    } catch (e) {
      CustomSnackbar.show(e.toString());
      isUserlogging = false;
      return false;
    }
  }

  Future<bool> signInuser() async {
    try {
      isUserlogging = true;
      Map body = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      var headers = {'Content-Type': 'application/json'};

      var response = await http.post(Uri.parse(ApiEndpoint.login),
          body: jsonEncode(body), headers: headers);
      var data = jsonDecode(response.body);

      debugPrint(data["data"]["_id"]);
      if (response.statusCode == 200) {
        clearValue();
        CustomSnackbar.showSucess("User Loggedin Successfully");
        await HiveDB.setAuthData(data["token"], data["data"]["_id"]);
        await HiveDB.setCurrentUserDetail();
        // //   jwtController.isAuthorised.value = true;

        isUserlogging = false;
        return true;
      } else if (response.statusCode == 401) {
        CustomSnackbar.show(data['message']);
        isUserlogging = false;
        return false;
      } else if (response.statusCode == 400) {
        CustomSnackbar.show(data['error']);
        isUserlogging = false;
        return false;
      } else {
        CustomSnackbar.show("User Registration Failed ! Try again later");
        isUserlogging = false;
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      isUserlogging = false;
      return false;
    }
  }

  clearValue() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    dobController.clear();
    userNameController.clear();
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dobController.text = formattedDate;
    } else {
      dobController.clear();
    }
  }

  addSelectedChoice(int index) {
    selectedChoices.add(index);
  }

  postUserProfileType(int value, String userName) async {
    username = userName;
    isUserlogging = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": (globToken ?? await HiveDB.getAuthToken())!
      };
      var accountTypes = ["Error", "personal", "professional"];
      Map body = {"accountType": accountTypes[value]};
      http.Response response = await http.put(
          Uri.parse(ApiEndpoint.accountType(
              (globUserId ?? await HiveDB.getUserID())!)),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        (value == 1)
            ? Get.to(() => PersonalProfileSetup(
                  username: username,
                ))
            : Get.to(() => const BusinessProfileSetupScreen());
      }
      isUserlogging = false;
    } catch (e) {
      CustomSnackbar.show("An Error occured");
      isUserlogging = false;
    }
  }

  sendForgotPasswordRequest() async {
    isUserRegiserting = true;
    var email = forgotPasswordEmailController.text;
    if (email == "") {
      CustomSnackbar.show("Please Enter email or Password");
    }
    var headers = {'Content-Type': 'application/json'};
    Map body = {"email": email};
    http.Response response = await http.post(Uri.parse(ApiEndpoint.sendOtp),
        body: jsonEncode(body), headers: headers);
    debugPrint(response.body);
    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      isUserRegiserting = false;
      Otp.value = responseData["otp"].toString();
      Get.snackbar(
        "One Time Password",
        Otp.value,
        backgroundColor: Colors.white24,
        duration: const Duration(seconds: 40),
        colorText: Colors.white,
      );
      Get.off(() => const OtpVerificationScreen());
    } else {
      isUserRegiserting = false;
      CustomSnackbar.show("Varification Failed");
    }
  }

  verifyOtp(String typedOtp) async {
    Otp.value = "";
    isUserRegiserting = true;
    var email = forgotPasswordEmailController.text;
    var headers = {'Content-Type': 'application/json'};
    Map body = {"email": email, "otp": typedOtp};
    // debugPrint(body);
    http.Response response = await http.post(Uri.parse(ApiEndpoint.verifyOtp),
        body: jsonEncode(body), headers: headers);
    var responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isUserRegiserting = false;
      Get.snackbar(
        "Success",
        "${responseData["message"]}",
        colorText: Colors.white,
      );
      Get.off(() => const ChangePasswordScreen());
      isUserRegiserting = false;
    } else {
      debugPrint(response.body);
      CustomSnackbar.show("Varification Failed");
      isUserRegiserting = false;
    }
  }

  changePassword(String newPassword) async {
    isUserRegiserting = true;
    var headers = {'Content-Type': 'application/json'};
    Map body = {
      "email": forgotPasswordEmailController.text,
      "password": newPassword
    };
    http.Response response = await http.post(
        Uri.parse(ApiEndpoint.changePassword),
        body: jsonEncode(body),
        headers: headers);
    //  var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isUserRegiserting = false;
      CustomSnackbar.show("password reset Successful");
      Get.to(() => const SignInScreen());
      isUserRegiserting = false;
    } else {
      isUserRegiserting = false;
      CustomSnackbar.show("Can't reset password");
    }
  }

  postChoices() async {
    try {
      isUserlogging = true;

      var headers = {
        'Content-Type': 'application/json',
        "Authorization": (globToken ?? await HiveDB.getAuthToken())!
      };

      Map body = {
        "_id": (globUserId ?? await HiveDB.getUserID())!,
        "interestName": selectedChoices.toList(),
      };
      http.Response response = await http.post(
          Uri.parse(ApiEndpoint.chooseIntrest),
          body: jsonEncode(body),
          headers: headers);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        http.Response uniqueNameResponse = await http.get(
            Uri.parse(ApiEndpoint.uniqueName(
                (globUserId ?? await HiveDB.getUserID())!)),
            headers: headers);
        var uniqRes = jsonDecode(uniqueNameResponse.body);
        suggestedName = uniqRes["GetstatedName"];
        isUserlogging = false;
        Get.to(() => PersonalAccountScreen(suggestedName: suggestedName),
            transition: Transition.rightToLeft);
      } else {
        isUserlogging = false;
        CustomSnackbar.show("Cant Proceed Further");
      }
    } catch (e) {
      isUserlogging = false;
      CustomSnackbar.show("An Error occured");
    }
  }

  bool isSelectedInterest(int index) {
    return selectedChoices.contains(index);
  }
}
