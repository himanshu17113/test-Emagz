import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/screens/choise/e_business_screen.dart';
import 'package:emagz_vendor/social_media/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/common_snackbar.dart';
import '../choise/e_business_screen.dart';
import 'widgets/my_custom_textfiled.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormHeadingText(
              color: signInHeading,
              headings: "Name",
            ),
            MyCustomTextfiled(
              controller: authController.userNameController,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              color: signInHeading,
              // headings: "E-mail / Phone no",
              headings: "E-mail",
            ),
            MyCustomTextfiled(
              inputType: TextInputType.emailAddress,
              controller: authController.emailController,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              color: signInHeading,
              headings: "Date of birth",
            ),
            MyCustomTextfiled(
              onTap: () async => await authController.pickDate(context),
              controller: authController.dobController,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              color: signInHeading,
              headings: "password",
            ),
            MyCustomTextfiled(
              controller: authController.passwordController,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              color: signInHeading,
              headings: "Confirm password",
            ),
            MyCustomTextfiled(
              controller: authController.confirmPasswordController,
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  if (authController.userNameController.text.isEmpty) {
                    CustomSnackbar.show("Please enter user name ");
                  } else if (authController.emailController.text.isEmpty || !authController.emailController.text.isEmail) {
                    CustomSnackbar.show("Please enter correct email ");
                  } else if (authController.dobController.text.isEmpty) {
                    CustomSnackbar.show("Please choose your dob");
                  } else if (authController.passwordController.text.isEmpty || authController.passwordController.text.length < 6) {
                    CustomSnackbar.show("Please enter at least 8 digit password! password must contain special charecter,numberic value ");
                  } else if (authController.passwordController.text != authController.confirmPasswordController.text) {
                    CustomSnackbar.show("Password and confirm passsword shuld be same");
                  } else {
                    bool res = await authController.registerUser();
                    if (res) {
                      authController.tabController!.index = 1;
                    } else {}
                  }
                },
                child: Obx(() {
                  return Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      gradient: buttonGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: authController.isUserRegiserting.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Sign Up",
                            style: TextStyle(color: whiteColor, fontSize: 15),
                          ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 1),
              child: Text(
                "Continue With",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: unselectedLabel),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Container(
              // margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: whiteColor,
                    radius: 15,
                    backgroundImage: const CachedNetworkImageProvider("https://cdn-icons-png.flaticon.com/512/2991/2991148.png"),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  CircleAvatar(
                    backgroundColor: whiteColor,
                    radius: 15,
                    backgroundImage: const CachedNetworkImageProvider(
                        "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
