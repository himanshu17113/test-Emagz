import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emagz_vendor/social_media/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../common/common_snackbar.dart';

import 'widgets/my_custom_textfiled.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final _firebaseAuth = FirebaseAuth.instance;
  final authController = Get.find<AuthController>();
  final jwtController = Get.find<JWTController>();
  final homePostController = Get.put(HomePostsController());
  final GetXStoryController storyController = Get.put(GetXStoryController());

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

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
                  } else if (authController.emailController.text.isEmpty ||
                      !authController.emailController.text.isEmail) {
                    CustomSnackbar.show("Please enter correct email ");
                  } else if (authController.dobController.text.isEmpty) {
                    CustomSnackbar.show("Please choose your dob");
                  } else if (authController.passwordController.text.isEmpty ||
                      authController.passwordController.text.length < 6) {
                    CustomSnackbar.show(
                        "Please enter at least 8 digit password! password must contain special charecter,numberic value ");
                  } else if (authController.passwordController.text !=
                      authController.confirmPasswordController.text) {
                    CustomSnackbar.show(
                        "Password and confirm passsword shuld be same");
                  } else {
                    bool res = await authController.registerUser();
                    if (res) {
                      authController.tabController!.index = 1;

                      if (jwtController.token == null ||
                          jwtController.token!.isEmpty ||
                          jwtController.userId == null) {
                        jwtController.token =
                            await jwtController.getAuthToken();
                        jwtController.userId = await jwtController.getUserId();
                      }

                      homePostController.skip.value = -10;
                      homePostController.posts?.clear();
                      storyController.stories?.clear();
                      await storyController.getStories();
                      await homePostController.getPost();
                      // await storyController.getStories();
                      // //  Get.offAll(() => Obx(() {
                      // homePostController.skip.value = -10;
                      // await homePostController.getPost();
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
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: unselectedLabel),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Center(
              child: Container(
                width: 200,
                // margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: whiteColor,
                      radius: 15,
                      backgroundImage: const CachedNetworkImageProvider(
                          "https://cdn-icons-png.flaticon.com/512/2991/2991148.png"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      backgroundColor: whiteColor,
                      radius: 15,
                      backgroundImage: const CachedNetworkImageProvider(
                          "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Platform.isIOS
                  ? SizedBox(
                      width: 400,
                      child: SignInWithAppleButton(
                          style: SignInWithAppleButtonStyle.black,
                          text: 'Sign In With Apple',
                          borderRadius: BorderRadius.circular(20),
                          onPressed: () async {
                            // To prevent replay attacks with the credential returned from Apple, we
                            // include a nonce in the credential request. When signing in in with
                            // Firebase, the nonce in the id token returned by Apple, is expected to
                            // match the sha256 hash of `rawNonce`.
                            final rawNonce = generateNonce();
                            final nonce = sha256ofString(rawNonce);

                            try {
                              // Request credential for the currently signed in Apple account.
                              final appleCredential =
                                  await SignInWithApple.getAppleIDCredential(
                                scopes: [
                                  AppleIDAuthorizationScopes.email,
                                  AppleIDAuthorizationScopes.fullName,
                                ],
                                nonce: nonce,
                              );

                              print(appleCredential.authorizationCode);

                              // Create an `OAuthCredential` from the credential returned by Apple.
                              final oauthCredential =
                                  OAuthProvider("apple.com").credential(
                                idToken: appleCredential.identityToken,
                                rawNonce: rawNonce,
                              );

                              // Sign in the user with Firebase. If the nonce we generated earlier does
                              // not match the nonce in `appleCredential.identityToken`, sign in will fail.
                              final authResult = await _firebaseAuth
                                  .signInWithCredential(oauthCredential);

                              final displayName =
                                  '${appleCredential.givenName} ${appleCredential.familyName}';
                              final userEmail = '${appleCredential.email}';
                              final photoUrl =
                                  '${appleCredential.identityToken}';
                              if (appleCredential.email != null &&
                                  appleCredential.givenName != null &&
                                  appleCredential.familyName != null &&
                                  appleCredential.identityToken != null) {
                                authController.appleRegister(
                                    appleCredential.email!,
                                    appleCredential.identityToken!,
                                    photoUrl,
                                    displayName);
                              } else {
                                Get.snackbar('Error',
                                    "Did not recieve credentials from Apple.");
                              }

                              final firebaseUser = authResult.user;
                              print(displayName);
                              print(firebaseUser?.displayName);
                              debugPrint(firebaseUser.toString());
                            } catch (exception) {
                              print(exception);
                            }
                          }),
                    )
                  : const SizedBox(),
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
