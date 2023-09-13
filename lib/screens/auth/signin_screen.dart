import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/auth_controller.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_snackbar.dart';
import '../../social_media/common/bottom_nav/bottom_nav.dart';
import '../../social_media/controller/home/home_controller.dart';
import 'forgot_password/forgot_password_screen.dart';
import 'widgets/form_haeding_text.dart';
import 'widgets/my_custom_textfiled.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final homePostController = Get.put(HomePostsController());

  final authController = Get.put(AuthController());

  var jwtController = Get.put(JWTController());
  final GetXStoryController storyController = Get.put(GetXStoryController());

  // @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .05,
            ),
            FormHeadingText(
              fontWeight: FontWeight.w500,
              color: blackButtonColor,
              headings: "E-mail",
            ),
            MyCustomTextfiled(
              controller: authController.emailController,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              fontWeight: FontWeight.w500,
              color: blackButtonColor,
              headings: "Password",
            ),
            MyCustomTextfiled(
              controller: authController.passwordController,
            ),
            SizedBox(
              height: size.height * .02,
            ),
            InkWell(
              onTap: () {
                Get.off(() => const ForgetPasswordScreen());
              },
              child: Container(
                // margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.centerRight,
                child: FormHeadingText(
                  headings: "Forgot Password ?",
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  if (authController.emailController.text.isEmpty || !authController.emailController.text.isEmail) {
                    CustomSnackbar.show("Please enter correct email ");
                  } else if (authController.passwordController.text.isEmpty) {
                    CustomSnackbar.show("Please enter at least correct password!");
                  } else {
                    bool res = await authController.signInuser();
                    if (res) {
                      if (jwtController.token == null || jwtController.token!.isEmpty || jwtController.userId == null) {
                        await jwtController.getAuthToken();
                        await jwtController.getUserId();
                      }
                       
                      homePostController.skip.value = -10;
                      homePostController.posts?.clear();
                      storyController.stories?.clear();
                     await storyController.getStories();
                    await  homePostController.getPost();
                      // await storyController.getStories();
                      // //  Get.offAll(() => Obx(() {
                      // homePostController.skip.value = -10;
                      // await homePostController.getPost();

                      if (homePostController.posts!.isNotEmpty  ) {
                        //    Get.appUpdate();
                        Get.offAll(const BottomNavBar());
                      }
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
                    child: authController.isUserlogging.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Sign In",
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
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: blackButtonColor),
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
                    radius: 15,
                    backgroundColor: whiteColor,
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
