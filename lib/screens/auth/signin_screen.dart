import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emagz_vendor/social_media/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../common/common_snackbar.dart';

import 'widgets/my_custom_textfiled.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/auth_controller.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final homePostController = Get.put(HomePostsController());
  final _firebaseAuth = FirebaseAuth.instance;

  final authController = Get.find<AuthController>();

  var jwtController = Get.put(JWTController());
  final GetXStoryController storyController = Get.put(GetXStoryController());

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                  if (authController.emailController.text.isEmpty ||
                      !authController.emailController.text.isEmail) {
                    CustomSnackbar.show("Please enter correct email ");
                  } else if (authController.passwordController.text.isEmpty) {
                    CustomSnackbar.show(
                        "Please enter at least correct password!");
                  } else {
                    bool res = await authController.signInuser();
                    if (res) {
                      if (jwtController.token == null ||
                          jwtController.token!.isEmpty ||
                          jwtController.userId == null) {
                        await jwtController.getAuthToken();
                        await jwtController.getUserId();
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

                      if (homePostController.posts!.isNotEmpty) {
                        //    Get.appUpdate();
                        Get.offAll(() => const BottomNavBar());
                      }
                    } else {}
                  }
                },
                child: Obx(() {
                  return Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
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
                style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: blackButtonColor),
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
                  GestureDetector(
                    onTap: () {
                      debugPrint('kovid');
                      _handleSignIn();
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: whiteColor,
                      backgroundImage: const CachedNetworkImageProvider(
                          "https://cdn-icons-png.flaticon.com/512/2991/2991148.png"),
                    ),
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
            Center(
              child: Platform.isIOS ?
              Container(
                width: 400,
                child: SignInWithAppleButton(
                    style: SignInWithAppleButtonStyle.black,
                    text: 'Sign In With Apple',
                    borderRadius: BorderRadius.circular(20),
                    onPressed: () async
                    {
                      // To prevent replay attacks with the credential returned from Apple, we
                      // include a nonce in the credential request. When signing in in with
                      // Firebase, the nonce in the id token returned by Apple, is expected to
                      // match the sha256 hash of `rawNonce`.
                      final rawNonce = generateNonce();
                      final nonce = sha256ofString(rawNonce);

                      try {
                        // Request credential for the currently signed in Apple account.
                        final appleCredential = await SignInWithApple
                            .getAppleIDCredential(
                          scopes: [
                            AppleIDAuthorizationScopes.email,
                            AppleIDAuthorizationScopes.fullName,
                          ],
                          nonce: nonce,
                        );

                        print(appleCredential.authorizationCode);

                        // Create an `OAuthCredential` from the credential returned by Apple.
                        final oauthCredential = OAuthProvider("apple.com")
                            .credential(
                          idToken: appleCredential.identityToken,
                          rawNonce: rawNonce,
                        );

                        // Sign in the user with Firebase. If the nonce we generated earlier does
                        // not match the nonce in `appleCredential.identityToken`, sign in will fail.
                        final authResult =
                        await _firebaseAuth.signInWithCredential(
                            oauthCredential);

                        final displayName =
                            '${appleCredential.givenName} ${appleCredential
                            .familyName}';
                        final userEmail = '${appleCredential.email}';
                        final photoUrl = '${appleCredential.identityToken}';
                        if (appleCredential.email != null &&
                            appleCredential.givenName != null &&
                            appleCredential.familyName != null &&
                            appleCredential.identityToken != null) {
                          authController.appleSignIn(
                              userEmail, photoUrl);
                        }
                        else {
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
                    }


                ),
              ) :
              SizedBox(),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    debugPrint(googleUser?.email);
    if (googleUser != null) {
      // Get the authentication token
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      authController.appleRegister(
          googleUser.email, googleUser.id, googleUser.photoUrl.toString(),
          googleUser.displayName.toString());
    }
  }
}

