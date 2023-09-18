import 'package:emagz_vendor/screens/auth/forgot_password/change_password_screen.dart';
import 'package:emagz_vendor/screens/auth/forgot_password/otp_verification_screen.dart';
import 'package:emagz_vendor/screens/auth/signin_screen.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
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

class AuthController extends GetxController {
  TabController? tabController;
  RxBool isUserRegiserting = false.obs;
  RxBool isUserlogging = false.obs;
  RxString suggestedName = RxString("");
  RxString Otp = RxString("");

  var jwtController = Get.put(JWTController());

  final userNameController = TextEditingController();
  // conflict between username and Name
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final forgotPasswordEmailController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxString passwordText = ''.obs;
  RxBool isNumber = false.obs;
  RxBool isUpperText = false.obs;
  RxBool isLowerText = false.obs;
  RxBool specialChar = false.obs;
  RxBool length = false.obs;

  final passWordController = TextEditingController();

  int? selectedChoiseIndex;
  Set<int> selectedChoices = {};
  Set<String> selectedInterest = {};
  appleRegister(String email, String password, String imgUrl, String fullName) async {
    try {

      Map<String, String> header = {'Content-type': 'application/json'};

      Map body = {"email": email, "password": password, "username": fullName, "dob": imgUrl};
      debugPrint(body.toString());
      print('Apple sign in Started');
      http.Response response = await http.post(
        Uri.parse(ApiEndpoint.register),
        headers: header,
        body: jsonEncode(body),
      );
      debugPrint('Hii');
      debugPrint(response.body);
      debugPrint(response.body);

      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['status'] == true) {

          Get.snackbar("Success", data['message']);
          Get.off(() => const ChooseIntrestScreen());
        }

        return true;
      } else if (response.statusCode == 201) {
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
      debugPrint(e.toString());
      return false;
    }
  }
  checkPassword(String v) {
    if (v.isEmpty) {
      isLowerText.value = false;
      isUpperText.value = false;
      isNumber.value = false;
      length.value = false;
      specialChar.value = false;
    }
    if (RegExp(r'[A-Z]').hasMatch(v)) {
      isUpperText.value = true;
    } else {
      isUpperText.value = false;
    }
    if (RegExp(r'[a-z]').hasMatch(v)) {
      isLowerText.value = true;
    } else {
      isLowerText.value = false;
    }
    if (RegExp(r'[0-9]').hasMatch(v)) {
      isNumber.value = true;
    } else {
      isNumber.value = false;
    }
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(v)) {
      specialChar.value = true;
    } else {
      specialChar.value = false;
    }
    if (v.length > 8) {
      length.value = true;
    } else {
      length.value = false;
    }
  }

  Future<bool> registerUser() async {
    try {
      isUserRegiserting.value = true;

      var headers = {'Content-Type': 'application/json'};
      Map body = {
        "username": userNameController.text,
        "email": emailController.text,
        "dob": dobController.text,
        "password": passwordController.text,
      };
      debugPrint(ApiEndpoint.register);
      debugPrint(body.toString());
      http.Response response = await http.post(Uri.parse(ApiEndpoint.register), body: jsonEncode(body), headers: headers);

      debugPrint(response.body);
      Map data = jsonDecode(response.body);
      debugPrint("code${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        clearValue();
        CustomSnackbar.showSucess("User Registered Successfully");
        isUserRegiserting.value = false;
        var token = data["token"];
        var userId = data["userId"];
        debugPrint("TOKEN : $token userId : $userId");
        jwtController.setAuthToken(token, userId);
        Get.to(() => const ChooseIntrestScreen(), transition: Transition.rightToLeftWithFade);
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
    } catch (e) {
      CustomSnackbar.show(e.toString());
      debugPrint(e.toString());
      isUserRegiserting.value = false;
      return false;
    }
  }
  Future<bool> appleSignIn(String email,String password)async{
    try {
      isUserlogging.value = true;
      Map body = {
        "email": email,
        "password": password,
      };
      var headers = {'Content-Type': 'application/json'};

      var response = await http.post(Uri.parse(ApiEndpoint.login), body: jsonEncode(body), headers: headers);
      var data = jsonDecode(response.body);

      debugPrint(data["data"]["_id"]);
      if (response.statusCode == 200) {
        clearValue();
        CustomSnackbar.showSucess("User Loggedin Successfully");
        await jwtController.setAuthToken(data["token"], data["data"]["_id"]);
        jwtController.token = data["token"].toString();
        jwtController.userId = data["data"]["_id"].toString();
        jwtController.isAuthorised.value = true;

        isUserlogging.value = false;
        return true;
      } else if (response.statusCode == 401) {
        CustomSnackbar.show(data['message']);
        isUserlogging.value = false;
        return false;
      } else if (response.statusCode == 400) {
        CustomSnackbar.show(data['error']);
        isUserlogging.value = false;
        return false;
      } else {
        CustomSnackbar.show("User Registration Failed ! Try again later");
        isUserlogging.value = false;
        return false;
      }
    } catch (e) {
      CustomSnackbar.show(e.toString());
      isUserlogging.value = false;
      return false;
    }
  }
  Future<bool> signInuser() async {
    try {
      isUserlogging.value = true;
      Map body = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      var headers = {'Content-Type': 'application/json'};

      var response = await http.post(Uri.parse(ApiEndpoint.login), body: jsonEncode(body), headers: headers);
      var data = jsonDecode(response.body);

      debugPrint(data["data"]["_id"]);
      if (response.statusCode == 200) {
        clearValue();
        CustomSnackbar.showSucess("User Loggedin Successfully");
        await jwtController.setAuthToken(data["token"], data["data"]["_id"]);
        jwtController.token = data["token"].toString();
        jwtController.userId = data["data"]["_id"].toString();
        jwtController.isAuthorised.value = true;

        isUserlogging.value = false;
        return true;
      } else if (response.statusCode == 401) {
        CustomSnackbar.show(data['message']);
        isUserlogging.value = false;
        return false;
      } else if (response.statusCode == 400) {
        CustomSnackbar.show(data['error']);
        isUserlogging.value = false;
        return false;
      } else {
        CustomSnackbar.show("User Registration Failed ! Try again later");
        isUserlogging.value = false;
        return false;
      }
    } catch (e) {
      CustomSnackbar.show(e.toString());
      isUserlogging.value = false;
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
    DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime.now());
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

  postUserProfileType(int value) async {
    isUserlogging.value = true;
    try {
      var userId = await jwtController.getUserId();
      var token = await jwtController.getAuthToken();
      var headers = {'Content-Type': 'application/json', "Authorization": token!};
      var accountTypes = ["Error", "personal", "professional"];
      Map body = {"accountType": accountTypes[value]};
      http.Response response = await http.put(Uri.parse(ApiEndpoint.accountType(userId!)), body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        (value == 1) ? Get.to(() => PersonalProfileSetup()) : Get.to(() => const BusinessProfileSetupScreen());
      }
      isUserlogging.value = false;
    } catch (e) {
      CustomSnackbar.show("An Error occured");
      isUserlogging.value = false;
    }
  }

  sendForgotPasswordRequest() async {
    isUserRegiserting.value = true;
    var email = forgotPasswordEmailController.text;
    if (email == "") {
      CustomSnackbar.show("Please Enter email or Password");
    }
    var headers = {'Content-Type': 'application/json'};
    Map body = {"email": email};
    http.Response response = await http.post(Uri.parse(ApiEndpoint.sendOtp), body: jsonEncode(body), headers: headers);
    debugPrint(response.body);
    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      isUserRegiserting.value = false;
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
      isUserRegiserting.value = false;
      CustomSnackbar.show("Varification Failed");
    }
  }

  verifyOtp(String typedOtp) async {
    Otp.value = "";
    isUserRegiserting.value = true;
    var email = forgotPasswordEmailController.text;
    var headers = {'Content-Type': 'application/json'};
    Map body = {"email": email, "otp": typedOtp};
    // debugPrint(body);
    http.Response response = await http.post(Uri.parse(ApiEndpoint.verifyOtp), body: jsonEncode(body), headers: headers);
    var responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isUserRegiserting.value = false;
      Get.snackbar(
        "Success",
        "${responseData["message"]}",
        colorText: Colors.white,
      );
      Get.off(() => const ChangePasswordScreen());
      isUserRegiserting.value = false;
    } else {
      debugPrint(response.body);
      CustomSnackbar.show("Varification Failed");
      isUserRegiserting.value = false;
    }
  }

  changePassword(String newPassword) async {
    isUserRegiserting.value = true;
    var headers = {'Content-Type': 'application/json'};
    Map body = {"email": forgotPasswordEmailController.text, "password": newPassword};
    http.Response response = await http.post(Uri.parse(ApiEndpoint.changePassword), body: jsonEncode(body), headers: headers);
    //  var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isUserRegiserting.value = false;
      CustomSnackbar.show("password reset Successful");
      Get.to(() => const SignInScreen());
      isUserRegiserting.value = false;
    } else {
      isUserRegiserting.value = false;
      CustomSnackbar.show("Can't reset password");
    }
  }

  postChoices() async {
    try {
      isUserlogging.value = true;

      var token = await jwtController.getAuthToken();
      var headers = {'Content-Type': 'application/json', "Authorization": token!};
      var userId = await jwtController.getUserId();
      Map body = {
        "_id": userId,
        "interestName": selectedChoices.toList(),
      };
      http.Response response = await http.post(Uri.parse(ApiEndpoint.chooseIntrest), body: jsonEncode(body), headers: headers);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        http.Response uniqueNameResponse = await http.get(Uri.parse(ApiEndpoint.uniqueName(userId!)), headers: headers);
        var uniqRes = jsonDecode(uniqueNameResponse.body);
        suggestedName.value = uniqRes["GetstatedName"];
        isUserlogging.value = false;
        Get.to(PersonalAccountScreen(suggestedName: suggestedName.value), transition: Transition.rightToLeft);
      } else {
        isUserlogging.value = false;
        CustomSnackbar.show("Cant Proceed Further");
      }
    } catch (e) {
      isUserlogging.value = false;
      CustomSnackbar.show("An Error occured");
    }
  }

  bool isSelectedInterest(int index) {
    return selectedChoices.contains(index);
  }
}
